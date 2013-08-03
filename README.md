# RoverChat

## Notes on views

#### Maintaining the concept of conversations without database table

* Unreplied conversations older than 3min is shown in the conversations list in reverse chronological order.

* To keep track of guest users use the ID of the guest user in js.

## Schema

#### User

* has_many :sent_messages
* belongs_to :received_messages

#### Message

* belongs_to :sender
* belongs_to :receiver

Each message has a reply field