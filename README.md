# RadPike

Work-In-Progress

## Notes on views

#### Maintaining the concept of conversations without database table

* Unreplied conversations older than 3min is shown in the conversations list in reverse chronological order.

* To keep track of guest users use the ID of the guest user in js, if it's a guest.

## TaskList for v1

* [ ] Member management
  * Errors on member form
  * Check if password change works
  * Instead of deactivating user, remove if user has no sent messages & received msgs.
* [ ] Define User#is_active? to block `deactivated-agent` form logging in
* [ ] Run posted messages thru plugins
* [ ] Authorization for message passing and embed widget
* [ ] Use faye for websockets
  * Write example (stub) broadcaster
  * Write broadcaster for Faye
* [ ] Auto-scroll on new message
* [ ] Auto-scroll to end on opening a conversation
* [ ] Embedable support widget
  * Assign user to agent by default if option is passed to support widget
* [ ] IssueStateTypes
  * Fields: name
  * Defaults setup from rake task: resolved, unresolved
* [ ] IssueState model for maintaining unresolved/resolved state in conversation
  * Fields: state_id:integer (resolved/unresolved)
  * Add User#current_issue_state_id:integer (User belongs_to :current_issue_state)
  * Add User has_many issue_states
* [ ] Participations model
  * Fields: issue_state_id:integer, user_id:integer
  * belongs_to :user
  * belongs_to :issue_state
  * IssueState has_many participations
  * Add User has_many participations
* [ ] Filters for conversation list
  * Conversations I've participated in (includes stuff assigned to me)
  * All conversations
* [ ] Detect if platform is heroku and use in-process Faye
* [ ] Rake tasks for initial setup
  * should create an admin user
  * set faye as broadcaster depending on the hosting platform
* [ ] Layout for login form (reuse the `manage` layout)

## Extending RadPike (TODO)

To extend RadPike you can create the following kinds of plugins

* **Formatters**
  Used to replace parts of a message with anything else. For example: replacing strings like ':)' with emoticons, replacing youtube links with youtube embeds, etc.

* **Interactive Widget**
  Used to create simple messages that contain elements with which the user can interact with - for example a survey form.

* **Chat action**
  Used to add actions to the chat options menu. Like a "Call" button or a "Send to CRM" button.


```javascript
// Adds a widget
App.plugins.widget('HelloWidget', function(activity){

});

// Adds a formatter
App.plugins.formatter('HelloPlugin', function(activity){
  
});

// Adds action to the chat menu
App.plugins.action('HelloAction', function(user, agent){
  
});
```

## Roadmap

In order of priority

* [Heroku] one-click install
* [Heroku] Updating RadPike from within the admin panel
* [VPS] Salt states for deploying RadPike on a VPS
* [VPS] Updating RadPike from within the admin panel
* [Plugins] Use Bullet (<https://github.com/extend/bullet>) for broadcasting instead of Faye on VPS
* [Plugins] Plugin management
* [Plugins] Central plugin repository (based on static files)
