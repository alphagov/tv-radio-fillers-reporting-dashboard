require 'mongoid'
require 'mongoid/pagination'

class Filler
  include Mongoid::Document
  include Mongoid::Pagination

  field :type
  field :filler_name
  field :coi
  field :client_name
  field :campaign_name
  field :length => Integer
end