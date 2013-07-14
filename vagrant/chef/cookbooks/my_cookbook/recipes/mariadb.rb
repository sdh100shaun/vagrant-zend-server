execute "install mariadb key" do
  command "sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 --keyserver-options http-proxy=#{node['proxy']['http_proxy']} 1BB943DB"
  not_if "apt-key list | grep -c mariadb"
end

execute "install mariadb repo" do
  command "echo 'deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/ubuntu precise main' >> /etc/apt/sources.list"
  not_if "grep 'http://ftp.osuosl.org/pub/mariadb/repo/5.5/ubuntu' -c /etc/apt/sources.list"
end

execute "update apt" do
  command "apt-get update -q -y"
end

script "install mariadb" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  DEBIAN_FRONTEND=noninteractive apt-get -q -y --force-yes install mariadb-server-5.5 mariadb-client-5.5 \
  mariadb-server-core-5.5 mariadb-common mariadb-server \
  libmariadbclient18 libdbd-mysql-perl mariadb-client-core-5.5 \
  libmysqlclient18=5.5.30-mariadb1~precise \
  mysql-common=5.5.30-mariadb1~precise
  EOH
end

file "/etc/mysql/conf.d/custom.cnf" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  content "[mysqld]\nbind-address = 0.0.0.0"
end

service "mysql" do
  action :restart
end  

script "setup remote db access" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.50.%' IDENTIFIED BY '' WITH GRANT OPTION; FLUSH PRIVILEGES;"
  EOH
end
