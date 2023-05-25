#!/bin/csh
#################################################################
# Csh Script to retrieve 11 online Data files of 'ds083.2',
# total 188.05M. This script uses 'wget' to download data.
#
# Highlight this script by Select All, Copy and Paste it into a file;
# make the file executable and run it on command line.
#
# You need pass in your password as a parameter to execute
# this script; or you can set an evnironment variable RDAPSWD
# if your Operating System supports it.
#
# Contact manross@ucar.edu (Kevin Manross) for further assistance.
#################################################################

#read -p "Please input the 'start time' of the file (ex.20200101): " tmstart
#read -p "Please input the 'end time' of the file: " tmend
set tmstart = $1
set tmend = $2
set vlstart = `date -d $tmstart +%s`
set vlend = `date -d $tmend +%s`
while ($vlstart <= $vlend)
    set yr = `date --date="$tmstart" +%Y`
    set mn = `date --date="$tmstart" +%m`

    echo "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_00_00.grib2"
    set filelist = ( \
    "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_00_00.grib2" \
    "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_08_00.grib2" \
    "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_12_00.grib2" \
    "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_18_00.grib2" \
)
    set tmstart = `date --date="$tmstart"+1days +%Y%m%d`
    set vlstart = `date -d $tmstart +%s`
end



#date_d=`echo $date2 |grep '[0-9]\{8\}'`
#if [ "$date_d" == "" ]; then
#	echo "You input the wrong format of date...."
# 	exit 1
#fi

#read -p "Please input the 'start time' of the file (ex.20200101): " tmstart
#read -p "Please input the 'end time' of the file: " tmend

#vlstart=`date -d $tmstart +%s`
#vlend=`date -d $tmend +%s`

#while [ "$(($vlstart-$vlend))" -le "0" ]
#  do
#    yr=`date --date="$tmstart" +%Y`
#    mn=`date --date="$tmstart" +%m`
#    echo "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_"00"_00.grib2"
#    tmstart=`date --date="$tmstart"+1days +%Y%m%d`
#    vlstart=`date -d $tmstart +%s`
#  done
#set filelist = ( \
#  "grib2/"$yr"/"$yr"."$mn"/fnl_"$timestart"_00_00.grib2" \
#  "grib2/"$yr"/"$yr"."$mn"/fnl_"$timestart"_08_00.grib2" \
#  "grib2/"$yr"/"$yr"."$mn"/fnl_"$timestart"_12_00.grib2" \
#  "grib2/"$yr"/"$yr"."$mn"/fnl_"$timestart"_18_00.grib2" \
#)
