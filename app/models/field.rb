class Field < ApplicationRecord
  has_many :gardens
  has_many :schedulers

end
