require 'imlib2'
require 'ttfunk'
require 'pathname'
require './unicode'
class Unicode_img < Unicode
  @prev = 0
  def add_font_path(path)
    Imlib2::Font.add_path path
  end

  def init(filename,fontsize,width,height)
    fontpfad = '/media/Windows7/Windows/Fonts/'
    Imlib2::Font.add_path fontpfad
    @fonts = Array.new
    @stats = Hash.new
    @fontlist = Imlib2::Font.list_fonts.select { |f| f.match(/^[a-zA-Z]/) } 
    @fontlist.each do |name|
      if (File.exists?(fontpfad + name + ".ttf"))
        fontdatei = fontpfad + name + ".ttf"
      elsif (File.exists?(fontpfad + name + ".TTF"))
        fontdatei = fontpfad + name + ".TTF"
      else
        fontdatei = nil
      end
      if (!fontdatei.nil?)
        @fonts.push ( { 
                        "name" => name,
                        "imlib" => ( Imlib2::Font.new ( name + "/" + fontsize.to_s ) ) ,
                        "ttfunk" => TTFunk::File.open(fontdatei)
                      } )
      end
    end
    @filename = filename
    @font_size = fontsize
    @width = width
    @height = height
    @img = Imlib2::Image.new(@width, @height)
    @img.fill_rect 0, 0, @width, @height, Imlib2::Color::WHITE
    @font = Imlib2::Font.new "arial/" + fontsize.to_s
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
    code = s.unpack("U*").first
    $stderr.print "0x" + code.to_s(16) + ":"
    @fonts.each do |font|
      if (!font["ttfunk"].cmap.unicode.first.nil?)
        if (font["ttfunk"].cmap.unicode.first[code] != 0)
          if (@prev == font["ttfunk"].cmap.unicode.first[code])
          end
        @prev = font["ttfunk"].cmap.unicode.first[code]
          @img.draw_text font["imlib"], s, @x, @y, Imlib2::Color::BLACK
          if (@stats[font["name"]].nil?)
            @stats[font["name"]] = 1
        else
            @stats[font["name"]] += 1
          end
          break
        else
          if (@stats["none"].nil?)
          @stats["none"] = 1
          else
            @stats["none"] += 1
          end
        end
      end
    end
  end

  def finish
    @img.save @filename
    puts @stats
  end
  
end
