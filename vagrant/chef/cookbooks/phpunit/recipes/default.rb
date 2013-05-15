#
# Cookbook Name:: phpunit
# Recipe:: default
#
# Created by  Shaun Hare 
#
# see http://shaunhare.mit-license.org/
#

package "php5-xdebug"

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


  execute "Invoker" do 
    command "/usr/local/zend/bin/pear install phpunit/PHP_Invoker"

    
  end 

  execute "dbUnit" do 
    command "/usr/local/zend/bin/pear install phpunit/DbUnit "
    
  end 

  execute "Selenium" do 
    command "/usr/local/zend/bin/pear install phpunit/PHPUnit_Selenium "
    
  end 

  execute "Story" do 
    command "/usr/local/zend/bin/pear install phpunit/PHPUnit_Story "
    
  end

