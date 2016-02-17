define(['jquery', 'underscore', 'backbone', 'views/app'], function($, _, Backbone, AppView){
    var AppRouter = Backbone.Router.extend({
        routes: {
            'players': 'showPlayers',
            'games': 'showGames',
            '*actions': 'showGames'
        }
    });

    var initialize = function(){
        var appRouter = new AppRouter;
        var appView = new AppView();

        appRouter.on('route:showGames', function(){
            require(['views/games'], function (GamesView) {
                appView.renderView(new GamesView());
            });
        });

        appRouter.on('route:showPlayers', function(){
            require(['views/players'], function (PlayersView) {
                appView.renderView(new PlayersView());
            });
        });

        Backbone.history.start();
    };
    return {
        initialize: initialize
    };
});
