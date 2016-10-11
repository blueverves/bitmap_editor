class BitmapImage

  def initialize(w, h)
    @width = w
    @height = h
    clear
  end

  def clear
    @pixels = Array.new(@height){ Array.new(@width, "O") }
  end

  def color_pixel(x,y,c)
    @pixels[y-1][x-1] = c
  end

  def draw_vertical(x, y1, y2, c)
    (y1..y2).each{ |y| @pixels[y-1][x-1] = c }
  end

  def draw_horizontal(x1, x2, y, c)
    (x1..x2).each{ |x| @pixels[y-1][x-1] = c }
  end

  def show
    @pixels.each do |y|
      puts y.map { |x| x }.join(" ")
    end
  end

end
