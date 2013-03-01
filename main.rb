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

def remove_param_from_url(url, param_name_to_remove)
  uri = URI url
  params = Rack::Utils.parse_query uri.query
  params.delete param_name_to_remove
  uri.query = params.to_param
  uri.to_s
end
