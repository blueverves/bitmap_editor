class BitmapImage

  class Error < ArgumentError; end

  def initialize(w, h)
    validate_dimensions(w, h)
    @width = w
    @height = h
    clear
  end

  def clear
    @pixels = Array.new(@height){ Array.new(@width, "O") }
  end

  def color_pixel(x,y,c)
    validate_pixel(x, y)
    @pixels[y-1][x-1] = c
  end

  def draw_vertical(x, y1, y2, c)
    validate_vertical(x, y1, y2)
    (y1..y2).each{ |y| @pixels[y-1][x-1] = c }
  end

  def draw_horizontal(x1, x2, y, c)
    validate_horizontal(x1, x2, y)
    (x1..x2).each{ |x| @pixels[y-1][x-1] = c }
  end

  def fill_region(x, y, c)
    validate_dimensions(x, y)
    fill_with_same_color(x, y, c, @pixels[y-1][x-1])
    show
  end

  def show
    @pixels.each do |y|
      puts y.map { |x| x }.join(" ")
    end
  end

  private

  def validate_dimensions(w, h)
    if w < 1 || h < 1 || w > 250 || h > 250
      raise BitmapImage::Error.new("can't create image. Width and height must be at least 1")
    end
  end

  def validate_pixel(x, y)
    if y > @height || x > @width || y < 1 || x < 1
      raise BitmapImage::Error.new("can't color pixel. Coordinates don't exist")
    end
  end

  def validate_vertical(x, y1, y2)
    if y1 > @height || y2 > @height || y1 > y2 || x > @width || y1 < 1 || y2 < 1 || x < 1
      raise BitmapImage::Error.new("can't draw vertical. Coordinates are not valid")
    end
  end

  def validate_horizontal(x1, x2, y)
    if y > @height || x1 > @width || x2 > @width || x1 > x2 || y < 1 || x1 < 1 || x2 < 1
      raise BitmapImage::Error.new("can't draw horizontal. Coordinates are not valid")
    end
  end

  def fill_with_same_color(x, y, c, sc)
    return unless  y <= @height && x <= @width && y >= 1 && x >= 1 && @pixels[y-1][x-1] == sc
    @pixels[y-1][x-1] = sc
    fill_with_same_color(x+1 ,y , c, sc)
    fill_with_same_color(x-1 ,y , c, sc)
    fill_with_same_color(x ,y+1 , c, sc)
    fill_with_same_color(x ,y-1 , c, sc)
  end
end
