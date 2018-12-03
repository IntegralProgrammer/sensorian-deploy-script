#!/bin/bash

#Constants
checksum_sha512_bcm2835="d1f006614cb1f95e1a6c33081e3a932984d54b00f535d6b7ccde774ff59ac40a858c5f7822e6f5103d207cacf8ee0a8325c2d36673607b54b4fdcdb090209c25"

#APT packages
sudo apt-get update || { echo "APT update failed. Check Internet connection" && exit; }
sudo apt-get -y install build-essential || { echo "Failed to install build essential" && exit; }
sudo apt-get -y install python-smbus || { echo "Failed to install python-smbus" && exit; }

#Download BCM2835 library
echo "Downloading bcm2835"
wget www.airspayce.com/mikem/bcm2835/bcm2835-1.44.tar.gz -O bcm2835-1.44.tar.gz || { echo "Failed to download bcm2835 library" && exit; }

#Verify the SHA512 Hash
bcm2835_sha512=$(sha512sum bcm2835-1.44.tar.gz | head -c 128)

if [ "$bcm2835_sha512"=="$checksum_sha512_bcm2835" ]
	then
		echo "Checksum verification PASSED"
	else
		echo "Checksum verification FAILED. Something went wrong while downloading bcm2835-1.44.tar.gz"
		echo "Exiting..."
		exit
fi

echo "Extracting the downloaded file"
tar -zxvf bcm2835-1.44.tar.gz

#Compile
echo "Building BCM2835 library"
cd bcm2835-1.44
./configure
sudo make check
sudo make install

#create libbcm2835.so
cc -shared src/bcm2835.o -o src/libbcm2835.so
sudo cp -p src/libbcm2835.so /usr/lib/

#Install sensorian-firmware
cd ~
git clone https://github.com/sensorian/sensorian-firmware

#Build an example
cd ~/sensorian-firmware/Drivers_C/LED/Example1
make || { echo "Failed to build LED demo" && exit; }

#Test the LED
echo "Running the LED DEMO. Press CTRL+C to exit and continue installation"
sudo ./GPIO

#At this point, everything should be installed.
echo "Sensorian should now be configured. Enjoy!"
