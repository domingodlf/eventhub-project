### EventHub ###


## Group Members

- Domingo De la Fuente Véliz


## Project Description

EventHub is a Ruby on Rails web application for creating, discovering, and joining university events.

Users can browse events, create their own events, register for published events, join waiting lists when events are full, cancel registrations, and leave reviews after attending completed events.

The application includes CRUD functionality, Action Text integration, validations, business logic, registration management, reviews, authentication with Devise, and authorization with CanCanCan.


## Setup and Run Instructions

Install dependencies:
```bash
bundle install
```

Create the database:

```bash
rails db:create
```

Run migrations:

```bash
rails db:migrate
```

Load sample data:

```bash
rails db:seed
```

Start the Rails server:

```bash
rails server
```

Open the application in the browser:

```text
http://localhost:3000/
```

or:

```text
http://127.0.0.1:3000/
```


## Test User Credentials

The seed file creates test users for the application.

All seeded users use the following password:

```text
password123
```

### Administrator

```text
Email: admin@eventhub.com
Password: password123
Role: admin
```

### Regular User

```text
Email: lucas.fernandez@eventhub.cl
Password: password123
Role: regular
```

Other regular seeded users also use the same password.


## Roles and Permissions

EventHub uses role-based authorization with CanCanCan.

The application has two authenticated roles:

- Regular user
- Administrator

There is also a visitor state for users who are not logged in.

### Visitors

Visitors are users who are not logged in.

Visitors can:

- view the landing page;
- browse published events;
- view published event details;
- view categories;
- view venues;
- view reviews;
- access the login and sign up pages.

Visitors cannot:

- create events;
- register for events;
- cancel registrations;
- write reviews;
- access authenticated user actions;
- access administrator actions.

### Regular Users

Regular users are authenticated users with the `regular` role.

Regular users can:

- create events;
- view published events;
- view their own events;
- edit their own events;
- publish their own draft events;
- cancel their own draft or published events;
- register for published events;
- join the waiting list when an event is full;
- cancel their own registrations;
- leave reviews for completed events if they had a confirmed registration;
- edit their own profile.

Regular users cannot:

- manage other users' events;
- delete reviews;
- manage users;
- access administrator-only actions.

### Administrators

Administrators are authenticated users with the `admin` role.

Administrators can:

- manage all events;
- create, edit, publish, and cancel events;
- manage registrations;
- view users;
- view and manage categories;
- view and manage venues;
- view reviews;
- delete reviews;
- moderate platform data.


## Authentication and Authorization

Authentication is implemented with Devise.

Users can:

- sign up;
- log in;
- log out;
- edit their profile;
- recover their password.

Authenticated actions use `current_user`.

Authorization is implemented with CanCanCan.

Permissions are defined according to the user's role, and the interface shows or hides buttons depending on what the current user is allowed to do.

User-dependent actions use the logged-in user instead of manual user dropdowns.

This means:

- event organizers are assigned using the logged-in user;
- registrations are created for the logged-in user;
- reviews are created for the logged-in user;
- permissions are controlled by user role.


## Main Features

### Events

Users can create and manage events.

Events include:

- title;
- rich text description;
- category;
- venue;
- start time;
- end time;
- maximum attendees;
- status;
- organizer.

The event lifecycle includes:

- draft;
- published;
- ongoing;
- completed;
- cancelled.

New events are created with `draft` status by default.

Draft events can be published.

Draft or published events can be cancelled.

Cancelled events are not physically deleted; their status changes to `cancelled`.

### Action Text Integration

Action Text is installed and configured for the event description field.

The `Event` model uses:

```ruby
has_rich_text :description
```

This allows event descriptions to support rich text formatting such as bold, italic, lists, and links.

Rich text descriptions are rendered on the event show page.

### Categories

Categories can be used to organize events.

Categories include:

- name;
- description.

The application includes pages to browse categories and view their related events.

### Venues

Venues represent the physical places where events happen.

Venues include:

- name;
- building;
- address;
- capacity.

The application includes pages to browse venues and view their related events.

### Registrations and Waiting List

Users can register for published events.

If an event has available spots, the registration status is set to `confirmed`.

If the event is full, the registration status is set to `waitlisted`.

When a confirmed registration is cancelled, the first waitlisted registration is automatically promoted to `confirmed`.

The promoted registration gets `waitlist_position` set to `nil`.

Users cannot register twice for the same event.

### Reviews

Users can write reviews directly from the event detail page for completed events.

Reviews can only be created for completed events.

Reviews can only be created by users with a confirmed registration for that event.

Each user can submit at most one review per event.

Administrators can delete reviews.


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

The application uses Bootstrap alerts and form feedback to show success and error messages.

Forms include labels, placeholders, and HTML5 validation attributes such as `required`, `min`, and `max` where appropriate.


## Data Model Notes

- `venues.capacity` represents the physical capacity of the venue.
- `events.max_attendees` represents the registration limit defined by the organizer.
- `events.status` stores the event lifecycle: draft, published, ongoing, completed, cancelled.
- `registrations.status` stores the registration state: confirmed, waitlisted, cancelled.
- A user cannot register twice for the same event.
- A user can submit at most one review per event.
- Reviews can only be created for completed events.
- Reviews can only be created by users with a confirmed registration for that event.


## Seed Data

The seed file creates sample data for:

- users;
- categories;
- venues;
- events;
- registrations;
- reviews.

The seed file creates users with encrypted Devise passwords and known credentials for testing.

The seed file also resets ID sequences so that seeded records have clean and predictable IDs after running:

```bash
rails db:seed
```


## Usability

The application uses Bootstrap consistently across the main views.

Forms include clear labels, placeholders, and appropriate controls.

The event detail page works as a central hub, showing:

- event information;
- venue;
- category;
- registration count;
- available spots;
- waitlist information;
- registration actions;
- reviews.

The navigation bar changes depending on whether the user is logged in and what role the user has.

Visitors see login and sign up actions.

Authenticated users see profile and logout actions.

Actions such as creating events, editing events, cancelling registrations, and deleting reviews are shown only when the current user has permission to perform them.