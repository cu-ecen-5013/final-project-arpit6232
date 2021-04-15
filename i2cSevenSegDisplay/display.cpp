#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <time.h>
#include <stdbool.h>
#include <stdarg.h>
#include<syslog.h>

#include "JHLEDBackpack.h"

bool do_gpio() {

    int rc;
        
    /* Grant Access to GPIO pins */
    rc = system ("echo 79 > /sys/class/gpio/export");
    if(rc<1) {
        syslog(LOG_ERR, "gpio79 access failed");
        return false;
    } else {
        syslog(LOG_INFO, "gpio79 access granted");
    }

    /* Set GPIO direction */
    rc = system ("echo out > /sys/class/gpio/gpio79/direction");
    if(rc<1) {
        syslog(LOG_ERR, "Unable to set gpio79 direction to out");
        return false;
    } else {
        syslog(LOG_INFO, "gpio79 Pin set to Out direction");
    }

    return true;
}

bool light_up_led() {
    int rc;
    rc = system ("echo 1 > /sys/class/gpio/gpio79/value");
    if(rc<1) {
        syslog(LOG_ERR, "GPIO79 - LED failed to light on");
        return false;
    } else {
        syslog(LOG_INFO, "LED Light on");
    }
    return true;
}

bool light_down_led() {
    int rc;
    rc = system ("echo 0 > /sys/class/gpio/gpio79/value");
    if(rc<1) {
        syslog(LOG_ERR, "GPIO79 - LED Failed to turn OFF");
        return false;
    } else {
        syslog(LOG_INFO, "LED Light off");
    }
}

HT16K33* do_sevenseg() {
    int rc;

    HT16K33 *displayMatrix = new HT16K33() ;
    // Default I2C Bus 1
    rc = displayMatrix->openHT16K33(); 
    if(rc < 0) {
        return NULL;
        printf("Error: %d", displayMatrix->error);
    }

    return displayMatrix;
}

bool light_one_sevenseg(HT16K33 *displayMatrix) {

    displayMatrix->printFloat(1.000,3,DEC);
    displayMatrix->writeDisplay();

    /**
     * Stay long enough to make it visible
     * TODO: Optmize it to prevent IDLE system time
     */
    sleep(3);

    // Turn off the display oscillator
    displayMatrix->end() ;
    displayMatrix->closeHT16K33();

    return true;
}

bool light_zero_sevenseg(HT16K33 *displayMatrix) {

    displayMatrix->printFloat(0.000,3,DEC);
    displayMatrix->writeDisplay();

    /**
     * Stay long enough to make it visible
     * TODO: Optmize it to prevent IDLE system time
     */
    sleep(3);

    // Turn off the display oscillator
    displayMatrix->end() ;
    displayMatrix->closeHT16K33();

    return true;
}

int main(int argc, char* argv[]) {

    openlog(NULL, 0, LOG_USER);
    int rc = 0;
    
    if(argv[1],"help") {
        printf("./display type status\n");
        printf("type = gpio OR sevenseg\n");
        printf("if type = gpio\n");
        printf("status = on OR off \n");
        printf("if type = sevenseg\n");
        printf("status = one OR zero \n");
        printf(" ** EXAMPLE 1 ** \n");
        printf("./display gpio on\n");
        printf(" ** EXAMPLE 2 ** \n");
        printf("./display gpio off\n");
        printf(" ** EXAMPLE 3 ** \n");
        printf("./display sevenseg 1\n");
        printf(" ** EXAMPLE 4 ** \n");
        printf("./display sevenseg 0\n");
        return 0;
    } else if(strcmp(argv[1],"gpio")) {
        
        /* Setup GPIO system calls */
        rc = do_gpio();
        if(rc == 0) {
            printf("GPIO Instatiation failed in main\n");
            return -1;
        }

        /* Light up LED Logic */
        if(strcmp(argv[2],"on")) {
            rc = light_up_led();
            if(rc == 0) {
                printf("Unable to Lightup LED\n");
            }
        } else if(strcmp(argv[2],"off")) { /* Power off LED Logic */
            rc = light_down_led();
            if(rc == 0) {
                printf("Unable to Lightup LED\n");
            }
        } else {
            printf("Invalid GPIO option\n");
            syslog(LOG_ERR, "Invalid State option for GPIO");
        }

    } else if(strcmp(argv[1],"sevenseg")) {

        /* Setup Seven segment display function calls */
        HT16K33 *displayMatrix = do_sevenseg();
        if(displayMatrix == NULL) {
            printf("Sevenseg Instatiation failed in main\n");
            return -1;
        }

        /* Display 1 on Seven segment display Logic */
        if(strcmp(argv[2],"one")) {
            rc = light_one_sevenseg(displayMatrix);
            if(rc == 0) {
                printf("Unable to Lightup LED\n");
            }
        } else if(strcmp(argv[2],"zero")) { /* Display 0 on Seven segment display Logic */
            rc = light_zero_sevenseg(displayMatrix);
            if(rc == 0) {
                printf("Unable to Lightup LED\n");
            }
        } else {
            printf("Invalid Seven segment option\n");
            syslog(LOG_ERR, "Invalid State option for Sevens Segment");
        }

    } else {
        printf("1st Argument should specify 'gpio' or 'sevenseg' \r\n ");
        syslog(LOG_ERR, "Display Method not selected");
    }
}
