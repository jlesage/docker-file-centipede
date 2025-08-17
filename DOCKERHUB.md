# Docker container for File Centipede
[![Release](https://img.shields.io/github/release/jlesage/docker-file-centipede.svg?logo=github&style=for-the-badge)](https://github.com/jlesage/docker-file-centipede/releases/latest)
[![Docker Image Size](https://img.shields.io/docker/image-size/jlesage/file-centipede/latest?logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/file-centipede/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/jlesage/file-centipede?label=Pulls&logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/file-centipede)
[![Docker Stars](https://img.shields.io/docker/stars/jlesage/file-centipede?label=Stars&logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/file-centipede)
[![Build Status](https://img.shields.io/github/actions/workflow/status/jlesage/docker-file-centipede/build-image.yml?logo=github&branch=master&style=for-the-badge)](https://github.com/jlesage/docker-file-centipede/actions/workflows/build-image.yml)
[![Source](https://img.shields.io/badge/Source-GitHub-blue?logo=github&style=for-the-badge)](https://github.com/jlesage/docker-file-centipede)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg?style=for-the-badge)](https://paypal.me/JocelynLeSage)

This is a Docker container for [File Centipede](https://filecxx.com).

The graphical user interface (GUI) of the application can be accessed through a
modern web browser, requiring no installation or configuration on the client

---

[![File Centipede logo](https://images.weserv.nl/?url=raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/file-centipede-icon.png&w=110)](https://filecxx.com)[![File Centipede](https://images.placeholders.dev/?width=448&height=110&fontFamily=monospace&fontWeight=400&fontSize=52&text=File%20Centipede&bgColor=rgba(0,0,0,0.0)&textColor=rgba(121,121,121,1))](https://filecxx.com)

File centipede is an All-In-One internet file upload/download manager, BitTorrent
Client, WebDAV client, FTP client, and SSH client. It is designed to be fast,
customizable, and user-friendly. It supports multi-protocols and contains many
useful auxiliary tools such as HTTP requester, file merge, and encoders. With the
browser integration, you can download audio and videos from websites, even encrypted
videos.

---

## Quick Start

**NOTE**:
    The Docker command provided in this quick start is an example, and parameters
    should be adjusted to suit your needs.

Launch the File Centipede docker container with the following command:
```shell
docker run -d \
    --name=file-centipede \
    -p 5800:5800 \
    -p 10111:10111 \
    -p 17654:17654/tcp \
    -p 17654:17654/udp \
    -v /docker/appdata/file-centipede:/config:rw \
    -v /home/user:/storage:ro \
    -v /home/user/Downloads:/output:rw \
    jlesage/file-centipede
```

Where:

  - `/docker/appdata/file-centipede`: Stores the application's configuration, state, logs, and any files requiring persistency.
  - `/home/user`: Contains files from the host that need to be accessible to the application.
  - `/home/user/Downloads`: This is where downloaded files are stored.

Access the File Centipede GUI by browsing to `http://your-host-ip:5800`.
Files from the host appear under the `/storage` folder in the container.

## Documentation

Full documentation is available at https://github.com/jlesage/docker-file-centipede.

## Support or Contact

Having troubles with the container or have questions? Please
[create a new issue](https://github.com/jlesage/docker-file-centipede/issues).

For other Dockerized applications, visit https://jlesage.github.io/docker-apps.
