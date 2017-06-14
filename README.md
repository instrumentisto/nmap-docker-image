Nmap Docker Image
=================

[![GitHub release](https://img.shields.io/github/release/instrumentisto/nmap-docker-image.svg)](https://hub.docker.com/r/instrumentisto/nmap/tags)
[![Build Status](https://travis-ci.org/instrumentisto/nmap-docker-image.svg?branch=master)](https://travis-ci.org/instrumentisto/nmap-docker-image)
[![Docker Pulls](https://img.shields.io/docker/pulls/instrumentisto/nmap.svg)](https://hub.docker.com/r/instrumentisto/nmap)
[![Based on](https://img.shields.io/badge/based%20on-alpine-blue.svg)][12]




## What is Nmap?

Nmap ("Network Mapper") is a free and open source ([license][91]) utility for network discovery and security auditing. Many systems and network administrators also find it useful for tasks such as network inventory, managing service upgrade schedules, and monitoring host or service uptime. Nmap uses raw IP packets in novel ways to determine what hosts are available on the network, what services (application name and version) those hosts are offering, what operating systems (and OS versions) they are running, what type of packet filters/firewalls are in use, and dozens of other characteristics. It was designed to rapidly scan large networks, but works fine against single hosts.

Nmap was named “Security Product of the Year” by Linux Journal, Info World, LinuxQuestions.Org, and Codetalker Digest. It was even featured in twelve movies, including [The Matrix Reloaded][2], [Die Hard 4][3], [Girl With the Dragon Tattoo][4], and [The Bourne Ultimatum][5].

> [nmap.org](https://nmap.org)

![Nmap Logo](https://nmap.org/images/sitelogo.png)




## How to use this image

Just substitute `nmap` command with `docker run instrumentisto/nmap`.

```bash
docker run --rm -it instrumentisto/nmap -A -T4 scanme.nmap.org
```

If you need to use another Nmap utility (like `nping`, for example), just specify it as container entrypoint.

```bash
docker run --rm -it --entrypoint nping instrumentisto/nmap scannme.nmap.org
```




## Image versions

This image is based on the popular [Alpine Linux project][11], available in [the alpine official image][12]. Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.


### `latest`

Latest version of Nmap.


### `X`

Latest version of Nmap major version `X` branch.


### `X.Y`

Concrete `X.Y` version of Nmap.




## License

Nmap itself is licensed under [GPLv2 license][91].

Nmap Docker image is licensed under [MIT license][90].




## Issues

We can't notice comments in the DockerHub, so don't use them for reporting issue or asking question.

If you have any problems with or questions about this image, please contact us through a [GitHub issue][10].





[2]: https://nmap.org/movies/#matrix
[3]: https://nmap.org/movies/#diehard4
[4]: https://nmap.org/movies/#gwtdt
[5]: https://nmap.org/movies/#bourne
[10]: https://github.com/instrumentisto/nmap-docker-image/issues
[11]: http://alpinelinux.org
[12]: https://hub.docker.com/_/alpine
[90]: https://github.com/instrumentisto/nmap-docker-image/blob/master/LICENSE.md
[91]: https://nmap.org/data/COPYING
