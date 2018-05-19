
class Scheduler < ApplicationRecord
  belongs_to :garden

  MAXMINUTES = 30 #seconds
  LATENCY = 0 #latency before first banana gets updated. used in ini

  #not needed scheduler.garden is available when there is a scheduler id in the garden table.
  # def findgarden
  #   self.garden= Gardens.where(scheduler_id == self.id)
  # end

  # after_save
  # after_initialize :enqueue, :assignticketstobananas
  # bugs ...

  after_create :assignticketstobananas, :enqueue

  def run
    puts "scheduler is runnig"
    enqueue
  end

  def assignticketstobananas
    bs = garden.bananas
      maxripe = Banana.maxripe
      bs.each do |b|
        # only call method at after_create and max 3 tickets will be spawned
        # unless b.ismaxripe and b.timetickets < b.maxripe
        howmanytickets = maxripe - b.ripeness
        newtime = inittime
        createtickets howmanytickets, newtime,
                    (Timeticket.create banana_id: b.id,
                                      time: newtime)
        # end
      end
    # end
  end
  def inittime
     Time.now + LATENCY.seconds + rand(MAXMINUTES).seconds
  end
  def randomnexttime time
     time + LATENCY.seconds + rand(MAXMINUTES).seconds
  end
  def createtickets count, time, ticket,
    atime = ticket.time
    bid = ticket.banana_id
    if count > 0
      count =- 1
      newtime = randomnexttime time
      createtickets count, newtime, (Timeticket.create banana_id: bid, time: newtime)
    end
  end



  # mit cable dann event firen sodass bananen farbe verändern und in datenbank geupdated werden.
  def enqueue
    puts "hello enqueue"

    # fire_overdues
    overdues = Timeticket.where('time <= ?', Time.now)
    overdues.each do |v|
      v.banana.nextripe
      v.destroy
    end
    queue = Timeticket.where('time > ?', Time.now).sort_by{|x| x.time}
    sleeptime = 0

    # live execution of ripeness++
    # queue.each do |ticket|
    #   sleeptime = ticket.time - Time.now
    #   #wait
    #   threads = []
    #   t= Thread.new do
    #     threads << []
    #     puts "#{t} sleep #{sleeptime}"
    #     if sleeptime > 3*60
    #       sleep sleeptime
    #     end
    #   end
    #   t.join
    #   puts threads
    #   t.kill
    #   ticket.banana.nextripe
    #   ticket.destroy
    # end



    #def fire
    # Thread.new do
    #   sleep sleeptime
    #   ticket.banana.nextripe
    #   ActionCable.server.broadcast 'grid_channel', content: "##{posx}-#{posy}"
    # end
    #end
  end
end




  # def fire banana
  #   # fire event for banana
  #   banana.nextripe
  #   banana.nexttime = banana.nexttime + rand(MAXMINUTES).seconds
  #   banana.save
  #   pp "ripenes#{ banana.ripeness}"
  # end
  #
  # def fire_dues bananas
  #   bananas.each do |banana|
  #     fire banana
  #   end
  # end
  #
  # def fetchallbananastotupling
  #   @times = []
  #
  #
  #   self.bananas.each do |bb|
  #     if bb.nexttime.nil?
  #       lefttime = 0
  #     else
  #       lefttime = bb.nexttime - Time.now
  #     end
  #     unless bb.ismaxripe
  #       tuple = [lefttime, bb]
  #       @times << tuple
  #     end
  #   end
  #   @times
  # end
  #
  #   #todo methode benutzen..
  # def run_further?
  #    !self.bananas.map{|b| b.ismaxripe?}.all?
  # end
  #
  # def checkbananas_old
  #   ini_times
  #   puts 'scheduler logging in'
  #   #todo run hier nochmal überprüfen. wann soll der loop unterbrochen werden?
  #     if run_further? then mapsleep(fetchallbananastotupling) else puts"all bananas ripe" end
  #   # i'm asking again to fetch item data from the database
  #   # to be sure that the time did not change down.
  # end
  #
  # # should work like this [0,0,0,60,120]
  # # execute task on first three or negative ones "fire bananas",
  # # then take first one and let sleep thread
  # def mapsleep bananatupling
  #   pp bananatupling
  #   overtimes = bananatupling.select{|sleep, banana| sleep <= 0}
  #   puts "overtimes!!!"
  #   if overtimes != []
  #     overtimeb = overtimes.map {|sleep, banana| banana}
  #     fire_dues overtimeb
  #   end
  #   rest = bananatupling.select{|sleep, banana| sleep > 0}
  #
  #   rest = rest.sort_by{|sleep, banana| sleep}
  #   resttimes = rest.map {|sleep, banana| sleep}
  #   p"resttimes: \n #{resttimes}"
  #   if resttimes != []
  #     rest.first do |sleep,banana|
  #       t = Thread.new do
  #         puts "sleeping for #{sleep}"
  #         sleep resttimes.shift
  #       #todo adde neue elemente wieder in die abfrage ein
  #       # puts "Current thread = " + Thread.current.to_s
  #       # exit
  #       end
  #       t.join
  #       pp banana
  #       fire banana
  #     end
  #     checkbananas
  #   end
  # end



