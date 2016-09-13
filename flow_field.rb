class FlowField
  include Processing::Proxy

  attr_reader :field, :cols, :rows

  def initialize(cols:, rows:)
    @cols = cols
    @rows = rows

    @field = Array.new(cols) { Array.new(rows) }

    init!
  end

  def init!
    noise_seed(seed = random(100))
    puts "Seed for perlin noise: #{seed}"

    x_off = 0
    cols.times do |i|
      y_off = 0
      rows.times do |j|
        theta = map1d(noise(x_off, y_off), 0..1, 0..TWO_PI)

        field[i][j] = Vec2D.from_angle(theta)
        y_off += 0.01
      end
      x_off += 0.01
    end
  end

  def lookup(position)
    x = (position.x / width * cols).to_i - 1
    y = (position.y / height * rows).to_i - 1
    field[x][y]
  end
end
