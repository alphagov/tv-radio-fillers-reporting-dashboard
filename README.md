# TV and Radio fillers reporting dashboard

## Introduction

Reporting tool for generating reports about TV and Radio fillers (public
service commercials), summarising their air times and the value/audience
in order to access the impact of the filler.

## Requirements

* Ruby 1.9.3
* Mongo DB
* PhantomJS (generating reports)

## Running the application

To setup first clone the repo and run bundler to get required gems:
> bundle install

To run:
> rackup -p 9000

Navigate to http://localhost:9000 to see the application.

## Testing the application

To test use the the Rakefile in the main directory:
> rake test
