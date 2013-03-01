require 'sinatra'
require 'uri'

Dir["./app/models/*.rb"].each { |file| require file }
Dir["./app/helpers/*.rb"].each { |file| require file }
Dir["./app/routes/*.rb"].each { |file| require file }

helpers Breadcrumbs

configure do
  Mongoid.load!('mongoid.yml')
end

def is_param_not_nil_empty(param_name)
  !params[param_name].nil? && params[param_name] != ''
end
