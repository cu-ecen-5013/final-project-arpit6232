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

int main(int argc, char* argv[]) {

    openlog(NULL, 0, LOG_USER);

    int rc = 0;
        
    /* Grant Access to GPIO pins */
    system ("echo 79 > /sys/class/gpio/export");

    /* Set GPIO direction */
    system ("echo out > /sys/class/gpio/gpio79/direction");

    /* Light up LED Logic */
    if(argv[1] == "n") {
        system ("echo 1 > /sys/class/gpio/gpio79/value");
    } else if(argv[1] == "f") { /* Power off LED Logic */
        system ("echo 0 > /sys/class/gpio/gpio79/value");
    } else {
        printf("Invalid GPIO option\n");
        syslog(LOG_ERR, "Invalid State option for GPIO");
    }
}
