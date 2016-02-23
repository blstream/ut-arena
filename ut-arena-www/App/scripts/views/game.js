define(['backbone', 'underscore', 'jquery', 'text!../../partials/game.html'], 
			 function(Backbone, _, $, GamePartial) {
return Backbone.View.extend({

    tagName: 'tr',

    template: _.template(GamePartial),

    events: {
      "click .btn-delete": 'deleteGame'
    },

    render: function () {

      this.$el.html(this.template(this.model.toJSON()));
      return this;
    },

    editGame: function () {
      
    }
  
  });

});
