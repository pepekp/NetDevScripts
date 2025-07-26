#!/usr/bin/python3 

import jinja2
import ipaddress
import readline

menu_options = {
    1: 'C921 RJ45',
    2: 'C11xx RJ45',
    3: 'C11xx SFP',
    4: 'C9300 RJ45',
    5: 'C9300 SFP',
    6: 'C9300 10Gb uplink',
    7: 'C9300 Multy service',
    0: 'Exit',
}

for k, v in menu_options.items():
    print(k, v)

# print(menu_options)
option = int(input('Enter an option: '))
if option == 0:
    print('Exit configurator...')
    exit()
else:
    pass

acr = input('Hostname: ')

def option1():  # Cisco 921
    pe_ce_subnet = input('PE CE /30 SUBNET: ') 
    pe_ce_subnet = ipaddress.ip_interface(pe_ce_subnet)
    pe_ip = pe_ce_subnet.ip + 1
    ce_ip = pe_ce_subnet.ip + 2
    template_loader = jinja2.FileSystemLoader(searchpath="./base_config_templates")
    template_env = jinja2.Environment(loader=template_loader)
    template_file = "c921.j2"
    template = template_env.get_template(template_file)
    # Render jinja template
    output = template.render(acr=acr, pe_ip=pe_ip, ce_ip=ce_ip)  
    print('')
    print('!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!')
    print('')
    print(output)
def option2():
    #print('Handle option \'Option 2\'')
    pe_ce_subnet = input('PE CE /30 SUBNET: ') 
    pe_ce_subnet = ipaddress.ip_interface(pe_ce_subnet)
    pe_ip = pe_ce_subnet.ip + 1
    ce_ip = pe_ce_subnet.ip + 2
    template_loader = jinja2.FileSystemLoader(searchpath="./base_config_templates")
    template_env = jinja2.Environment(loader=template_loader)
    template_file = "c11xx_RJ45.j2"
    template = template_env.get_template(template_file)
    # Render jinja template
    output = template.render(acr=acr, pe_ip=pe_ip, ce_ip=ce_ip)  
    print('')
    print('!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!')
    print('')
    print(output)
def option3():
    #print('Handle option \'Option 3\'')
    pe_ce_subnet = input('PE CE /30 SUBNET: ') 
    pe_ce_subnet = ipaddress.ip_interface(pe_ce_subnet)
    pe_ip = pe_ce_subnet.ip + 1
    ce_ip = pe_ce_subnet.ip + 2
    template_loader = jinja2.FileSystemLoader(searchpath="./base_config_templates")
    template_env = jinja2.Environment(loader=template_loader)
    template_file = "c11xx_SFP.j2"
    template = template_env.get_template(template_file)
    output = template.render(acr=acr, pe_ip=pe_ip, ce_ip=ce_ip)
    print('')
    print('!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!')
    print('')
    print(output)
def option4():
    #print('Handle option \'Option 4\'')
    pe_ce_subnet = input('PE CE /30 SUBNET: ') 
    pe_ce_subnet = ipaddress.ip_interface(pe_ce_subnet)
    pe_ip = pe_ce_subnet.ip + 1
    ce_ip = pe_ce_subnet.ip + 2
    template_loader = jinja2.FileSystemLoader(searchpath="./base_config_templates")
    template_env = jinja2.Environment(loader=template_loader)
    template_file = "c9300_RJ45.j2"
    template = template_env.get_template(template_file)
    output = template.render(acr=acr, pe_ip=pe_ip, ce_ip=ce_ip)
    print('')
    print('!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!')
    print('')
    print(output)
def option5():
    #print('Handle option \'Option 5\'')
    pe_ce_subnet = input('PE CE /30 SUBNET: ') 
    pe_ce_subnet = ipaddress.ip_interface(pe_ce_subnet)
    pe_ip = pe_ce_subnet.ip + 1
    ce_ip = pe_ce_subnet.ip + 2
    template_loader = jinja2.FileSystemLoader(searchpath="./base_config_templates")
    template_env = jinja2.Environment(loader=template_loader)
    template_file = "c9300_SFP.j2"
    template = template_env.get_template(template_file)
    output = template.render(acr=acr, pe_ip=pe_ip, ce_ip=ce_ip)
    print('')
    print('!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!')
    print('')
    print(output)
def option6():  # Cisco Catalist 9300 10Gb uplink
    pe_ce_subnet = input('PE CE /30 SUBNET: ') 
    pe_ce_subnet = ipaddress.ip_interface(pe_ce_subnet)
    pe_ip = pe_ce_subnet.ip + 1
    ce_ip = pe_ce_subnet.ip + 2
    template_loader = jinja2.FileSystemLoader(searchpath="./base_config_templates")
    template_env = jinja2.Environment(loader=template_loader)
    template_file = "c9300_10G.j2"
    template = template_env.get_template(template_file)
    output = template.render(acr=acr, pe_ip=pe_ip, ce_ip=ce_ip)
    print('')
    print('!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!')
    print('')
    print(output)
def option7():
    #print('Handle option \'Option 7\'')
    pe_ce_subnet_service_one = input('Service one /30 SUBNET: ')
    pe_ce_subnet_service_one = ipaddress.ip_interface(pe_ce_subnet_service_one)
    peip_service_one = pe_ce_subnet_service_one.ip + 1
    ceip_service_one = pe_ce_subnet_service_one.ip + 2
    pe_ce_subnet_service_two = input('Service two /30 SUBNET: ')
    pe_ce_subnet_service_two = ipaddress.ip_interface(pe_ce_subnet_service_two)
    peip_service_two = pe_ce_subnet_service_two.ip + 1
    ceip_service_two = pe_ce_subnet_service_two.ip + 2
    template_loader = jinja2.FileSystemLoader(searchpath="./base_config_templates")
    template_env = jinja2.Environment(loader=template_loader)
    template_file = "c9300_multy_service.j2"
    template = template_env.get_template(template_file)
    output = template.render(acr=acr, peip_service_one=peip_service_one, ceip_service_one=ceip_service_one,
                                 peip_service_two=peip_service_two, ceip_service_two=ceip_service_two)
    print('')
    print('!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++!')
    print('')
    print(output)
if option == 1:
    option1()
elif option == 2:
    option2()
elif option == 3:
    option3()
elif option == 4:
    option4()
elif option == 5:
    option5()
elif option == 6:
    option6()
elif option == 7:
    option7()
elif option == 0:
    print('Thanks message before exiting')
    exit()
else:
    print('Invalid option. Please enter a number between 0 and 7.')
