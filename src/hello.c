#include<stdio.h>
#include<sys/syslog.h> 

int main()
{
     // Open Log Facility 
    openlog(NULL, 0, LOG_USER);

    syslog(LOG_DEBUG, "Arduino_cli setup");
    return 0;
}
