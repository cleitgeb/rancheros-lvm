#!/bin/sh

vgscan --mknodes

for i in $(vgs --reportformat json | jq -r '.report[].vg[].vg_name'); do
  vgchange -a y $i
done

for i in $(env | grep ^LVM_ | cut -d'=' -f2-); do
  VG="$(echo $i | cut -d';' -f1)"
  LV="$(echo $i | cut -d';' -f2)"
  MOUNT="$(echo $i | cut -d';' -f3)"

  mkdir -p ${MOUNT}
  echo "mount /dev/${VG}/${LV} ${MOUNT}"
  mount /dev/${VG}/${LV} ${MOUNT}
done
