define(['backbone', 'models/player'], function(Backbone, Player) {

    return Backbone.Collection.extend({
        model: Player,
        url: "http://localhost:3000/players"
    });

});
