class Vehicle
  include Processing::Proxy

  attr_reader :position, :velocity, :acceleration, :max_speed, :max_force

  def initialize(x:, y:, max_speed: 5, max_force: 0.2)
    @position = Vec2D.new(x, y)
    @velocity = Vec2D.new(0, 0);
    @acceleration = Vec2D.new(0, 0);
    @max_speed = max_speed
    @max_force = max_force
  end

  def apply_force(force)
    @acceleration += force
  end

  def seek(target)
    apply_force(steering(target))
  end

  def update
    @velocity += acceleration
    velocity.limit(max_speed)
    @position += velocity
    @acceleration.set_mag(0)
  end

  def display
    fill 255, 150
    stroke 255
    ellipse position.x, position.y, 48, 48
  end

  private

  def steering(target)
    (desired(target) - velocity).tap { |v| v.limit(max_force) }
  end

  def desired(target)
    (target - position).tap { |v| v.set_mag(max_speed) }
  end
end

class Vec2D
  # does nothing unless mag > scalar
  def limit(scalar)
    set_mag(scalar) { mag > scalar }
  end
end
