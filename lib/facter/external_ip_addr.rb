# Fact: external_ip_addr
#
# Purpose: Returns the IP address the outside world knows you by.
#
# Resolution:
#   On the Unixes does a 'curl ifconfig.me/ip', and returns the all subnetted IPs it finds.
#
# Caveats:
#   Only works on Linux Systems.
#

require 'facter/util/ip'
require 'facter/util/macaddress'


# Make a fact for the ip address the rest of the world thinks we have.
Facter.add("external_ip_addr") do
  confine :kernel => 'Linux'
  setcode do
    ip = nil
    tmp = ''
    output = `/usr/bin/curl ifconfig.me/ip`
    result = $?.success?
    if output and result
      ip = output
    end
    ip
  end
end
