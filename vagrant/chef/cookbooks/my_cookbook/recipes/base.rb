execute "update apt" do
  command "apt-get update -q -y"
end

template "/etc/hosts" do
	source "hosts.erb"
	owner "root"
	group "root"
	mode 0644
	variables({
		:hostname => node.name,
		:hostname_short => node[:hostname],
		:app_ip => node[:network_ips][:app],
		:db_ip => node[:network_ips][:db]
	})
end
