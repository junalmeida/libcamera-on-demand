# On demand stream from libcamera into V4L2 virtual cam

On Linux, browsers and video conference applications doesn't connect to libcamera devices.

`libcamera-on-demand` is a script, intended to run as systemd unit service, which watches for connecting
V4L2 virtual webcam clients and when one appears, it starts streaming from gstreamer into virtual webcam used by other applications.

Script should be CPU-friendly as the stream will only run when webcam is in use.

## Installation

Follow the steps below: 

1. Install [libcamera](docs/libcamera.md)
2. Install `v4l2loopback`. In Debian/Ubuntu there should be a `v4l2loopback-dkms` package.
3. Install `ffmpeg`
4. Install `inotify-tools`
4. Run `bash install.sh`


## Configuration

See available environment variables in [libcamera-on-demand](libcamera-on-demand) file.

You can modify them by editing the systemd unit or creating a drop-in for it using the command below:

```sh
systemctl --user edit libcamera-on-demand.service
```

Then, write to it something like like:

```
[Service]
Environment="V4L2_DEVICE_FILTER='USB  Live camera: USB  Live cam'"
```

## Testing

To verify the script works, you can see it logs:

```sh
journalctl --user -u libcamera-on-demand.service -f
```

And open the webcam using any application like a web meeting application in a Chromium-based browser. Remember to select `Virtual Front Camera` device.



# Credits

This project is based on [invidian/webcam-on-demand](https://github.com/invidian/webcam-on-demand) and the wiki of [linux-surface](linux-surface)
