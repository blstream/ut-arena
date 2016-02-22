define(['backbone', 'models/player'], function(Backbone, Player) {

    return Backbone.Collection.extend({
        model: Player,
        url: "http://192.168.33.10:3000/players"
    });

});
