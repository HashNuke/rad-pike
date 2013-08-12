# RadPike

Work-In-Progress

## Notes on views

#### Maintaining the concept of conversations without database table

* Conversations with latest updates are displayed first.

* To keep track of guest users, use the ID of the guest user in js, if it's a guest.

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
