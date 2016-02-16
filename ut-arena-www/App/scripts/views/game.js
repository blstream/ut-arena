define(['backbone', 'underscore', 'jquery'], function(Backbone, _, $) {
return Backbone.View.extend({

  tagName: 'tr',

  template: _.template($('#game-template').html()),

  render: function () {

    this.$el.html(this.template(this.model.toJSON()));
    return this;
  },

  });

});
