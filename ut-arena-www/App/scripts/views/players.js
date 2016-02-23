define(['backbone', 'collections/players', 'views/player', 'text!../../partials/players.html'], 
			 function(Backbone, PlayersCollection, PlayerView, PlayersPartial) {

  return Backbone.View.extend({

    tagName: 'table',
    className: 'table table-striped',

    template: _.template(PlayersPartial),

  initialize: function() {

    this.collection = new PlayersCollection();
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

  renderOne: function (player) {

      var view = new PlayerView({model: player});
      this.$tbody.append(view.render().el);
  }

  });
});
