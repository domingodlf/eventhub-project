### Assignment 3 requested README


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





### Assignment 3 requested README


## Assignment 3 Update

This version extends EventHub with CRUD functionality, ActionText integration, validations, business logic, registration management, reviews, and usability improvements.


# Implemented Features

## Full CRUD Functionality

- **Events:** users can create, edit, update, publish, and cancel events. The event form includes title, organizer, category, venue, start time, end time, max attendees, and rich text description.
- **Categories:** full CRUD functionality for managing categories with name and description.
- **Venues:** full CRUD functionality for managing venues with name, building, address, and capacity.
- **Registrations:** users can register for events directly from the event detail page. Registrations are not created from a separate `registrations/new` page.
- **Reviews:** users can write reviews directly from the event detail page for completed events.

## ActionText Integration

ActionText was installed and configured for the event description field.

The `Event` model uses:

`has_rich_text :description`

This allows event descriptions to support rich text formatting such as bold, italic, lists, and links.

Rich text descriptions are rendered on the event show page.

## Validations and Error Handling

The application includes validations for:

- required fields across the main models;
- event end time being after start time;
- event max attendees being a positive integer;
- event max attendees not exceeding venue capacity;
- review rating being between 1 and 5;
- preventing duplicate registrations for the same user and event;
- preventing duplicate reviews for the same user and event;
- allowing reviews only for completed events;
- allowing reviews only from users with confirmed registrations.

The application also uses Bootstrap alerts and form feedback to show success and error messages.

Forms include labels, placeholders, and HTML5 validation attributes such as `required`, `min`, and `max` where appropriate.

## Business Logic

- New events are created with `draft` status by default.
- Draft events can be published.
- Draft or published events can be cancelled.
- Cancelled events are not physically deleted; their status changes to `cancelled`.
- Users can register only for `published` events.
- If an event has available spots, the registration status is set to `confirmed`.
- If an event is full, the registration status is set to `waitlisted`.
- When a confirmed registration is cancelled, the first waitlisted registration is automatically promoted to `confirmed`.
- The promoted registration gets `waitlist_position` set to `nil`.
- Reviews can only be created for `completed` events.
- Reviews can only be created by users with a confirmed registration for that event.

## Usability

The application uses Bootstrap consistently across the main views.

Forms include clear labels, placeholders, and appropriate controls.

The event detail page works as a central hub, showing event information, venue, category, registration count, available spots, registration actions, waitlist information, and reviews.

## Authentication Note

This assignment does not implement real authentication.

The application does not use Devise, CanCanCan, or `current_user`.

To keep the project within the assignment scope, user-dependent actions are handled with dropdowns:

- organizer selection in the event form;
- user selection in the registration form;
- user selection in the review form.

## Main Routes

Important routes include:

- `/events`
- `/events/new`
- `/events/:id`
- `/events/:id/edit`
- `/categories`
- `/venues`
- `/registrations`
- `/reviews`

Important interactive routes include:

- `PATCH /events/:id/publish`
- `POST /registrations`
- `PATCH /registrations/:id/cancel`
- `POST /reviews`