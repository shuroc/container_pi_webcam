#!bin/bash

### notes
echo "Make sure you have the camera module enabled and restarted afterwards."
echo "To test this look at 'ls /dev/video*' or try to make an image via 'raspistill -v -o test.jpg'."


### install packages
apt-get install motion -y

chown motion:motion /var/lib/motion

modprobe bcm2835-v4l2

### get information from camera
v4l2-ctl -V

# ls /dev/video* should now list a video0 device
#   if not, try rebooting (make sure modprobe is still active afterwards)
#   also make sure you have activated the raspicam module in 'raspi-config'

### test the camera with
raspistill -v -o test.jpg
# in raspi directly (not ssh) the image is shown for a short duration.

nano /etc/motion/motion.conf
# set width 1024
# set height 768
# set framerate 60
# set auto brightness on
# check stream_port 8081
# check stream_motion off
# check output_motion off
# check daemon on
# check quality 75
# set stream_localhost off
#! stream_auth_method 0 -> 1/2
#! stream_authentication username:password


nano /etc/default/motion
# set start_motion_daemon=yes