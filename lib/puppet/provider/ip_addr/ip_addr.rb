Puppet::Type.type(:ip_addr).provide(:ip_addr) do
  desc "Manage IP addresses on systems supporting 'ip addr'"

  commands :ip => "ip"

  confine :kernel => 'Linux'

  def cidr
    resource[:cidr]
  end

  def interface
    resource[:interface]
  end

  def fact_val
    symb = ":ip_addr_#{interface.gsub('.', '_')}"
    Facter.value(eval(symb))
  end

  def create
      ip('addr', 'add', cidr, 'dev', interface)
  end

  def destroy
      ip('addr', 'del', cidr, 'dev', interface)
  end
  
  def exists?
    if fact_val =~ /(,|^)#{Regexp.escape(cidr)}($|,)/
      return true
    end
    return false
  end
end
