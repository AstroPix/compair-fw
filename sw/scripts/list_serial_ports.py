import serial.tools.list_ports 


ports = serial.tools.list_ports.comports()
print("Number of ports = %d" % len(ports))
for port in ports:
    print(port.pid, port.vid, port.manufacturer, port.name, port.serial_number, port.device)
    print(type(port.pid), type(port.vid), type(port.manufacturer), type(port.name), type(port.serial_number), type(port.device))
    print("- Port = %s" % port.device )
    print("- Desc = %s" % port.description)
    print("- HW = %s" % port.hwid)
