# Supported tags
-   [`1.6.7`, `1.6.7-r1`, `latest` (*[1.6.7-r1/Dockerfile](https://github.com/gkweb76/unbound/blob/master/1.6.7-r1/Dockerfile)*)]



# What is Unbound
[Unbound](https://unbound.net/) is a caching DNS resolver that can be used on its own, or coupled with DNSCrypt proxy to have both a DNS caching service and encrypted DNS requests.  
![](https://unbound.net/gx/unbound-250.png)



# Why using this image ?
This image is a vanilla Unbound software without any additional packages installed. This enables you to run it on its own or concurrently with the DNS encrypting service of your choice (e.g DNSCrypt proxy).  

This image is based on [Alpine Linux](https://alpinelinux.org/) and therefore is built with [LibreSSL](https://www.libressl.org/), which is a more secure fork of OpenSSL made by the [OpenBSD](https://www.openbsd.org/) team. Also Alpine Linux is generally immune to vulnerabilities targetting components not installed in this Operating System, such as: bash (e.g. Shellshock vulnerability), OpenSSL (e.g. Heartbleed vulnerability), glibc (e.g Ghost vulnerability). Also, Alpine Linux has a much smaller image size compared to other OS thanks to less packages installed by default and not relying on glibc, providing faster image download, and reduced attack surface, hence better security.

![](https://wiki.alpinelinux.org/w/resources/assets/alogo.png)



# Maintained by
Guillaume Kaddouch  
Blog: [https://networkfilter.blogspot.com/](https://networkfilter.blogspot.com/)  
Twitter: [@gkweb76](https://twitter.com/gkweb76)  
Github: [gkweb76](https://github.com/gkweb76/)  



# How to use this image from command line
First start unbound to make it create your _unbound_ volume:  
`sudo docker run --rm --name unbound_setup -v unbound:/etc/unbound -p 53:53 gkweb76/unbound`  
`docker volume inspect unbound | grep Mount`  
Grab the host real path, for instance /var/lib/docker/volumes/unbound/_data (referred as '$UNBOUND_VOLUME_PATH' below)  

Then copy your files there, using the correct path:  
`cp ./unbound.conf $UNBOUND_VOLUME_PATH`  

Apply a strict chmod so that only root can modify these files:  
`chmod 644 $UNBOUND_VOLUME_PATH/unbound.conf`  

Start your container:  
`sudo docker run --rm --name unbound -v unbound:/etc/unbound -p 53:53 gkweb76/unbound`  

# Docker compose example  
`version: "3.5"`  
  
`services:`  
&nbsp;&nbsp;  `unbound:`  
&nbsp;&nbsp;  `image: gkweb76/unbound:latest`  
&nbsp;&nbsp;  `container_name: unbound`  
&nbsp;&nbsp;  `read_only: yes`  
&nbsp;&nbsp;  `ports:`  
&nbsp;&nbsp;&nbsp;&nbsp;  `- "53:53/udp"`  
&nbsp;&nbsp;&nbsp;&nbsp;  `- "53:53/tcp"`  
&nbsp;&nbsp;  `networks:`  
&nbsp;&nbsp;&nbsp;&nbsp;  `- unbound`  
&nbsp;&nbsp;    `volumes:`   
&nbsp;&nbsp;&nbsp;&nbsp;      `- unbound:/etc/unbound # stored as /var/lib/docker/volumes/<project_name>_unbound`
&nbsp;&nbsp;&nbsp;&nbsp;      `- /etc/localtime:/etc/localtime:ro # keep container clock in sync with host`  
&nbsp;&nbsp;    `restart: "unless-stopped"`  
  
`# Networks declaration`  
`networks:`  
&nbsp;&nbsp;  `unbound:` 
    
If you need help with your compose file, check the official [documentation](https://docs.docker.com/compose/compose-file/).  


# Tested on

[Ubuntu](https://www.ubuntu.com/) 18.04 LTS and Docker 18.04.0 CE (Community Edition).

# License

MIT License
