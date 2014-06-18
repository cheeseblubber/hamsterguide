namespace :fetch do
  desc "Updates laptop database and reclean"
  task laptops: :environment do
    #refactor
    Amazon::Ecs.configure do |options|
      options[:associate_tag] = 'buyalaptop0a-20'
      options[:AWS_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
      options[:AWS_secret_key] = ENV['AWS_SECRET_ACCESS_KEY']
    end

    price_ranges = [
      [20000, 27500],
      [27500, 34000],
      [34000, 39000],
      [39000, 44000],
      [44000, 49000],
      [49000, 55000],
      [55000, 62000],
      [62000, 70000],
      [70000, 80000],
      [80000, 95000],
      [110000, 130000],
      [130000, 160000],
      [160000, 220000]
    ]

    price_ranges.each do |price_range|
      min = price_range[0].to_s
      max = price_range[1].to_s
      10.times do |num|
        res = Amazon::Ecs.item_search(
         'laptop',
         search_index: 'Electronics',
         browse_node: '565108',
         response_group: 'ItemAttributes',
         sort: 'salesrank',
         item_page: num.to_s,
         minimum_price: min,
         maximum_price: max
        )

        res.items.each do |laptop|
          #refactor to move to outside method
          price = laptop.get('ItemAttributes/ListPrice/Amount')
          os = laptop.get('ItemAttributes/OperatingSystem')
          features = laptop.get_array('ItemAttributes/Feature')
          item_dimensions = laptop.get_element('ItemAttributes/ItemDimensions')

          next if item_dimensions.nil?

          width = item_dimensions.get('Width')
          thickness = item_dimensions.get("Height")
          weight = item_dimensions.get('Weight')
          length = item_dimensions.get('Length')
          next if length.nil? || width.nil?

          if length > width
            length, width = width, length
          end

          features_str = features.join('').downcase
          ssd = 0
          dedicated_graphics = false
          touchscreen = false
          detachable = false
          hdd = 0
          ram = nil
          cpu = ''

          # potentially clean up code by using a hash
          features.each do |feature|
            feature.downcase!
            if feature.include?('ssd') || feature.include?('solid-state')
              if feature.include?('512')
                ssd = 512
              elsif feature.include?('256')
                ssd = 256
              else
                ssd = feature.scan(/\d/).join('').to_i
              end
            end
            if feature.include?('touchscreen')
              touchscreen = true
            end
            if feature.include?('intel') || feature.include?('amd')
              cpu = feature
            end
            if feature.include?('dedicated graphics')
              dedicated_graphics = true
            end
            if feature.include?('rpm') || feature.include?('hard drive')
              if feature.include?('500')
                hdd = 500
              elsif feature.include?('320')
                hdd = 320
              elsif feature.include?('750')
                hdd = 750
              elsif feature.include?('tb')
                hdd = 1000
              elsif feature.include?('1024')
                hdd = 1000
              end
                            #
              hdd_feature = feature.scan(/\d/).join('')
              # if hdd_feature.include?('5400')
              #   hdd = hdd_feature.delete('5400').to_i
              # elsif hdd_feature.include?('7200')
              #   hdd = hdd_feature.delete('7200').to_i
              # else
              #   hdd = hdd_feature.to_i
              # end
              if hdd_feature.to_i == 1
                hdd = 1000
              end

            end
            if feature.include?('detachable')
              detachable = true
            end
            if feature.include?('ddr') || feature.include?('ram')
              ram = feature.scan(/\d/).join('')
              if ram[0..1].to_i > 16
                ram = ram[0].to_i
              else
                ram = ram[0..1].to_i
              end
            end
          end

          invalid_data = price.nil? || os.nil? || ram.nil?
          next if invalid_data
          next if ssd == 0 && hdd == 0
          # creating new laptop object
          laptop_obj = Laptop.new(
            ssd: ssd,
            width: width,
            length: length,
            thickness: thickness,
            ram: ram,
            hdd: hdd,
            touchscreen: touchscreen,
            detachable: detachable,
            asin_id: laptop.get('ASIN'),
            url: laptop.get('DetailPageURL'),
            price: price,
            dedicated_graphics: dedicated_graphics,
            os: os,
            cpu: cpu
          )
          next unless laptop_obj.valid?
          if laptop_obj.save
            p 'im saving'
          end
          # laptop_obj.save
        end
        sleep 1
      end
    end
  end

  task image_urls: :environment do
    Amazon::Ecs.configure do |options|
      options[:associate_tag] = 'buyalaptop0a-20'
      options[:AWS_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
      options[:AWS_secret_key] = ENV['AWS_SECRET_ACCESS_KEY']
    end
    Laptop.all.each do |laptop|
      # get images here
      res = Amazon::Ecs.item_lookup(laptop.asin_id, response_group: 'Images')
      image_set = res.items.first
      laptop.small_image_url = image_set.get('SmallImage/URL')
      laptop.medium_image_url = image_set.get('MediumImage/URL')
      laptop.large_image_url = image_set.get('LargeImage/URL')
      if laptop.save
        p 'shhh i m working'
      end
      sleep 1
    end

  end


end
