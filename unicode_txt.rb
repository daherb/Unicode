require 'imlib2'
require './unicode'
class Unicode_txt < Unicode

  def init(textfile)
    @textfile = File.open(textfile,'wb')
  end

  def putchar(bytes)
    s = ""
    pos = 0
    bytes.each do |b| 
      s += " "
      s.setbyte pos, b
      pos += 1
    end
    s += " "
    @textfile.write s
  end
  
  def finish
    @textfile.close
  end
  
end
