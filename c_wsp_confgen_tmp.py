#!/usr/bin/python3

import sys,ipaddress
import readline
from jinja2 import Environment, FileSystemLoader


print("#################################################################")
print("####       WSP PE - CE Configuration generator               ####")
print("#################################################################")



#This line uses the current directory
file_loader = FileSystemLoader('.')

#IPCALC


# Add more sys arg
ipi = ipaddress.ip_interface(sys.argv[1])
#ipl = ipaddress.ip_interface(sys.argv[2])

# Add non sys arg

ipy = input("IPY: ")
ipy = ipaddress.ip_interface(ipy)
print("Address Y", ipy.ip)
fus = (ipy.ip) + 1
lus = (ipy.network.broadcast_address) - 1
print(fus)
print(lus)

print("Address", ipi.ip)
print("Mask", ipi.netmask)
print("Network", str(ipi.network).split('/')[0])  
print("Broadcast", ipi.network.broadcast_address)
print("LAN Addr", ipl.ip)
print("Mask", ipl.netmask)
print("Cidr", str(ipl.network).split('/')[1])
print("Network", str(ipl.network).split('/')[0])
print("Broadcast", ipl.network.broadcast_address)


#User Input start here.

casn = input("CE ASN: ")
cpewan = input("CPE WAN IF: ")
slidid = input("POP SLID: ")
LoIP = input("Loopback: ")
peifc = input("PE IF: ")
WANIP = (ipi.ip) + 1
GW = (ipi.ip) + 2
#LAN1 = input("LAN IP ")
#pe1ip = input("R1 IP ")

acl1 = input("ACL: ").split()
print(acl1)


# slid split

hslid = slidid.split("-")[1]
#print(hslid)


# Load the enviroment
env = Environment(loader=file_loader)
template = env.get_template('j_wsp.j2')
#Add the varibles
output = template.render(local_asn=casn, bgp_nbr=WANIP, wanif=cpewan, ce_wan=GW, lo_addr=LoIP, slid=slidid, jslid=hslid, peif=peifc)
#Print template
print(output)
print("#################################################################")
print("#### Your PE - CE Configuration has been generated succssful ####")
print("#################################################################")


