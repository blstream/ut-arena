define(['backbone', 'underscore', 'jquery', 'text!../../partials/player.html'], 
			 function(Backbone, _, $, PlayerPartial) {
return Backbone.View.extend({

  tagName: 'tr',

  template: _.template(PlayerPartial),

  render: function () {

    this.$el.html(this.template(this.model.toJSON()));
    return this;
  },

  });

});
