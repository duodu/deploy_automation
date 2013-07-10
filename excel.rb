require 'roo'
require File.expand_path('../config.rb', __FILE__)

$excel = Roo::Excelx.new($deploy_excel)
$excel.default_sheet = $excel.sheets.first
end_row_line = $excel.last_row

def file_to_instance
  $instance.each do |instance|
    common_array = Array.new
    mall_array=Array.new
    payment_array=Array.new
#common
    line = instance[:column]
      while $excel.cell('A',line) != nil
        if  $excel.cell('A',line) =~ /ar\z/
          common_array << $excel.cell('A',line)
        end
        line += 1
      end
      instance[:common] = common_array
      # puts 'common'
      # puts common_array
#mall
    line = instance[:column]
      while $excel.cell('B',line) != nil
        if  $excel.cell('B',line) =~ /ar\z/
          mall_array << $excel.cell('B',line)
        end
        line += 1
      end
      instance[:mall] = mall_array
      # puts 'mall'
      # puts mall_array
#payment
    line = instance[:column]
      while $excel.cell('C',line) != nil
        if  $excel.cell('C',line) =~ /ar\z/
          payment_array << $excel.cell('C',line)
        end
        line += 1
      end
      instance[:payment] = payment_array
      # puts 'payment'
      # puts payment_array
  end
end

file_to_instance
puts $instance.size
$instance.each do |i|
  puts i[:ip]
  puts i[:username]
  puts "mall"
  puts i[:mall]
  puts "payment"
  puts i[:payment]
  puts "common"
  puts i[:common]
end