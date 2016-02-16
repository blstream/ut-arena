define(['backbone', 'collections/games', 'views/game'], function(Backbone, GamesCollection, GameView) {

  return Backbone.View.extend({

  el: '#container',

  initialize: function() {

    this.collection = new GamesCollection();
    this.listenTo(this.collection, 'reset', this.render);
    this.collection.fetch({reset: true});

    this.$tbody = $('#games-table').find('tbody');
  },

  render: function () {

      this.$tbody.empty();
      this.collection.each(this.renderOne, this);
  },

  renderOne: function (game) {

      var view = new GameView({model: game});
      this.$tbody.append(view.render().el);
  }

  });
});
