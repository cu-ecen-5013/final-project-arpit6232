#include <linux/module.h>

#include <net/cfg80211.h>
#include <linux/skbuff.h>

#include <linux/workqueue.h>

#include <cfg

#include <semaphore.h>

#define WIPHY_NAME "navifly"
#define NDEV_NAME "navifly%d"
#define SSID_DUMMY "MyAwesomeWifi"
#define SSID_DUMMY_SIZE (sizeof("MyAwesomeWifi") - 1)

struct navifly_context {
    struct wiphy *wiphy;
    struct net_device *ndev;

    struct semaphore sem;
    struct work_struct ws_connect;
    char connecting
}

int main() {

    printf("Hello World\n");

    return 0;
}
