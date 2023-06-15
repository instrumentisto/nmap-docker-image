Nmap Docker image
=================

[![Release](https://img.shields.io/github/v/release/instrumentisto/nmap-docker-image "Release")](https://github.com/instrumentisto/nmap-docker-image/releases)
[![CI](https://github.com/instrumentisto/nmap-docker-image/workflows/CI/badge.svg?branch=main "CI")](https://github.com/instrumentisto/nmap-docker-image/actions?query=workflow%3ACI+branch%3Amain)
[![Docker Hub](https://img.shields.io/docker/pulls/instrumentisto/nmap?label=Docker%20Hub%20pulls "Docker Hub pulls")](https://hub.docker.com/r/instrumentisto/nmap)

[Docker Hub](https://hub.docker.com/r/instrumentisto/nmap)
| [GitHub Container Registry](https://github.com/orgs/instrumentisto/packages/container/package/nmap)
| [Quay.io](https://quay.io/repository/instrumentisto/nmap)

[Changelog](https://github.com/instrumentisto/nmap-docker-image/blob/main/CHANGELOG.md)




## Supported tags and respective `Dockerfile` links

- [`7.93-r7`, `7.93`, `7`, `latest`][201]




## Supported platforms

- `linux`: `amd64`, `arm32v6`, `arm32v7`, `arm64v8`, `i386`, `ppc64le`, `s390x`




## What is Nmap?

Nmap ("Network Mapper") is a free and open source ([license][92]) utility for network discovery and security auditing. Many systems and network administrators also find it useful for tasks such as network inventory, managing service upgrade schedules, and monitoring host or service uptime. Nmap uses raw IP packets in novel ways to determine what hosts are available on the network, what services (application name and version) those hosts are offering, what operating systems (and OS versions) they are running, what type of packet filters/firewalls are in use, and dozens of other characteristics. It was designed to rapidly scan large networks, but works fine against single hosts.

Nmap was named “Security Product of the Year” by Linux Journal, Info World, LinuxQuestions.Org, and Codetalker Digest. It was even featured in twelve movies, including [The Matrix Reloaded][22], [Die Hard 4][23], [Girl With the Dragon Tattoo][24], and [The Bourne Ultimatum][25].

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




## Image tags

This image is based on the popular [Alpine Linux project][1], available in [the alpine official image][2]. [Alpine Linux][1] is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

This variant is highly recommended when final image size being as small as possible is desired. The main caveat to note is that it does use [musl libc][4] instead of [glibc and friends][5], so certain software might run into issues depending on the depth of their libc requirements. However, most software doesn't have an issue with this, so this variant is usually a very safe choice. See [this Hacker News comment thread][6] for more discussion of the issues that might arise and some pro/con comparisons of using [Alpine][1]-based images.


### `<X>`

Latest tag of the latest major `X` Nmap version.

This is a multi-platform image.


### `<X.Y>`

Latest tag of the concrete `X.Y` Nmap version.

This is a multi-platform image.


### `<X.Y>-r<N>`

Concrete `N` image revision tag of the concrete `X.Y` Nmap version.

Once built, it's never updated.

This is a multi-platform image.


### `<X.Y>-r<N>-<os>-<arch>`

Concrete `N` image revision tag of the concrete `X.Y` Nmap version on the concrete `os` and `arch`.

Once built, it's never updated.

This is a single-platform image.




## License

Nmap is licensed under [GPLv2 license][92].

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

The [sources][90] for producing `instrumentisto/nmap` Docker images are licensed under [Blue Oak Model License 1.0.0][91].




## Issues

We can't notice comments in the [DockerHub] (or other container registries) so don't use them for reporting issue or asking question.

If you have any problems with or questions about this image, please contact us through a [GitHub issue][80].




[DockerHub]: https://hub.docker.com

[1]: http://alpinelinux.org
[2]: https://hub.docker.com/_/alpine
[4]: http://www.musl-libc.org
[5]: http://www.etalabs.net/compare_libcs.html
[6]: https://news.ycombinator.com/item?id=10782897

[22]: https://nmap.org/movies/#matrix
[23]: https://nmap.org/movies/#diehard4
[24]: https://nmap.org/movies/#gwtdt
[25]: https://nmap.org/movies/#bourne

[80]: https://github.com/instrumentisto/nmap-docker-image/issues
[90]: https://github.com/instrumentisto/nmap-docker-image
[91]: https://github.com/instrumentisto/nmap-docker-image/blob/main/LICENSE.md
[92]: https://nmap.org/data/COPYING

[201]: https://github.com/instrumentisto/nmap-docker-image/blob/main/Dockerfile
