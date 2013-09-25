# RadPike

[[Work-In-Progress]]

## Requirements

* Ruby 2.0 or greater
* Postgresql (with HStore)


## Rethinking features

* Users can chat and perform actions on chat.
* No issue states - leave it to the ticketing apps
* Participant states in a conversation
  * Present
  * Not present
  * Deactive (was present)


## TODO

* tests
* widget styling
* polishing dashboard
* conversation polling
* add-to-conversation
* Site navigation

## Extending RadPike (TODO)

TODO - plugin APIs haven't been fleshed out yet. Hold on.

To extend RadPike you can create the following kinds of plugins

* **Formatters**
  Used to replace parts of a message with anything else. For example: replacing strings like ':)' with emoticons, replacing youtube links with youtube embeds, etc.


* **Chat action**
  Used to add actions to the chat options menu. Like a "Call" button or a "Send to CRM" button.


```javascript

// Adds a formatter
App.plugins.formatter('HelloPlugin', function(activity){
  
});

// Adds action to the chat menu
App.plugins.action('HelloAction', function(user, agent){
  
});
```

## Roadmap

In order of priority

* [VPS] Updating RadPike from within the admin panel
* [Plugins] Plugin management
* [Plugins] Central plugin repository (based on static files)

## Features

Create an issue for a feature or send a pull request. I'll see if it can be squeezed in.
