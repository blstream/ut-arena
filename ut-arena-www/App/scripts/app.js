require.config({
    baseUrl: 'scripts/',
    paths: {
        jquery: '../bower_components/jquery/dist/jquery',
        underscore: '../bower_components/underscore/underscore',
        backbone: '../bower_components/backbone/backbone',
    }
});

require(['routes/router'], function(Router){
    Router.initialize();
});
