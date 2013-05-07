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
    command "pear channel-discover #{channel}  | cat "
  end

end 

  execute "pear auto config " do 
    command "pear config-set auto_discover 1 | cat"
  end

  execute "phpunit install " do
    command "pear install pear.phpunit.de/PHPUnit"
  end

  execute "code coverage" do 
    command "sudo pear install pear.phpunit.de/PHP_CodeCoverage |cat"
  end 

