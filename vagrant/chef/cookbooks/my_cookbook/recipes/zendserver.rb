execute "install zend key" do
  command "wget --proxy http://repos.zend.com/zend.key -O- | apt-key add -"
  not_if "apt-key list| grep -c zend"
end

execute "install zend repo" do
  command "echo 'deb http://repos.zend.com/zend-server/6.0/deb_ssl1.0 server non-free' >> /etc/apt/sources.list"
  not_if "grep 'http://repos.zend.com/zend-server/6.0/deb_ssl1.0' -c /etc/apt/sources.list"
end

execute "update apt" do
  command "apt-get update -q -y"
end


execute "install autoconf tools" do 

  command "apt-get install autoconf -q -y"

end

execute "install make tools" do 

  command "apt-get install make -q -y"

end



package "zend-server-php-5.4"
package "apache2-mpm-itk"

cookbook_file "/etc/profile.d/zend-server.sh" do
  source "zend-server.sh"
  group "root"
  owner "root"
  mode "0644"
end

cookbook_file "/etc/apache2/sites-available/app.conf" do
  source "app.conf"
  group "root"
  owner "root"
end


execute "install mongo driver" do 

  command "sudo pecl install mongo| cat "

end

template "/usr/local/zend/etc/mongo.ini" do
  source "mongo.ini.erb"
  group "root"
  owner "zend"
  mode "0644"
end


template "/usr/local/zend/etc/pcntl.ini" do
  source "pcntl.ini.erb"
  group "root"
  owner "zend"
  mode "0644"
end

execute "enable pcntl" do
  command <<-EOC 
    sed -i 's,;\\(extension=pcntl.so\\),\\1,g' /usr/local/zend/etc/conf.d/pcntl.ini
  EOC
end

execute "enable mongo" do
  command <<-EOC 
    sed -i 's,;\\(extension=mongo.so\\),\\1,g' /usr/local/zend/etc/conf.d/mongo.ini
  EOC
end
execute "disable default site" do
  command "a2dissite default"
end

execute "enable app site" do
  command "a2ensite app.conf"
end

service "apache2" do
  action :restart
end


