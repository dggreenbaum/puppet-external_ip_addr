# Fact: ip_addr
#
# Purpose: Returns all IP Addresses for a NIC.
#
# Resolution:
#   On the Unixes does an 'ip addr show', and returns the all subnetted IPs it finds.
#
# Caveats:
#   Only works on Linux Systems.
#

require 'facter/util/ip'
require 'facter/util/macaddress'

Facter::Util::IP.get_interfaces.each do |interface|

  # Make a fact for each detail of each interface.  Yay.
  #   There's no point in confining these facts, since we wouldn't be able to create
  # them if we weren't running on a supported platform.
  Facter.add("ip_addr_" + Facter::Util::IP.alphafy(interface)) do
    setcode do
      ip = nil
      tmp = ''
      output = `/sbin/ip addr show #{interface} 2>/dev/null`
      result = $?.success?
      if output and result
        regexp = /inet ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\/[0-9]{1,2})/
        output.each_line do |line|
          match = regexp.match(line)
          if match
            tmp = "#{tmp},#{match[1]}"
          end
        end
        ip = tmp[1..-1]
      end
      ip
    end
  end
end
