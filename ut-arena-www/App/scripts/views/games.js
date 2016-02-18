define(['backbone', 'collections/games', 'views/game'], function(Backbone, GamesCollection, GameView) {

  return Backbone.View.extend({

    tagName: 'table',
    className: 'table table-striped',

    template: _.template($('#games-view').html()),

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
