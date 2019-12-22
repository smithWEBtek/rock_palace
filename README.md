# README

# Rock Palace app
## curates events with the ability to:
  - Create new event
  - Edit/Update existing event
  - Display all events, sorted by Performer
  - Display events 5 per page, sorted newest to oldest
  - Display events 5 per page, sorted oldest to newest
  - Authenticate via Login with username and password

## Ruby version: 2.6.4

## System dependencies:
  - gem 'will_paginate', '~> 3.2.1'
  - gem 'haml', '~> 5.1.2'
  - gem 'simple_form', '~> 5.0.1'
  - gem 'jquery-rails', '~> 4.3.5'
  - gem 'bootstrap', '~> 4.4.1'

## Configuration
  - run `yarn install --check-files`
  - use Ruby version 2.6.4
  - run `bundle install`
  - run `rake db:migrate`
  - run `rake db:seed`

## Database creation and initialization
  #### To create the database
  - `rake db:migrate` will create the database (if not exists), and run migrations

  #### To drop, create, migrate, seed database and restart Rails:
  - run ```rake db:dcms```


## How to run the test suite
  - run `rspec` from the root of the project

## Deployment instructions
  - deployment is currently local only

## Instructions for refactor:

- [x] Events#index list is paginated.
- [x] No more than 5 events per page.
- [x] Events#index shows only upcoming events by default.
- [x] Upcoming events are scoped via `Event.future`
- [x] The events listed in events#index should list the events in ascending order by the Event ‘when’ attribute. This is accomplished via scope: `Event.newest_first`
- [x] The `Event.newst_first` scope has a unit test in `/spec/models/event_spec.rb`
- [x] All vies are converted from erb to haml.
- [x] All Events in views use a user friendly format like “12/31/2019 at 8PM” via a Ruby method available to date objects:  `@event.when.strftime("%m/%d/%Y at %I:%M%p")`
- [x] Flash[:notice] messages are visible by via `application_layout.html.haml`
- [x] Flash[:notice] functionality is tested in: `/spec/acceptance/events_spec.rb`
