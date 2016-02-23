define(['jquery', 'underscore', 'backbone', 'views/app'], function($, _, Backbone, AppView){
    var AppRouter = Backbone.Router.extend({
        routes: {
            'players': 'showPlayers',
            'players/add': 'addPlayer',
            'games': 'showGames',
            'games/edit/:id': 'editGame',
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

        appRouter.on('route:editGame', function(id){
            require(['views/gameEdit'], function (GameEditView) {
                appView.renderView(new GameEditView(id));
            });
        });
      
        appRouter.on('route:showPlayers', function(){
            require(['views/players'], function (PlayersView) {
                appView.renderView(new PlayersView());
            });
        });

        appRouter.on('route:addPlayer', function(){
						require(['views/playerEdit'], function (PlayerEditView) {
                appView.renderView(new PlayerEditView());
            });
        });
        
        Backbone.history.start();
    };
    return {
        initialize: initialize
    };
});
