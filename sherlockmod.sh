#!/bin/sh  
########################################################################################################################
PACKAGE_DIR='Sherlockmod/raw/main/'
MY_IPK="enigma2-plugin-extensions-sherlockmod_1.4.2_all.ipk"
MY_DEB="enigma2-plugin-extensions-sherlockmod_1.4.2_all.deb"
########################################################################################################################
MY_MAIN_URL="https://github.com/tarekzoka/"
if which dpkg > /dev/null 2>&1; then
	MY_FILE=$MY_DEB
	MY_URL=$MY_MAIN_URL$PACKAGE_DIR$MY_DEB
else
	MY_FILE=$MY_IPK
	MY_URL=$MY_MAIN_URL$PACKAGE_DIR$MY_IPK
fi
MY_TMP_FILE="/var/volatile/tmp/"$MY_FILE
#########################################################

MY_SEP='============================================================='
echo $MY_SEP
echo 'Downloading '$MY_FILE' ...'
echo $MY_SEP
echo ''

wget -T 2 $MY_URL -P "/var/volatile/tmp/"

rm -rf "/usr/lib/enigma2/python/Plugins/Extensions/Sherlockmod"


if [ -f $MY_TMP_FILE ]; then

	echo ''
	echo $MY_SEP
	echo 'Installation started'
	echo $MY_SEP
	echo ''
	if which dpkg > /dev/null 2>&1; then
		apt-get install --reinstall $MY_TMP_FILE -y
	else
		opkg install --force-reinstall $MY_TMP_FILE
	fi
	MY_RESULT=$?

	rm -f $MY_TMP_FILE > /dev/null 2>&1

	echo ''
	if [ $MY_RESULT -eq 0 ]; then
        echo "########################################################################"
        echo "#              Sherlockmod V1.4.2 INSTALLED SUCCESSFULLY               #"
        echo "#                        BY Biko - support on                          #"
        echo "#              https://www.tunisia-sat.com/forums/forums               #"
        echo "########################################################################"
        echo "#       Sucessfully Downloaded Please apply from plugin browser        #"
        echo "########################################################################"
		if which systemctl > /dev/null 2>&1; then
			sleep 2; systemctl restart enigma2
		else
			init 4
			sleep 4 > /dev/null 2>&1
			init 3
		fi
	else
		echo "   >>>>   INSTALLATION FAILED !   <<<<"
	fi;
	 echo '**************************************************'
	 echo '**                   FINISHED                   **'
	 echo '**************************************************'
	 echo ''
	 exit 0
else
	 echo ''
	 echo "Download failed !"
	 exit 1
fi
# ----------------------------------------------------------------------------------------------------------
