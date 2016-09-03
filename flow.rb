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
    @flow_field = FlowField.new(cols: 32, rows: 18)
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

  def settings
    size 640, 360
  end
end
