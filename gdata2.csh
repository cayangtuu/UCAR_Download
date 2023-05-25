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

#set RDAPSWD=dejavu31
set pswd = $1
if(x$pswd == x && `env | grep RDAPSWD` != '') then
 set pswd = $RDAPSWD
endif
if(x$pswd == x) then
 echo
 echo Usage: $0 YourPassword
 echo
 exit 1
endif
set v = `wget -V |grep 'GNU Wget ' | cut -d ' ' -f 3`
set a = `echo $v | cut -d '.' -f 1`
set b = `echo $v | cut -d '.' -f 2`
if(100 * $a + $b > 109) then
 set opt = 'wget --no-check-certificate'
else
 set opt = 'wget'
endif
set opt1 = '-O Authentication.log --save-cookies auth.rda_ucar_edu --post-data'
set opt2 = "email=koala1995610@gmail.com&passwd=$pswd&action=login"
$opt $opt1="$opt2" https://rda.ucar.edu/cgi-bin/login
set opt1 = "-N --load-cookies auth.rda_ucar_edu"
set opt2 = "$opt $opt1 https://rda.ucar.edu/data/ds083.2/"

#set tmstart = starting date of the file to download (ex. 20200601)
#set tmend = ending date of the file to download (ex. 20200630)
set tmstart = $2
set tmend = $3
set vlstart = `date -d $tmstart +%s`
set vlend = `date -d $tmend +%s`
while ($vlstart <= $vlend)
    set yr = `date --date="$tmstart" +%Y`
    set mn = `date --date="$tmstart" +%m`

    set filelist = ( \
    "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_00_00.grib2" \
    "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_06_00.grib2" \
    "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_12_00.grib2" \
    "grib2/"$yr"/"$yr"."$mn"/fnl_"$tmstart"_18_00.grib2" \
)
    while($#filelist > 0)
      set syscmd = "$opt2$filelist[1]"
      echo "$syscmd ..."
      $syscmd
      shift filelist
    end

    set tmstart = `date --date="$tmstart"+1days +%Y%m%d`
    set vlstart = `date -d $tmstart +%s`
end


