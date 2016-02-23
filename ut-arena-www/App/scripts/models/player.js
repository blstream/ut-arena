define(['backbone'], function(Backbone) {

    return Backbone.Model.extend({
      url: "http://192.168.33.10:3000/players"
    });

});
