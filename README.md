# Purpose

This RancherOS system-docker container was built to add LVM support to RancherOS.

# How to install?

Add a service to your `cloud-config.yml` like the following example:

    #cloud-config
    rancher:
      services:
        lvm:
          image: melvyndekort/lmserver-lvm:1.0
          labels:
            io.rancher.os.after: console, preload-user-images
            io.rancher.os.scope: system
          privileged: true
          restart: always
          volumes:
            - /media:/media:shared
          environment:
            LVM_FOOBAR: myvg;mylv;/media/foobar

This configuration will mount the LV `/dev/myvg/mylv` to the `/media/foobar` folder.
