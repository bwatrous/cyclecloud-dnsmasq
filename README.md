Usage
=====

The `dnsmasq` default spec will install DNSMasq [http://www.thekelleys.org.uk/dnsmasq/doc.html]
on each node with the spec and create one or more DNS aliases for all **discoverable** nodes in the cluster with attribute `dnsmasq.aliases` set to a list of alias names.

DNSMasq will be configured to allow the node to lookup names locally and to allow other nodes to use the node as a DNS search endpoint.   It is up to the cluster whether to install DNSMasq on all nodes or on a central endpoint.



