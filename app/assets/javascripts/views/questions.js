Laptoprec.Views.QuestionsView = Backbone.CompositeView.extend({

  template: JST['questions/questionsView'],


  initialize: function () {
    this.filters = {
      max_price: 500000,
      min_ssd: 0,
      touchscreen: false,
      dedicated_graphics: false,
      os: 'chrome',
      thickness: 1000,
      max_width: 10000,
      min_width: 0,
      min_ram: 0,
      max_ram: 100
    }
    this.filtered_laptops = []
    this.submited = false
  },

  events: {
    "submit": "submitquestions",
    "mouseover .info": 'showTooltip'
  },

  render: function () {
    var renderedContent = this.template({
      laptops: this.collection,
    });
    this.$el.html(renderedContent);
    return this;
  },

  renderRecommendations: function() {
    var that = this
    var recommendationsView = new Laptoprec.Views.Recommendations({
      laptops: this.filtered_laptops
    })
    this.addSubView('.recommendations', recommendationsView)
    recommendationsView.render()
  },

  showTooltip: function () {
    $(event.target).tooltip("show")
  },

  submitquestions: function () {
    event.preventDefault();

    $('.recommendations').html('')

    var data = $('form').serializeJSON();
    if(data.size) {
      this.filter_size(data.size);
    }
    this.filters.max_price = parseInt(data.max_price);
    this.uses_filter(data.purpose);
    this.filters.os = data.os;
    this.filter_laptops()
    this.renderRecommendations();
    this.submited = true

  },

  uses_filter: function (purpose) {
    switch (purpose) {
    case 'Business':
      this.business_filter()
      break;
    case 'All-Purpose':
      this.all_purpose_filter()
      break;
    case 'Gaming':
      this.gaming_filter();
      break;
    case 'Creative':
      this.creative_filter();
      break;
    case 'Secondary':
      this.secondary_filter();
    default:
      this.all_purpose_filter()
    }
  },

  business_filter: function () {
    this.filters.min_ram = 3;
    this.filters.max_ram = 13;
    // console.log('business')
  },

  all_purpose_filter: function() {
    this.filters.min_ram = 1;
    this.filters.max_ram = 20;
    // console.log('all purpose')
  },

  filter_size: function (params) {
    var size_range = params.split(",")
    this.filters.min_width = parseInt(size_range[0])
    this.filters.max_width = parseInt(size_range[1])
    // console.log('size filter')
  },

  gaming_filter: function () {
    // console.log('gaming')
    this.min_ram = 7
  },

  creative_filter: function () {
    // console.log('creative')
    this.min_ram = 7
    this.min_ssd = 1
  },

  secondary_filter: function () {
    this.max_ram = 9
    // console.log('secondary filter')
  },

  filter_laptops: function () {
    var that = this
    if(this.filtered_laptops.length > 0) {
      this.filtered_laptops = []
    }
     this.filtered_laptops.push(this.collection.models.filter(function (model) {
       // if (model.get('os').indexOf(that.filters.os != -1)) {
       //   debugger
       // };
       return (model.get('price') < that.filters.max_price &&
              // model.get('ssd') > that.filters.min_ssd &&
              model.get('touchscreen') === that.filters.touchscreen &&
              model.get('dedicated_graphics') === that.filters.dedicated_graphics &&
              model.get('thickness') < that.filters.thickness &&
              model.get('width') < that.filters.max_width &&
              model.get('width') > that.filters.min_width &&
              model.get('ram') < that.filters.max_ram &&
              model.get('ram') > that.filters.min_ram &&
              model.get('os').toLowerCase().indexOf(that.filters.os.toLowerCase()) != -1
            )
    }));
  }
})
