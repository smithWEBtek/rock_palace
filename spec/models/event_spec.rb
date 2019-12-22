require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:performer) }
  it { should validate_presence_of(:when) }
  it { should validate_presence_of(:content) }

  before do
    (1..5).inject([]) do |acc, n|
      acc << FactoryBot.create(:event, when: DateTime.current + n.days)
      acc
    end

    (1..5).inject([]) do |acc, n|
      acc << FactoryBot.create(:event, when: DateTime.current - n.days)
      acc
    end
  end

  it 'should use a scope to filter for future only events' do
    expect(Event.count).to eql(10)
    expect(Event.future.count).to eql(5)
  end

  it 'should use a scope to order events from newest to oldest' do
    event1 = FactoryBot.create(:event, when: DateTime.current + 1.days)
    event2 = FactoryBot.create(:event, when: DateTime.current + 2.days)
    event3 = FactoryBot.create(:event, when: DateTime.current + 3.days)
    expect(Event.last).to eql(event3)
  end

  it 'should use a scope to order events from oldest to newest' do
    event4 = FactoryBot.create(:event, when: DateTime.current + 1.days)
    event5 = FactoryBot.create(:event, when: DateTime.current + 2.days)
    event6 = FactoryBot.create(:event, when: DateTime.current + 3.days)
    expect(Event.last.performer).to eql(event6.performer)
  end
end
