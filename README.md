# containered-pi-webcam
This container will run on a raspberry pi 3 b device with native camera enabled. It will capture a live video and present it via webrtc on a basic website.

## usage
### starting the container
```
docker run --rm \
--device /dev/video0 \
--volume /opt/vc:/opt/vc \
--user $(id -u):$(id -g) \
--port 8080:80 \
container_pi_webcam
```
Afterwards, you can access the webcam on port 8080 of the host.

### Breakdown
Partially stolen from https://www.losant.com/blog/how-to-access-the-raspberry-pi-camera-in-docker.
- `--device /dev/video0` -> passthrough camera device
- `--volume /opt/vc:/opt/vc` -> camera dependencies
- `--env LD_LIBRARY_PATH=/opt/vc/lib` -> set dependencies-libs path as env var
- `--user $(id -u):$(id -g)` -> set user to current user, because `pi` is a member of the video group and has thereby access to the device
- `--port 8080:80` -> Forward external host port to container
