#
# Cookbook Name:: dnsmasq
# Recipe:: default
#


package 'dnsmasq'

service "dnsmasq" do
  action :enable
end

searchable_clusters = [node['cyclecloud']['cluster']['id']]
if ! node['dnsmasq']['ns']['clusters'].nil?
  searchable_clusters = (searchable_clusters + node['dnsmasq']['ns']['clusters']).uniq
end

# Make the cyclecloud nodes with aliases resolvable by name(s) (search across clusters)
aliased_nodes = cluster.search().select { |n|
  not n['dnsmasq'].nil? and not n['dnsmasq']['aliases'].nil?
}

# Ensure that the node's alias is associated with each host
aliased_nodes.each do |n|
  addr = n['cyclecloud']['instance']['ipv4']
  if node['cyclecloud']['instance']['ipv4'] == addr
    addr = "127.0.0.1"
  end
  dnsaliases = n['dnsmasq']['aliases']
  dnsaliases.each do |name|
      execute "if grep -q '#{addr}' /etc/hosts; then sed -i '/^\s*#{addr} / {/ #{name} /! s/.*/& #{name} /}' /etc/hosts; else echo '#{addr}  #{name}' >> /etc/hosts; fi"
  end
end


# Add Aliases for explicit ip addresses
node['dnsmasq']['ns']['alias'].each do |name, value|
  Chef::Log.info("Processing DNS alias #{name} => #{value.inspect}")
  if value['addresses'].nil? or value['addresses'].empty?
    Chef::Log.warn("DNS alias #{name} has no associated host IPs...")
  else
    value['addresses'].each do |addr|
      execute "if grep -q '#{addr}' /etc/hosts; then sed -i '/^\s*#{addr} / {/ #{name} /! s/.*/& #{name} /}' /etc/hosts; else echo '#{addr}  #{name}' >> /etc/hosts; fi"
    end
  end
end


file "/etc/dnsmasq.d/listenaddr.conf" do
  content "listen-address=#{node['ipaddress']},127.0.0.1"
  not_if "grep -q 'listen-address=#{node['ipaddress']}'"
  notifies :restart, 'service[dnsmasq]', :immediately  
end

