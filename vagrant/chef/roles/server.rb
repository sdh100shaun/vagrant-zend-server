name "server"
description "example web server role"

run_list(
  "recipe[my_cookbook::server]",
  "recipe[phpunit]"
)

default_attributes()
override_attributes()

