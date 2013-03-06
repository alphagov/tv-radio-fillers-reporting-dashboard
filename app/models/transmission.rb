require 'mongoid'
require 'mongoid/pagination'

class Transmission
  include Mongoid::Document
  include Mongoid::Pagination

  field :type
  field :date, :type => DateTime
  field :time_of_day
  field :station_name
  field :impact
  field :spot_value
  field :client_name
  field :filler_name
  field :campaign_name
  field :clock_name
  field :not_for_profit_station
end