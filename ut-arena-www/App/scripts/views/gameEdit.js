define(['backbone', 'modelbinder', 'models/game', 'text!../../partials/game-edit.html'], 
			 function(Backbone, ModelBinder, GameModel, GameEditPartial) {

  return Backbone.View.extend({

    tagName: 'form',
			
    className: 'form-horizontal',

    template: _.template(GameEditPartial),

		events: {
      'click #saveButton': 'saveGame'
		},
			
		initialize: function(id) {
      this.model = new GameModel({id: id});
      this.modelBinder = new ModelBinder();
  	},
		
		render: function () {

			this.$el.html(this.template());
      this.modelBinder.bind(this.model, this.$el);
      this.model.fetch();
      
			return this;
		},
    
    saveGame: function (e) {
      
        this.model.save(null, {
          success: function (model, response) {
              console.log("success");
          },
          error: function (model, response) {
              console.log("error");
          }
      });
      
      e.preventDefault();
      e.stopPropagation();
      
    }
    
  });
		
});
