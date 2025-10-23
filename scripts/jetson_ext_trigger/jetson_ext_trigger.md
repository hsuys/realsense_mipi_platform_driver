
# Jetson Dev Kit External Trigger

## About

Use Nvidia Jetson AGX Xavier/Orin Dev Kit to generate external trigger used for hardware sync signal. 
```Pre-req
NVidia AGX Xavier or Orin Dev Kit
[Optional] Oscilloscope - To verify the trigger signal
``` 


## Setup

* Enable pin #18 from the 40-pin Head on the Jetson ORIN/AGX J30 Expansion PINOUT
  
  Run jetson-io.py 
  
  sudo /opt/nvidia/jetson-io/jetson-io.py

* Install Jetson GPIO library on the Jetson

https://github.com/NVIDIA/jetson-gpio

* Download following scripts to local directory:
  
  rs-d457-hw-sync.sh 
  
  rs-trigger-generator.py

## Usage

* Configure pin#18 to output trigger at 30.0085HZ:
  ```shell
  rs-d457-hw-sync.sh [fps]
  ./rs-d457-hw-sync.sh 30.0085
  ```

  Change [fps] to change the trigger output frequency.
  Modify the script to generate external trigger for other pins, e.g., pin#15

  
## Reference

MAX9296/MAX9295 HW-SYNC Configuration setting:
https://github.com/IntelRealSense/realsense_mipi_platform_driver/blob/master/scripts/SerDes_D457.sh#L175

## Change the pwm Period and duty cycle manually 

* Configure the PWM on System Without jetson-gpio Library 

  ```shell
  rs-trigger.sh [pin-id] [period] [duty-cycle]
  The units are in nanoseconds

  e.g.,
  rs-trigger.sh 18 33333330 16666666

  This configures the pin 18 pwm of period to 33.33333 ms, 50% duty cycle  
  ```shell
