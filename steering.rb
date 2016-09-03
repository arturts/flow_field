require_relative "vehicle"

class Steering < Processing::App
  attr_reader :vehicle

  def setup
    sketch_title "Steering Behavior"

    @vehicle = Vehicle.new(x: 320, y: 180)
  end

  def draw
    background 51

    target = Vec2D.new(mouse_x, mouse_y)

    vehicle.seek(target)
    vehicle.update!
    vehicle.display
  end

  def settings
    size 640, 360
  end
end
