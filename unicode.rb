class Unicode

  def numbertobytes(number)
    bytes = Array.new
    if number < 2 ** 7
      bytes.push number
    else
      while number > (2 ** 5 - 1)
        #    puts "Number : " + number.to_s(2)
        byte = 2 ** 7 + (number & 2 ** 6 - 1)
        #    puts "Byte : " + byte.to_s(2)
        bytes.unshift byte
        number = number>>6
      end
      #  puts "Number : " + number.to_s(2)
      byte = 0
      0.upto(bytes.count) do
        byte = byte>>1
        byte += 2**7
      end
      byte += number
      #  puts "Byte : " + byte.to_s(2)
      bytes.unshift byte
    end
    return bytes
  end

  def generate(ranges)
    ranges.each do |range|
      range.each do |number|
        putchar(numbertobytes(number))
      end
    end
  end

end
    
