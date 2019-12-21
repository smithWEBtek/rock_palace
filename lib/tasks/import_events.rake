require 'csv'

namespace :events do
  desc "Import events data from csv"
  task import: :environment do 
    filename = File.join Rails.root, "./lib/assets/import/events.csv"
    CSV.foreach(filename, headers: true) do |row|

      event_hash = {performer: row[0], when: row[1], content: row[2]}
      if !Event.find_by(performer: row[2], when: row[1])
        event = Event.create(event_hash)
        puts Event.last.performer
      end
    end
  end

  desc  "reset Events table"
  task reset: :environment do 
    Event.destroy_all
    ActiveRecord::Base.connection.execute("UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME='events'")
  end
end
