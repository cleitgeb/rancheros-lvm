# Purpose

This RancherOS system-docker container was built to add LVM support to RancherOS and add mount LVM-Volumes automatically at startup.

Feel free to fork the Repo and adapt it to your needs - i also forked it from Melvyndekort.

# How to install?

Add a service to your `cloud-config.yml` like the following example:

    #cloud-config
    rancher:
      services:
        lvm:
          image: melvyndekort/rancheros-lvm:1.3
          labels:
            io.rancher.os.after: console, preload-user-images
            io.rancher.os.scope: system
          privileged: true
          restart: always
          volumes:
            - /media:/media:shared
          environment:
            LVM_WDRED_3TB: wdred_3tb;datastore1;/media/wdred_3tb
            LVM_DATEN_2TB: daten_2tb;datastore2;/media/daten_2tb

This configuration will mount the LV `/dev/wdred_3tb/datastore1` to the `/media/wdred_3tb` folder. You can add more volumes following the same schema (e.g. LVM_DATEN_2TB).
