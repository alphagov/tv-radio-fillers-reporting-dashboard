require 'mongoid'

class FillerEntry
  include Mongoid::Document
  
  field :type
  field :date
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