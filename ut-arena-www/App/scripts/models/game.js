define(['backbone'], function(Backbone) {

    return Backbone.Model.extend({
      urlRoot: "http://192.168.33.10:3000/games"
    });

});
