# sensorian-deploy-script
Configures a Raspberry Pi running Raspbian OS for the (SOFE 4610) IoT Course


Usage
-----

- Clone this repository on the Raspberry Pi

```bash
git clone https://github.com/IntegralProgrammer/sensorian-deploy-script
```

- Copy `build_rpi.sh` to the `/home/pi` directory

```bash
cp sensorian-deploy-script/build_rpi.sh /home/pi
```

- Make the script executable

```bash
chmod u+x build_rpi.sh
```

- Execute the script

```bash
./build_rpi.sh
```

- Sensorian LED will be blinking if installation was successful.
