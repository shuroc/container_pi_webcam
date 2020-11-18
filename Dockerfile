FROM tillhoff/debian


RUN apt-get install -y motion

RUN sed -i "s|^width .*|width 1024|" /etc/motion/motion.conf && \
    sed -i "s|^height .*|height 768|" /etc/motion/motion.conf && \
    sed -i "s|^framerate .*|framerate 30|" /etc/motion/motion.conf && \
    sed -i "s|^autobrightness .*|autobrightness on|" /etc/motion/motion.conf && \
    sed -i "s|^stream_port .*|stream_port 80|" /etc/motion/motion.conf && \
    sed -i "s|^stream_motion .*|stream_motion=off|" /etc/motion/motion.conf && \
    #sed -i "s|^output_motion=.*|output_motion=off|" /etc/motion/motion.conf && \
    sed -i "s|^quality .*|quality 75|" /etc/motion/motion.conf && \
    sed -i "s|^stream_quality .*|stream_quality 75|" /etc/motion/motion.conf && \
    sed -i "s|^stream_localhost .*|stream_localhost off|" /etc/motion/motion.conf
    #! stream_auth_method 0 -> 1/2
    #! stream_authentication username:password

EXPOSE 80/tcp

# test camera access
CMD (/opt/vc/bin/raspistill -vf -hf -o output.jpg || \
    echo "Make sure to enable the camera: 'modprobe bcm2835-v4l2'\nYou can get information about the camera with 'v4l2-ctl -V'\n'ls /dev/video*' should now list a video0 device. If not if not, try rebooting (make sure modprobe is still active afterwards). Also make sure you have activated the raspicam module in 'raspi-config'.") && \
    motion
