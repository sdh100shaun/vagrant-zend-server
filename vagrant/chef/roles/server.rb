name "server"
description "example web server role"

run_list(
  "recipe[zend_server::server]",
  "recipe[phpunit]"
)

default_attributes()
override_attributes()

