#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y upgrade
apt-get -y install git nano -y
apt-get -y install software-properties-common -y
apt-get -y install ffmpeg -y
apt-get -y install exiftool -y
# the following will install imagemagick-6 and associated tools
apt-get -y install imagemagick imagemagick-common -y
# the following lines will overwrite imagemagick with version 7 and install within image
git clone https://github.com/SoftCreatR/imei
cd imei
./imei.sh
# following lines modifiy the policy.xml file to allow PDF
cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak
sed -i "s/rights\=\"none\" pattern\=\"PS\"/rights\=\"read\|write\" pattern\=\"PS\"/" /etc/ImageMagick-6/policy.xml
sed -i "s/rights\=\"none\" pattern\=\"EPI\"/rights\=\"read\|write\" pattern\=\"EPI\"/" /etc/ImageMagick-6/policy.xml
sed -i "s/rights\=\"none\" pattern\=\"PDF\"/rights\=\"read\|write\" pattern\=\"PDF\"/" /etc/ImageMagick-6/policy.xml
sed -i "s/rights\=\"none\" pattern\=\"XPS\"/rights\=\"read\|write\" pattern\=\"XPS\"/" /etc/ImageMagick-6/policy.xml
apt-get clean
rm -rf /var/lib/apt/lists/*