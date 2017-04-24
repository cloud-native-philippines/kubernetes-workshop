// app/assets/javascripts/application.js

//= require action_cable
//= require jquery
//= require jquery_ujs
//= require_tree ./channels
//= require_self

(function() {
    this.App || (this.App = {});
    console.log("App", this.App);

    App.cable = ActionCable.createConsumer();
}).call(this);
