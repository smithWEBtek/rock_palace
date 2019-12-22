class Event < ApplicationRecord
  validates :performer, presence: true
  validates :when, presence: true
  validates :content, presence: true

  scope :future, -> { future_events }
  scope :newest_first, -> { order(:when) }
  scope :oldest_first, -> { order(:when).reverse }

  def self.future_events
    self.all.select do |event|
      event.when >= DateTime.current
    end
  end

end
