desc "send off text and call reminders"
  
  task :remind => :environment do

    puts "Call Worker Now Running"
    CallWorker.new.perform
    puts "Succeed"

    puts "Text Worker Now Running"
    TextWorker.new.perform
    puts "Succeed"

    puts "Email Worker Now Running"
    EmailWorker.new.perform
    puts "Succeed"

  end