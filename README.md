# Starlit OS Home Server

An appliance built with bootc based on and closely following [Portainer Home Server](https://github.com/centos-workstation/homeserver).

# Features
- [portainer](https://www.portainer.io/) - to manage containerized applications
- [cockpit](https://cockpit-project.org/) - to manage the system via a webuit and included web terminal
- [tailscale](https://tailscale.com) - for VPN

## Usage

After first boot:

- `https://<ipaddress>:9090` - access the system maintenance webui, login with your username and password.
- `https://<ipaddress>:9443` - access the portainer webui

Tailscale is available via the `tailscale` command.

## Build ISO

Clone this repo then run this to build an iso:

```
just build-iso
```
