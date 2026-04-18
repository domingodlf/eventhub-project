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