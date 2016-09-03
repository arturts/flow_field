class Vehicle
  include Processing::Proxy

  attr_reader :position, :velocity, :acceleration, :max_speed, :max_force, :r

  def initialize(x:, y:, max_speed: 5, max_force: 0.2, r: 3)
    @position     = Vec2D.new(x, y)
    @velocity     = Vec2D.new(0, 0);
    @acceleration = Vec2D.new(0, 0);
    @max_speed    = max_speed
    @max_force    = max_force
    @r            = r
  end

  def apply_force!(force)
    @acceleration += force
  end

  def arrive(target)
    apply_force!(steering(target))
  end

  def update!
    @velocity += acceleration
    velocity.limit(max_speed)
    @position += velocity
    @acceleration.set_mag(0)
  end

  def display
    # Draw a triangle in the direction of velocity
    theta = velocity.heading + PI / 2

    fill 127
    stroke 200
    stroke_weight 1

    push_matrix

    translate position.x, position.y
    rotate theta

    begin_shape
    vertex(0, -r * 2)
    vertex(-r, r * 2)
    vertex(r, r * 2)
    end_shape CLOSE
    pop_matrix
  end

  private

  def steering(target)
    (desired(target) - velocity).tap { |v| v.limit(max_force) }
  end

  def desired(target)
    (target - position).tap do |v|
      desired_mag = if (distance = v.mag) < 100
                      map1d(distance, 0..100, 0..max_speed)
                    else
                      max_speed
                    end
      v.set_mag(desired_mag)
    end
  end
end

class Vec2D
  # does nothing unless mag > scalar
  def limit(scalar)
    set_mag(scalar) { mag > scalar }
  end
end
