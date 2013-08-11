# RadPike

Work-In-Progress

## Notes on views

#### Maintaining the concept of conversations without database table

* Unreplied conversations older than 3min is shown in the conversations list in reverse chronological order.

* To keep track of guest users use the ID of the guest user in js, if it's a guest.

## TaskList for v1

* Member management
  * Errors on member form
  * Check if password change works
* Fix right margin on members management page (.member right margin)
* Define User#is_active? to block deactivated-agents form logging in
* Posting messages
* Authentication/Authorization
* Running messages thru plugins
* Faye for websockets
* Auto-scrolling on new message
* Scroll to end on opening a conversation
* Support widget embed
* Filters for conversation list
* Detect if platform is heroku and use in-process Faye
* A proper query for listing conversations
* Rake tasks for initial setup
  * should create an admin user
  * set faye as broadcaster depending on the hosting platform
* Layout for login form

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
