# frozen_string_literal: true

require 'etc'

files = Dir.glob('*', sort: true)
# ここで-a, -rオプションの処理
p files

# ここで`-l`オプションの処理

def filetype(filemode)
  {
    '10' => '-',
    '04' => 'd'
  }[filemode]
end

def permission(filemode)
  {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }[filemode]
end

puts "total #{files.inject(0) { |total, file| total + File.stat(file).blocks }}"
files.each do |file|
  fileinfo = File.stat(file)
  filemode = fileinfo.mode.to_s(8)
  print filetype(filemode[0, 2])
  print permission(filemode[3])
  print permission(filemode[4])
  print permission(filemode[5])
  print "#{permission(filemode[6])} "
  print fileinfo.nlink
  print "#{Etc.getpwuid(fileinfo.uid).name} "
  print "#{fileinfo.size} "
  print "#{fileinfo.mtime.strftime('%b %e %R')} "
  print file
  puts
end

# line = if (files.size % 3).zero?
#          files.size / 3
#        else
#          files.size / 3 + 1
#        end

# lined_up_files = []
# if files.size == 4
#   lined_up_files << [files[0], files[1]]
#   lined_up_files << [files[2]]
#   lined_up_files << [files[3]]
# else
#   files.each_slice(line) do |n|
#     lined_up_files << n
#   end
# end
# max_size = lined_up_files.map(&:size).max
# lined_up_files.map! { |it| it.values_at(0...max_size) }
#
# width = files.max_by(&:size).size
# lined_up_files.transpose.each do |lined_up_file|
#   lined_up_file.each do |n|
#     print n.ljust(width + 3) unless n.nil?
#   end
#   puts
# end

# p h = (1..files.size).to_a.group_by{|i| i % line}

# subscript = 0
# files.size.times do |n|
#   print files[subscript].ljust(20)
#   if subscript >= files.size
#   subscript += line
#
# end
