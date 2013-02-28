require 'sinatra'
require 'uri'

Dir["./app/models/*.rb"].each { |file| require file }
Dir["./app/helpers/*.rb"].each { |file| require file }
Dir["./app/routes/*.rb"].each { |file| require file }

helpers Breadcrumbs

configure do
  Mongoid.load!('mongoid.yml')
end