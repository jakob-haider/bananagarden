
class Banana < ApplicationRecord
  # attr_accessor :color, :specialtype, :isripemax
  belongs_to :garden, required: false
  belongs_to :scheduler, required: false
  belongs_to :inventory, required: false
  has_one :timeticket

  RIPESTATES = {0=> :unripe, 1 => :halfripe, 2 => :ripe}

  def set_isripemax
    self.ismaxripe = ripeness == maxripe
    self.save
  end

  def maxripe
    RIPESTATES.max_by{|k,v| k}.first
  end

  def ripestring
    ripenum
    self.RIPESTATES[num]
  end

  def nextripe
    puts "maxripe: #{maxripe}"
    if self.ripeness == nil then self.ripeness = 0 end
    self.ripeness = self.ripeness + 1 if self.ripeness < maxripe else maxripe
    set_isripemax
    # puts "printing self"
    # puts self
    self.save
  end
end
