#!/usr/bin/python3

'''
Generate Juniper and Cisco configuration with Jinja2 templates
User input require:
CE ASN
CPE WAN interface (Cisco)
SLID - id on format 312313-31313123 (only digits)
Loopback IP
PE IF - Juniper interface

Generate junos L3VPN specific configuration with BGP PE-CE routing.
Generate Cisco IOS customer edge configuration with VRF and BGP routing
'''


import sys,ipaddress
import readline
from jinja2 import Environment, FileSystemLoader

print("#################################################################")
print("####       WSP PE - CE Configuration generator               ####")
print("#################################################################")
print("")
#This line uses the current directory
file_loader = FileSystemLoader('.')

#IPCALC

#net = input("WAN: ")

if __name__=="__main__":
    ipi = ipaddress.ip_interface(sys.argv[1])
#    net = ipaddress.ip_network(sys.argv[1])
    
    print("Address", ipi.ip)
    print("Mask", ipi.netmask)
    print("Network", str(ipi.network).split('/')[0])  
    print("Broadcast", ipi.network.broadcast_address)

#User Input start here.

casn = input("CE ASN: ")
vrf_name = input("VRF name: ")
cpewan = input("CPE WAN IF: ")
slidid = input("POP SLID: ")
LoIP = input("Loopback: ")
peifc = input("PE IF: ")
WANIP = (ipi.ip) + 1
GW = (ipi.ip) + 2
#LAN1 = input("LAN IP ")
#pe1ip = input("R1 IP ")

# slid split

hslid = slidid.split("-")[1]
#print(hslid)


# Load the environment
env = Environment(loader=file_loader)
template = env.get_template('j_wsp.j2')
#Add the variables
output = template.render(local_asn=casn, vrf_name=vrf_name, bgp_nbr=WANIP, wanif=cpewan, ce_wan=GW, lo_addr=LoIP, slid=slidid, jslid=hslid, peif=peifc)
#Print template
print(output)
print("")
print("")

