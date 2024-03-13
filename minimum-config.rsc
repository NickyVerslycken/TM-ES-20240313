#maak een backup van de router
/system backup save name=routerconfig1

#reset de router > klik na dit commando op "y"
/system reset-configuration no-defaults=yes skip-backup=yes


{
    #variables
    :local studentName "jhon-do"; #vervang jhon-do door uw naam, bv: peter-de-man
    :local groupNumber 1; #vervang de 1 met de nummer van jouw groep
    :local studentNumber 1; #vervang de 1 met jouw nummer
    #configuratie
    /system identity set name="student-$studentName"
    /interface bridge add name=bridge-lan
    /interface bridge port; add bridge=bridge-lan interface=ether2; add bridge=bridge-lan interface=ether3;
    /ip address add address="10.$groupNumber.$studentNumber.1/24" interface=bridge-lan
    /ip firewall nat add chain=srcnat out-interface=ether1 action=masquerade
    /ip dhcp-client add disabled=no interface=ether1
    /ip pool add name=dhcp_pool1 ranges="10.$groupNumber.$studentNumber.10-10.$groupNumber.$studentNumber.100"
    /ip dhcp-server network add address="10.$groupNumber.$studentNumber.0/24" gateway="10.$groupNumber.$studentNumber.1" dns-server=1.1.1.1
    /ip dhcp-server add address-pool=dhcp_pool1 interface=bridge-lan disabled=no
    /password old-password="" new-password="router-$groupNumber-$studentNumber-pass" confirm-new-password="router-$groupNumber-$studentNumber-pass"
}


#het wachtwoord van jouw router zal bv. het volgende zijn indien je student 1 bent in groep 1: "router-1-1-pass"