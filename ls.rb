# frozen_string_literal: true

files = Dir.glob('*', sort: true)

p files

line = if (files.size % 3).zero?
         files.size / 3
       else
         files.size / 3 + 1
       end
width = files.max_by(&:size).size
p width
p line

lined_up_files = []
files.each_slice(line) do |n|
  lined_up_files << n
end

p lined_up_files

max_size = lined_up_files.map(&:size).max
lined_up_files.map! { |it| it.values_at(0...max_size) }

p lined_up_files


lined_up_files.transpose.each do |lined_up_file|
  lined_up_file.each do |n|
    print n.ljust(width + 3) unless n.nil?
  end
  puts
end

# p h = (1..files.size).to_a.group_by{|i| i % line}

# subscript = 0
# files.size.times do |n|
#   print files[subscript].ljust(20)
#   if subscript >= files.size
#   subscript += line
#
# end

