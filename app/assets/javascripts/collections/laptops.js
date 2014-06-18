Laptoprec.Collections.Laptops = Backbone.Collection.extend({
  model: Laptoprec.Models.Laptop,

  url: 'laptops#index',

  comparator: function (model) {
    return model.get('price')
  },
})
