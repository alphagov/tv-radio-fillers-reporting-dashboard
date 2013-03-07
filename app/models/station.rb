require 'mongoid'
require 'mongoid/pagination'

class Station
  include Mongoid::Document
  include Mongoid::Pagination

  field :type
  field :station_name
  field :station_type
  field :station_group
  field :not_for_profit, :type => Boolean
end