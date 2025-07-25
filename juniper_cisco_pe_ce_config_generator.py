#!/usr/bin/python3

'''
Generate Juniper and Cisco configuration with Jinja2 templates
User input require:
CE ASN
CPE WAN interface (Cisco)
SLID - id on format 312313-31313123 (only digits)
PE IF - Juniper interface

Generate junos L3VPN specific configuration with BGP PE-CE routing.
Generate Cisco IOS customer edge configuration with VRF and BGP routing
'''


import sys,ipaddress
import readline
from jinja2 import Environment, FileSystemLoader

print("#################################################################")
print("#################################################################")
print("####     Juniper PE - Cisco CE Configuration generator       ####")
print("#################################################################")
print("#################################################################")
print("")

#IPCALC


def cfg_gen():
    # Use current directory
    file_loader = FileSystemLoader('.')



    #User Input start here.
    ipi = input("P2P NETWORK: ")
    peifc = input("PE Interface: ")
    vrf_name = input("PE VRF name: ")
    ceasn = input("CE ASN: ")
    ce_vrf_name = input("CE VRF name: ")
    cpewan = input("CPE WAN Interface: ")
    desc = input("Description: ")

    ipi = ipaddress.ip_interface(ipi)

    print("Address", ipi.ip)
    print("Mask", ipi.netmask)
    print("Network", str(ipi.network).split('/')[0])
    network_addr = ipi.network
    wanip = (ipi.ip) + 1
    gw = (ipi.ip) + 2
    netmask = ipi.netmask

    # Load jinja environment
    env = Environment(loader=file_loader)
    template = env.get_template('template.j2')
    # Render variables
    output = template.render(local_asn=ceasn, vrf_name=vrf_name, ce_vrf_name=ce_vrf_name, bgp_nbr=wanip, wanif=cpewan,
                             ce_wan=gw, desc=desc, peif=peifc, netmask=netmask, network_addr=network_addr)
    # Print template
    print(output)
    print("Configuration has been generate")
    print("")

if __name__=="__main__":
    cfg_gen()