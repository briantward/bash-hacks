#!/bin/bash

# drop this script in the folder of images where you need to update the image date
# requires exiftool (duh...)
# slow as it opens and writes the file many times, but could be optimized perhaps...

NEW_DATE=2020:11:25

echo "new date is...: "$NEW_DATE

for file in $(ls *.jpg)
do
  existing_time=$(exiftool -EXIF:DateTimeOriginal $file | grep -o -P "\d.*$" | cut -c11-19)
  #echo "replacing existing EXIF values with: "$NEW_DATE$existing_time
  exiftool -q -overwrite_original -EXIF:DateTimeOriginal="$NEW_DATE$existing_time" $file &> /dev/null
  exiftool -q -overwrite_original -EXIF:CreateDate="$NEW_DATE$existing_time" $file &> /dev/null
  #echo "replacing existing IPTC values with: "$NEW_DATE
  exiftool -q -overwrite_original -IPTC:DigitalCreationDate="$NEW_DATE" $file &> /dev/null
  exiftool -overwrite_original -IPTC:DateCreated="$NEW_DATE" $file &> /dev/null
  existing_time_s=$(exiftool -XMP:CreateDate $file | grep -o -P "\d.*$" | cut -c11-22)
  #echo "replacing existing XMP values with: "$NEW_DATE$existing_time_s
  exiftool -q -overwrite_original -XMP:CreateDate="$NEW_DATE$existing_time_s" $file &> /dev/null
  exiftool -q -overwrite_original -XMP:DateCreated="$NEW_DATE$existing_time_s" $file &> /dev/null
done;
