# libcamera Support



### Install libcamera from repositories

Some flavours of Linux have repositories containing versions of libcamera, which you can install without building libcamera from source.

#### Fedora


```
sudo dnf install libcamera libcamera-tools libcamera-qcam libcamera-gstreamer libcamera-ipa pipewire-plugin-libcamera
```

If you're using an immutable variant of Fedora (Silverblue, Kinoite,Sericea, etc), you should use `rpm-ostree`:

```
rpm-ostree install libcamera libcamera-tools libcamera-qcam libcamera-gstreamer libcamera-ipa pipewire-plugin-libcamera
```

#### Arch Linux

Arch now ships a stable `libcamera` package (`pacman -S libcamera`). You may also want to install the following packages:
- `libcamera-tools` for `cam` and `qcam`
- `gst-plugin-libcamera` for the gstreamer libcamera plugin (required to use applications that don't directly support libcamera)


### Build libcamera from the latest git source

Both clang and gcc are supported compilers.

First install the required dependencies (e.g. on Debian/Ubuntu, **a '\\' denotes the line is continued**)

```
sudo apt install \
    build-essential meson ninja-build pkg-config libgnutls28-dev openssl \
    python3-pip python3-yaml python3-ply python3-jinja2 \
    qtbase5-dev libqt5core5a libqt5gui5 libqt5widgets5 qttools5-dev-tools \
    libtiff-dev libevent-dev libyaml-dev \
    gstreamer1.0-tools libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
```

And now obtain and build libcamera:
```
sudo apt install git
git clone https://git.libcamera.org/libcamera/libcamera.git
cd libcamera
```

Configure libcamera minimally
```
meson build -Dpipelines=uvcvideo,vimc,ipu3 -Dipas=vimc,ipu3 -Dprefix=/usr -Dgstreamer=enabled -Dv4l2=true -Dbuildtype=release

ninja -C build

sudo ninja -C build install
```

### Test with 'cam'

Now you can run cam --list and you should see the sensor listed

``` 
cam --list
```

```
Available cameras:
1: Internal front camera (\*SB*.PCI0.LNK1)
```