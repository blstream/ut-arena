require.config({
    baseUrl: 'scripts/',
    paths: {
        jquery: '../bower_components/jquery/dist/jquery',
        underscore: '../bower_components/underscore/underscore',
        backbone: '../bower_components/backbone/backbone',
        modelbinder: '../bower_components/backbone.modelBinder/Backbone.ModelBinder',
				text: '../bower_components/text/text'
    }
});

require(['routes/router'], function(Router){
    Router.initialize();
});
