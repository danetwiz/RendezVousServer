# RendezVousServer
Securely bridge your entire home network to a remote (RendezVous) server you've created with an OpenVpn Connection.  Then, an OpenVPN authenticated remote client can join your home nework via a connection to this 'RendezVous' without opening any ports or exposing IP of your home network.  No additional configuration or port forwarding required.  
Just run this script on a linux box after you have created a vpn tunnel to an OpenVPN Access Server you manage in the cloud
Visit https://openvpn.net/vpn-server-resources/release-notes/ for the software to install on your cloud RendezVousServer and config info
This script is to be run on your linux relay node that lives on your local (home) network

I use a Rhaspberry Pi 4 as this relay node.
