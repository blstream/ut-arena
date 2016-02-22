define(['backbone', 'models/game'], function(Backbone, Game) {

    return Backbone.Collection.extend({
        model: Game,
        url: "http://192.168.33.10:3000/games"
    });

});
