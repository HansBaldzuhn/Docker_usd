#!/usr/bin/env bash
set -e

# create build dir
mkdir -p $DOWNLOADS_DIR

# Code to download a google drive file with wget, thanks to MATT HUISMAN
# https://www.matthuisman.nz/2019/01/download-google-drive-files-wget-curl.html

export fileid=1tWfT2xAbbZ0aXyzCcle1MSSR4iriwNET
export filename=Maya2019_DEVKIT_Linux.tgz

if [ ! -f $DOWNLOADS_DIR/$filename ]; then
	## WGET ##
	wget --save-cookies cookies.txt 'https://docs.google.com/uc?export=download&id='$fileid -O- \
	     | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1/p' > confirm.txt
	
	wget --load-cookies cookies.txt -O "$DOWNLOADS_DIR/$filename" \
	     'https://docs.google.com/uc?export=download&id='$fileid'&confirm='$(<confirm.txt)
fi