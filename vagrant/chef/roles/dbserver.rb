name "dbserver"
description "Database server Role"

run_list(
  "recipe[my_cookbook::proxy]",
  "recipe[my_cookbook::base]",
  "recipe[mysql::server]"
)

default_attributes(
  :mysql => {
    :bind_address => "0.0.0.0",
    :allow_remote_root => true,
    :remove_test_database => true,
    :server_root_password => "",
    :server_repl_password => "iloverandompasswordsbutthiswilldo",
    :server_debian_password => "iloverandompasswordsbutthiswilldo"
  })

override_attributes()