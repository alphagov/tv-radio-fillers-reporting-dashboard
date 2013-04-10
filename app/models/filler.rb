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
  
  def to_s
    "Filler: #{type} - #{filler_name} - #{coi} - #{client_name} - #{campaign_name}"
  end
end