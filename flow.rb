require_relative "vehicle"
require_relative "flow_field"

class Flow < Processing::App
  attr_reader :vehicles, :flow_field

  VEHICLE_QTY = 120

  def setup
    sketch_title "Flow Field"

    @vehicles = [].tap do |vehicles|
      VEHICLE_QTY.times { vehicles << Vehicle.new }
    end
    @flow_field = FlowField.new(cols: 128, rows: 72)
  end

  def draw
    background 51

    vehicles.each do |vehicle|
      velocity = flow_field.lookup(vehicle.position)
      vehicle.apply_force!(velocity)
      vehicle.update!
      vehicle.display
    end
  end

  def mouse_pressed
    puts "mouse pressed"
    flow_field.init!
  end

  def settings
    size 1280, 720
  end
end
