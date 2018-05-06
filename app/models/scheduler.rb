
class Scheduler < ApplicationRecord
  has_one :garden
  has_many :bananas, through: :garden
  MAXMINUTES = 30
  LATENCY = 20 #latency before first banana gets updated. used in ini

  #not needed scheduler.garden is available when there is a scheduler id in the garden table.
  # def findgarden
  #   self.garden= Gardens.where(scheduler_id == self.id)
  # end

  # def after_initialize
  #   checkbananas
  # end

  def ini_times
    randomnexttime bananas.filter{|b| b.nexttime.nil?}
  end

  def randomnexttime bananas
    bananas.each do |b|
      b.nexttime = Time.now + LATENCY.seconds + rand(MAXMINUTES).seconds
      b.save
    end
  end

  def fire banana
    # fire event for banana
    banana.nextripe
    banana.nexttime = banana.nexttime + rand(MAXMINUTES).seconds
    banana.save
    pp "ripenes#{ banana.ripeness}"
  end

  def fire_dues bananas
    bananas.each do |banana|
      fire banana
    end
  end

  def fetchallbananastotupling
    @times = []
    self.bananas.each do |bb|
      if bb.nexttime.nil?
        lefttime = 0
      else
        lefttime = bb.nexttime - Time.now
      end
      unless bb.ismaxripe
        tuple = [lefttime, bb]
        @times << tuple
      end
    end
    @times
  end

    #todo methode benutzen..
  def run_further?
     !self.bananas.map{|b| b.ismaxripe?}.all?
  end

  def checkbananas
    ini_times
    puts 'scheduler logging in'
    #todo run hier nochmal überprüfen. wann soll der loop unterbrochen werden?
      if run_further? then mapsleep(fetchallbananastotupling) else puts"all bananas ripe" end
    # i'm asking again to fetch item data from the database
    # to be sure that the time did not change down.
  end

  # should work like this [0,0,0,60,120]
  # execute task on first three or negative ones "fire bananas",
  # then take first one and let sleep thread
  def mapsleep bananatupling
    pp bananatupling
    overtimes = bananatupling.select{|sleep, banana| sleep <= 0}
    puts "overtimes!!!"
    if overtimes != []
      overtimeb = overtimes.map {|sleep, banana| banana}
      fire_dues overtimeb
    end
    rest = bananatupling.select{|sleep, banana| sleep > 0}

    rest = rest.sort_by{|sleep, banana| sleep}
    resttimes = rest.map {|sleep, banana| sleep}
    p"resttimes: \n #{resttimes}"
    if resttimes != []
      rest.first do |sleep,banana|
        t = Thread.new do
          puts "sleeping for #{sleep}"
          sleep resttimes.shift
        #todo adde neue elemente wieder in die abfrage ein
        # puts "Current thread = " + Thread.current.to_s
        # exit
        end
        t.join
        pp banana
        fire banana
      end
      checkbananas
    end
  end

  def repeat_every seconds
    # todo used busy waiting use observer pattern
    t = Thread.new do
      while @run do
        sleep seconds
        yield
      end
    end
  end

  def sleepinterval i
    t = Thread.new do
      sleep i
    end
  end
end

