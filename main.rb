require 'sinatra'
require "sinatra/reloader" if development?
require 'uri'

Dir["./app/models/*.rb"].each { |file| require file }
Dir["./app/helpers/*.rb"].each { |file| require file }
Dir["./app/routes/*.rb"].each { |file| require file }

Dir["./app/helpers/*.rb"].each { |file| also_reload file } if development?

helpers RoutesHelpers
helpers Breadcrumbs

configure do
  Mongoid.load!('mongoid.yml')
end