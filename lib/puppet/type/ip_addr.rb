Puppet::Type.newtype(:ip_addr) do
    @doc = "Manage IP addresses with 'ip addr'"

    ensurable

    newparam(:cidr) do
       desc "The CIDR of the IP to be managed."

       isnamevar

    end

    newparam(:interface) do
      desc "The name of the interface to operate on"

    end
end
