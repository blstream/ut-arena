define(['backbone', 'models/game'], function(Backbone, Game) {

    return Backbone.Collection.extend({
        model: Game,
        url: "http://localhost:3000/games"
    });

});
