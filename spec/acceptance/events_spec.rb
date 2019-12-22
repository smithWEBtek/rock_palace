require 'rails_helper'

RSpec.describe 'Events' do

  describe '#index' do
    before do
      @events = (1..11).inject([]) do |acc, n|
        acc << FactoryBot.create(:event, when: DateTime.current + n.days)
        acc
      end
      @past_event = FactoryBot.create(:event, when: DateTime.current - 1.day)
      visit events_path
    end

    it 'past events are not displayed' do
      expect(page).to have_no_content(@past_event.performer)
    end
    
    it 'only 5 events are listed per page' do
      expect(page).to have_selector('tr', count: 5)
    end

    it 'displays all event performers' do
      @events[0..4].each do |event|
        expect(page).to have_content(event.performer)
      end
    end

    it 'displays all event whens (dates)' do
      @events[0..4].each do |event|
        expect(page).to have_content(event.when.strftime("%m/%d/%Y at %I:%M%p"))
      end
    end
  end

  describe '#show' do
    before do
      @event = FactoryBot.create(:event, when: DateTime.current + 1.day)
      visit events_path
      click_on @event.performer
    end

    it 'should display performer' do
      expect(page).to have_content(@event.performer)
    end

    it 'should display when' do
      expect(page).to have_content(@event.when.strftime("%m/%d/%Y at %I:%M%p"))
    end

    it 'should display content' do
      expect(page).to have_content(@event.content)
    end
  end

  describe '#create' do
    before do
      visit new_event_path
    end

    context 'given that the input values are valid' do
      before do
        fill_in 'event_performer', with: 'The XYZs'
        # date controls are preset with current date
        fill_in 'event_when', with: DateTime.current
        fill_in 'event_content', with: 'This is some content.'
      end

      it 'successfully saves the event' do
        expect { click_on 'Create Event' }.to change(Event, :count).by(1)
      end

      it 'redirects to events#show' do
        click_on 'Create Event'
        expect(current_path).to eq event_path(Event.last)
      end
      
      it 'add test for displaying success flash notice' do
        click_on 'Create Event'
        expect(page).to have_content("Successfully created event.")
      end
    end

    context 'given that the input values are invalid' do
      before do
        fill_in 'event_performer', with: ''
        # date controls are preset with current date
        fill_in 'event_content', with: 'This is some content.'
      end

      it 'does not save the event' do
        expect { click_on 'Create Event' }.to change(Event, :count).by(0)
      end

      it 'remains on events#new' do
        expect(current_path).to eq new_event_path
      end

      it 'displays error flash notice' do
        click_on 'Create Event'
        expect(page).to have_content("Unable to create event due to errors. Please review.")
      end
    end
  end

  describe '#update' do
    before do
      @event = FactoryBot.create :event
      visit edit_event_path(@event)
    end

    context 'given that the input values are valid' do
      before do
        fill_in 'event_content', with: @content = 'This is new content.'
        click_on 'Update Event'
      end

      it 'successfully updates the event' do
        expect(@event.reload.content).to eq @content
      end

      it 'redirects to events#show' do
        expect(current_path).to eq event_path(@event)
      end

      it 'displays success flash notice' do
        expect(page).to have_content('Successfully updated event.')
      end
    end

    context 'given that the input values are invalid' do
      before do
        @content = @event.content
        fill_in 'event_content', with: ''
        click_on 'Update Event'
      end

      it 'does not update the event' do
        expect(@event.reload.content).to eq @content
      end

      it 'displays failure flash notice' do
        expect(page).to have_content("Unable to update event due to errors. Please review.")
      end
    end
  end
end
