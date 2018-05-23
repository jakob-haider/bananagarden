
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




