require './lib/bitmap_image'

class BitmapEditor

  def run
    @running = true
    @image = nil
    puts 'type ? for help'
    while @running
      print '> '
      parse_input(gets.chomp)
    end
  end

  def parse_input(string)
    case string
    when /I (\d+) (\d+)/
      @image = BitmapImage.new($1.to_i, $2.to_i)
    when 'C'
      @image.clear
    when /L (\d+) (\d+) (.+)/
      @image.color_pixel($1.to_i, $2.to_i, $3)
    when /V (\d+) (\d+) (\d+) (.+)/
      @image.draw_vertical($1.to_i, $2.to_i, $3.to_i, $4)
    when /H (\d+) (\d+) (\d+) (.+)/
      @image.draw_horizontal($1.to_i, $2.to_i, $3.to_i, $4)
    when 'S'
      @image.show
    when '?'
      show_help
    when 'X'
      exit_console
    else
      puts 'unrecognised command :('
    end
  end

  def image
    @image
  end

  private
  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def show_help
    puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
  end

end
