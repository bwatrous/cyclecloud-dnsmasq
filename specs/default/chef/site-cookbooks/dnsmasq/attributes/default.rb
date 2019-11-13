
### DNSmasq aliases for CycleCloud Nodes ####

# Create one or more round-robin DNS aliases ** for this node ** (the node must be searchable by the dnsmasq server - see dnsmasq.ns.clusters below)
# ex. To add this node to the round-robin-dns list for "bgfs_servers", set
#     "dnsmasq.aliases = beegfs_server" in node configuration
default['dnsmasq']['aliases'] = nil



#### DNSmasq name server configuration #####

# Create a round-robin DNS alias for a list of explicit IPs
# Usage:
# dnsmasq.ns.alias.gluster.addresses = 10.0.1.0, 10.0.1.2, 10.0.1.3
# Optional: 
# dnsmasq.ns.alias.gluster.names := "gluster gluser.cyclecloud.com"
# (default: dnsmasq.ns.alias.<ALIAS>.names := "<ALIAS>")
default['dnsmasq']['ns']['alias'] = {}



##### DNSmasq client configuration ######

# DNSmasq name server discovery
default['dnsmasq']['ns']['hostname'] = nil
default['dnsmasq']['ns']['role'] = nil
default['dnsmasq']['ns']['clusterUID'] = nil
default['dnsmasq']['ns']['recipe'] = "dnsmasq::server"
default['dnsmasq']['ns']['ip_address'] = nil
default['dnsmasq']['ns']['fqdn'] = nil
