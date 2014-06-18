Laptoprec.Routers.Router = Backbone.Router.extend({

  initialize: function(laptops, $rootEl){
    this.laptops = laptops
    this.$rootEl = $rootEl;
  },

  routes: {
    '': 'laptopQuestions',
  },

  laptopQuestions: function () {
    var questionsView = new Laptoprec.Views.QuestionsView({
      collection: this.laptops});
    this.$rootEl.html(questionsView.render().$el);
  },

})
