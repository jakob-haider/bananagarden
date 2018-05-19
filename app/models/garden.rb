
class Garden < ApplicationRecord
  # attr_accessor :sizex, :sizey # bugs like hell when constructing instance
  has_many :bananas, dependent: :destroy
  has_one :scheduler
  CHANCESPECIAL = 4

  # after_initialize :newfield, if: :new_record?
  # after_initialize :run_scheduler, if: :new_record?
  # after_save :newfield#, :run_scheduler

  # def ini #sizex, sizey
  #   # if self.bananas.nil?
  #     newfield sizex, sizey
  #     puts "init garden"
  #   # end
  #   # run_scheduler
  # end

  after_create :newfield
  # after_initialize :run_scheduler

  def run_scheduler
    Thread.new do
      if self.scheduler.nil?
        inscribe_new_scheduler
      end
      self.scheduler.run
    end
  end

  def inscribe_new_scheduler
    puts "new scheduler for garden id #{id}"
    self.scheduler= Scheduler.create! garden_id: id
    self.save
  end

  def newfield #sizex=10, sizey=10
    # self.sizex = sizex
    # self.sizey = sizey
    # self.save
    sizex.times do |x|
      sizey.times do |y|
        chance = rand CHANCESPECIAL
        if chance == 0
          banana = Banana.create garden_id: id, specialtype: :red, ripeness: 0, posx: x, posy: y
        else
          banana = Banana.create garden_id: id, specialtype: :normal, ripeness: 0, posx: x, posy: y
        end
      end
    end
  end
end
