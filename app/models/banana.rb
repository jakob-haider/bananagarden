
class Banana < ApplicationRecord
  # attr_accessor :color, :specialtype, :isripemax
  belongs_to :garden, required: false
  belongs_to :inventory, required: false
  has_many :timetickets, dependent: :destroy

  RIPESTATES = {0=> :unripe, 1 => :halfripe, 2 => :ripe}

  def maxripe
    RIPESTATES.max_by{|k,v| k}.first
  end

  def self.maxripe
    RIPESTATES.max_by{|k,v| k}.first
  end

  def set_ismaxripe
    self.ismaxripe = ripeness == maxripe
    self.save
  end

  def ripestring
    ripenum
    self.RIPESTATES[num]
  end

  def nextripe
    if self.ripeness == nil then self.ripeness = 0 end
    self.ripeness = self.ripeness + 1 if self.ripeness < maxripe else maxripe
    set_ismaxripe
    # puts "printing self"
    # puts self
    self.save
    puts "nextripe! garden: #{self.garden_id}"
  end
end
