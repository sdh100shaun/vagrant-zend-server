#
# Cookbook Name:: phpunit
# Recipe:: default
#
# Created by  Shaun Hare 
#
# see http://shaunhare.mit-license.org/
#
execute "config pear proxy" do
  command "/usr/local/zend/bin/pear config-set http_proxy #{node['proxy']['http_proxy']}"
  not_if "echo $http_proxy | grep ''"
end

channels = %w{pear.phpunit.de,pear.symfony.com,components.ez.no}
channels.each do |channel| 

  execute "pear-discover" do 
    command "/usr/local/zend/bin/pear channel-discover #{channel}  | cat "
  end

end 

execute "pear update " do 
    command "/usr/local/zend/bin/pear update | cat "
  end

  execute "pear auto config " do 
    command "/usr/local/zend/bin/pear config-set auto_discover 1 | cat "
  end

  execute "phpunit install " do
    command "/usr/local/zend/bin/pear install pear.phpunit.de/PHPUnit "
    not_if "phpunit --version | grep PHPUnit"
    

  end

 directory "/tmp/pear/download" do
    mode 00775
    owner "vagrant"
    group "root"
    action :create
    recursive true
  end


  

  execute "dbUnit" do 
    command "/usr/local/zend/bin/pear install phpunit/DbUnit "
    not_if "pear list -c pear.phpunit.de | grep DbUnit"
    
  end 

 execute "dbUnit" do 
    command "/usr/local/zend/bin/pear install phpunit/PHP_Invoker "
    not_if "pear list -c pear.phpunit.de | grep Invoker"
    
  end 
  execute "Selenium" do 
    command "/usr/local/zend/bin/pear install phpunit/PHPUnit_Selenium "
    not_if "pear list -c pear.phpunit.de | grep Selenium"
    
  end 

  execute "Story" do 
    command "/usr/local/zend/bin/pear install phpunit/PHPUnit_Story "
    not_if "pear list -c pear.phpunit.de | grep Story"
    
  end



