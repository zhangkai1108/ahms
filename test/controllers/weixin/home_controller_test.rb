require 'rufus-scheduler'


scheduler = Rufus::Scheduler.new

scheduler.in '1s' do
  p 'test'
end

scheduler.join
