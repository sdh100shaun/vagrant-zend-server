execute "install zend key" do
  command "wget http://repos.zend.com/zend.key -O- |apt-key add -"
  not_if "apt-key list| grep -c zend"
end

execute "install zend repo" do
  command "echo 'deb http://repos.zend.com/zend-server/6.0/deb_ssl1.0 server non-free' >> /etc/apt/sources.list"
  not_if "grep 'http://repos.zend.com/zend-server/6.0/deb_ssl1.0' -c /etc/apt/sources.list"
end

execute "update apt" do
  command "apt-get update -q -y"
end

package "zend-server-php-5.4"
package "apache2-mpm-itk"
package "curl"

execute "install composer" do
  command "curl -sS https://getcomposer.org/installer | /usr/local/zend/bin/php -- --install-dir=/usr/local/bin"
end

execute "create composer symlink" do
  command "ln -s /usr/local/bin/composer.phar /usr/local/bin/composer"
  only_if "test -f /usr/local/bin/composer.phar"
  not_if "test -L /usr/local/bin/composer"
end

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

execute "disable default site" do
  command "a2dissite default"
end

execute "enable app site" do
  command "a2ensite app.conf"
end

service "apache2" do
  action :restart
end

execute "upgrade-pear" do
  command "pear upgrade pear | cat" # piping through cat appears to be the only sane way of stopping pear returning exit code 1 on no upgrade
end

execute "pear-channel discovery" do 
  command "sudo pear channel-discover pear.phpunit.de | cat"
  command "sudo pear channel-discover components.ez.no | cat"
  command "sudo pear channel-discover pear.symfony.com | cat"

end

execute "php install" do 
  command "sudo pear install phpunit/PHPUnit --alldeps | cat"
end

