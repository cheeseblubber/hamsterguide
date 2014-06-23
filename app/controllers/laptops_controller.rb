class LaptopsController < ApplicationController
  def root

  end

  def index
    @laptops = Laptop.all
    render json: @laptops.to_json
  end

  private

  def laptop_params
    params.require(:laptop).permit(
      :min_price,
      :max_price,
      :touchscreen,
      :cpu,
      :dedicated_graphics,
      :min_width,
      :max_width,
      :detachable,
      :hdd,
      :ssd,
      :min_ram,
      :max_ram,
      :min_thickness,
      :max_thickness,
      :min_length,
      :max_length
    )
  end
end
