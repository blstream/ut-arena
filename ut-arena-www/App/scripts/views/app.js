define(['jquery', 'backbone'], function($, Backbone) {

    return Backbone.View.extend({

        el: $("#container"),

        renderView: function (view) {

            //remove prev view
            if (this.currentView){

                this.currentView.remove();
                this.currentView.unbind();

                if (this.currentView.onClose){
                    this.currentView.onClose();
                }
            }

            this.currentView = view;
            this.$el.html(this.currentView.render().el);
	    $.ajax({
                  type: 'POST',
                  url: "http://192.168.33.10/api/login",
                  data: {username: 'user', password: 'passs'},
                  success: function(resultData) { alert("Save Complete") }
            });
        }
    });
});
