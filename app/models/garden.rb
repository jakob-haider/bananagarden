
class Garden < ApplicationRecord
  # attr_accessor :sizex, :sizey # bugs like hell when constructing instance
  has_many :bananas, dependent: :destroy
  belongs_to :scheduler, required: false
  CHANCESPECIAL = 4

  # after_initialize :run_scheduler

  # def ini #sizex, sizey
  #   # if self.bananas.nil?
  #     newfield sizex, sizey
  #     puts "init garden"
  #   # end
  #   # run_scheduler
  # end

  def run_scheduler
    Thread.new do
      if self.scheduler.nil?
        inscribe_new_scheduler
      end
      scheduler.checkbananas
    end
  end

  def inscribe_new_scheduler
    self.scheduler_id = Scheduler.create.id
    self.save
  end

  def newfield #sizex=10, sizey=10
    # self.sizex = sizex
    # self.sizey = sizey
    # self.save
    sizex.times do |x|
      sizey.times do |y|
        chance = rand CHANCESPECIAL
        if chance < 0.3 * CHANCESPECIAL
          banana = Banana.create garden_id: self.id, specialtype: :normal, ripeness: 0
        elsif chance > 0.3 * CHANCESPECIAL && chance < 0.6 * CHANCESPECIAL
          banana = Banana.create garden_id: self.id, specialtype: :red, ripeness: 1
        else
          banana = Banana.create garden_id: self.id, specialtype: :red, ripeness: 2
        end
        self.bananas << banana
      end
    end
  end
end
