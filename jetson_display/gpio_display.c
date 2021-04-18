#include <stdio.h>
#include <stdbool.h>
#include <stdarg.h>
#include <syslog.h>

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <string.h>
#include <linux/limits.h>

bool do_gpio() {

    int rc;
        
    /* Grant Access to GPIO pins */
    rc = system ("sudo echo 79 > /sys/class/gpio/export");
    if(rc<1) {
        syslog(LOG_ERR, "gpio79 access failed");
        return false;
    } else {
        syslog(LOG_INFO, "gpio79 access granted");
    }

    /* Set GPIO direction */
    rc = system ("sudo echo out > /sys/class/gpio/gpio79/direction");
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
    rc = system ("sudo echo 1 > /sys/class/gpio/gpio79/value");
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
    rc = system ("sudo echo 0 > /sys/class/gpio/gpio79/value");
    if(rc<1) {
        syslog(LOG_ERR, "GPIO79 - LED Failed to turn OFF");
        return false;
    } else {
        syslog(LOG_INFO, "LED Light off");
    }
}

int main(int argc, char* argv[]) {

    openlog(NULL, 0, LOG_USER);

    int rc = 0;
        
    /* Grant Access to GPIO pins */
    rc = system ("sudo echo 79 > /sys/class/gpio/export");
    if(rc<1) {
        syslog(LOG_ERR, "gpio79 access failed");
        return false;
    } else {
        syslog(LOG_INFO, "gpio79 access granted");
    }

    /* Set GPIO direction */
    rc = system ("sudo echo out > /sys/class/gpio/gpio79/direction");
    if(rc<1) {
        syslog(LOG_ERR, "Unable to set gpio79 direction to out");
        return false;
    } else {
        syslog(LOG_INFO, "gpio79 Pin set to Out direction");
    }

    /* Light up LED Logic */
    if(strcmp(argv[2],"on") == 0) {
        rc = light_up_led();
        if(rc == 0) {
            printf("Unable to Lightup LED\n");
        }
    } else if(strcmp(argv[2],"off") == 0) { /* Power off LED Logic */
        rc = light_down_led();
        if(rc == 0) {
            printf("Unable to Lightup LED\n");
        }
    } else {
        printf("Invalid GPIO option\n");
        syslog(LOG_ERR, "Invalid State option for GPIO");
    }
}
