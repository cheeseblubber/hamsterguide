Laptoprec.Views.Recommendations = Backbone.View.extend({

  template: JST['questions/recommendationView'],

  className: 'row',

  initialize: function (laptops){
    this.laptops = laptops
  },

  render: function() {
    //fix this.laptops.laptops[0]
    var renderedContent = this.template({
      laptops: this.laptops.laptops[0]
    })
    console.log("this is in recommendations")
    this.$el.html(renderedContent);
    return this;
  }
})
