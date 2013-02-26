name "server"
description "example web server role"

run_list(
  "recipe[my_cookbook::server]"
)

default_attributes()
override_attributes()

