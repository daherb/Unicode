require './unicode_img.rb'
require './unicode_txt.rb'
def usage
  puts "Usage: ruby generate.rb (-img | -txt) filename"
  exit
end

if ARGV.size < 2
  usage
else
  if ARGV[0] == "-img"
    $u = Unicode_img.new
#    $u.add_font_path '/usr/share/fonts'
    $u.init ARGV[1], 20, (11.7 * 600).to_i, (16.5 * 600).to_i
  elsif ARGV[0] == "-txt"
    $u = Unicode_txt.new
    $u.init ARGV[1]
  else
    usage
  end
  $u.generate [(0..0xD7FF),(0xE000..0xFFFF),(0x10000..0x10FFFF)]
  $u.finish
end
