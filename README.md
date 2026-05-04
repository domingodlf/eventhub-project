# EventHub

## Group Members
- Domingo De la Fuente Véliz

## Repository Structure
- landing-page/
- docs/
- user-stories.md
- README.md

## Data Model Notes
- `venues.capacity` represents the physical capacity of the venue.
- `events.max_attendees` represents the registration limit defined by the organizer.
- `events.status` stores the event lifecycle (draft, published, ongoing, completed, cancelled).
- `registrations.status` stores the registration state (confirmed, waitlisted, cancelled).
- A user should not register twice for the same event.
- A user should submit at most one review per event.




### Assignment 2 requested README


## Setup and Run Instructions

Install dependencies:

`bundle install`

Create the database:

`rails db:create`

Run migrations:

`rails db:migrate`

Load sample data:

`rails db:seed`

Start the Rails server:

`rails server`

Open the application in the browser:

`http://127.0.0.1:3000/`  or   `http://localhost:3000/`

## Assignment 2 Notes

This Rails application uses PostgreSQL and includes seeded sample data for the main entities in the EventHub data model.

The app includes read-only `index` and `show` pages for:

- Events
- Categories
- Venues
- Users
- Registrations
- Reviews