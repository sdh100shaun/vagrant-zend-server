name "appserver"
description "Application server Role"

run_list(
  "recipe[my_cookbook::proxy]",
  "recipe[my_cookbook::base]",
  "recipe[my_cookbook::zendserver]",
  "recipe[my_cookbook::composer]",
  "recipe[phpunit::default]",
  "recipe[ntp::default]"
)

default_attributes()
override_attributes()
