define(['backbone', 'collections/games', 'views/game', 'text!../../partials/games.html'], 
			 function(Backbone, GamesCollection, GameView, GamesPartial) {

  return Backbone.View.extend({

    tagName: 'table',
    className: 'table table-striped',

    template: _.template(GamesPartial),

  initialize: function() {

    this.collection = new GamesCollection();
    this.listenTo(this.collection, 'reset', this.render);
    this.collection.fetch({reset: true});


  },

  render: function () {

    this.$el.html(this.template());
    this.$tbody = this.$el.find('tbody');

      this.$tbody.empty();
      this.collection.each(this.renderOne, this);

      return this;
  },

  renderOne: function (game) {

      var view = new GameView({model: game});
      this.$tbody.append(view.render().el);
  }

  });
});
