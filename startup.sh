#!/bin/sh -e

vgscan --mknodes

for i in $(env | grep ^LVM_ | cut -d'=' -f2 | cut -d' ' -f1 | sort -u); do
  vgchange -a y $i
done

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in $(env | grep ^LVM_ | cut -d'=' -f2-); do
  VG="$(echo $i | cut -d' ' -f1)"
  LV="$(echo $i | cut -d' ' -f2)"
  MOUNT="$(echo $i | cut -d' ' -f3)"

  mkdir -p /media/${MOUNT}
  echo "mount /dev/${VG}/${LV} /media/${MOUNT}"
  mount /dev/${VG}/${LV} /media/${MOUNT}
done
IFS=$SAVEIFS
