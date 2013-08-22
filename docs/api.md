# RadPike API

## Authentication for API calls

To make API calls, you'll need the auth token. You can find it on your account settings page. Login to RadPike, click the "account" link on top. On the resulting page, you will then find your auth token.

For all API calls, you have to pass your auth token, with the parameter name `auth_token`.

Access to the API calls depends on the kind of role that you've been assigned on RadPike. Admin role can make all API calls.

## Roles

#### GET /api/roles

TODO

## Members

#### GET /members

TODO

#### POST /members

This API call only allows you to create users of the role "customers".

TODO

#### GET /members/:id

TODO

#### PATCH /members/:id

TODO

## Customers

#### GET /api/customers

TODO

#### POST /api/customers

TODO

#### PATCH /api/customers/:id

If you are using the customer's unique ID instead of the customer ID, then the unique ID, then pass unique

#### DELETE /api/customers/:id



## Conversations

#### GET /api/conversations

TODO

#### POST /api/conversations/:id/activities

This will add activity to a conversation

TODO

#### DELETE /api/conversations/:id

TODO

## Participants

#### GET /api/conversation/:conversation_id/participants

TODO

#### POST /api/conversation/:conversation_id/participants

Add a participant to a conversation. This is call is not necessary in most of the cases. If you make an API call to post a activity to a conversation and the user is not a participant already, then the user will be added to the conversation as a participant.

TODO

## Webhooks

#### GET /api/webhooks

TODO

#### POST /api/webhooks

TODO

#### DELETE /api/webhooks/:id

TODO
