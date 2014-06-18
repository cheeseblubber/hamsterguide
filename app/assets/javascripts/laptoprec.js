window.Laptoprec = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {
    var $rootEl = $('#content')
    var laptops = new Laptoprec.Collections.Laptops();
    laptops.fetch({
      success: function () {
        var router = new Laptoprec.Routers.Router(laptops, $rootEl);
        Backbone.history.start();
      },
      error: function () {
        console.log('Failed to fetch.');
      }
    });
  }
}
