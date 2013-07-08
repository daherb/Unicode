require 'imlib2'
require './unicode'
class Unicode_img < Unicode

  def add_font_path(path)
    Imlib2::Font.add_path path
  end

  def init(filename,fontsize,width,height)
    @filename = filename
    @font_size = fontsize
    @width = width
    @height = height
    @img = Imlib2::Image.new(@width, @height)
    @img.fill_rect 0, 0, @width, @height, Imlib2::Color::WHITE
    @font = Imlib2::Font.new "ARIALUNI/" + fontsize.to_s
    @x = @font_size / 2
    @y = @font_size / 2
  end

  def putchar(bytes)
    s = ""
    pos = 0
    bytes.each do |b| 
      s += " "
      s.setbyte pos, b
      pos += 1
    end
    @x += (1.5 * @font_size).to_i
    if @x + (1.5 * @font_size).to_i >= @width
      @x = @font_size / 2
      @y += (1.5 * @font_size).to_i
    end
    @img.draw_text @font, s, @x, @y, Imlib2::Color::BLACK
  end
  
  def finish
    @img.save @filename
  end
  
end
