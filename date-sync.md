# To sync the time on Jetson Nano 

1. Download the date-sync file to /etc/network/if-up.d/ folder.
```
sudo wget -O /etc/network/if-up.d/date-sync https://raw.githubusercontent.com/cu-ecen-5013/final-project-arpit6232/reset_jetson_time/date-sync
```

2. Add excutable attribute to the ``` /etc/network/if-up.d/date-sync ```
```
sudo chmod +x /etc/network/if-up.d/date-sync
```
