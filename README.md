# uzyexe/metadata-server

## What is metadata-server

Managed `Instance metadata`. Your Policies.

`Instance metadata` is data about your on-premises server that you can use to configure or manage the running on-premises server.

[**Trusted Build**](https://registry.hub.docker.com/u/uzyexe/metadata-server/)

This Docker image is based on the [ruby:2.2.2-slim](https://registry.hub.docker.com/_/ruby/) base image.

## How to use this image

### Prepare

Set forwarding policies for iptables. 169.254.169.254:80 to 127.0.0.0:4567

```
sudo /sbin/sysctl -w net.ipv4.ip_forward=1
sudo /sbin/iptables -A FORWARD -m tcp -p tcp --dst 169.254.169.254 --dport 80 -j ACCEPT
sudo /sbin/iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo /sbin/iptables -t nat -A OUTPUT -m tcp -p tcp --dst 169.254.169.254 --dport 80 -j DNAT --to-destination 127.0.0.1:4567
```

### Set the Your Metadata

```
META_DIR="/metadata/public"
mkdir -p ${META_DIR}/latest/meta-data
echo -n i-12345678 > ${META_DIR}/latest/meta-data/instance-id
echo foobar > ${META_DIR}/latest/user-data
```

### docker run

```
docker run -d --name=metadata -v /metadata/public:/metadata/public -p 4567:4567 metadata
```

### Get the Your Metadata

```
# curl http://169.254.169.254/latest/user-data
hoge
# curl http://169.254.169.254/latest/meta-data/instance-id
i-12345678
```
