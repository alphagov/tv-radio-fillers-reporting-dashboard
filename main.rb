require 'sinatra'

Dir["./app/models/*.rb"].each { |file| require file }
Dir["./app/helpers/*.rb"].each { |file| require file }
Dir["./app/routes/*.rb"].each { |file| require file }

helpers Breadcrumbs