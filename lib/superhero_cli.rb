#Application Enviornment

require 'bundler/setup'
Bundler.require (:default)


require 'dotenv/load'


require_relative './superhero_cli/cli.rb'
require_relative './superhero_cli/api.rb'
require_relative './superhero_cli/superhero.rb'



