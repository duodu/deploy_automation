require 'win32ole'
require File.expand_path('../config.rb', __FILE__)

$excel = WIN32OLE::new('excel.Application')
$workbook = $excel.Workbooks.Open($deploy_excel)
$worksheet = $workbook.Worksheets(1)
$worksheet.Select

def file_to_instance
  $instance.each do |instance|
    common_array = Array.new
    mall_array=Array.new
    payment_array=Array.new
#common
    line = instance[:column]
      while $worksheet.Range("A#{line}").value != nil
        if  $worksheet.Range("A#{line}").value =~ /ar\z/
          common_array << $worksheet.Range("A#{line}").value
        end
        line += 1
      end
      instance[:common] = common_array
#mall
    line = instance[:column]
      while $worksheet.Range("B#{line}").value != nil
        if  $worksheet.Range("B#{line}").value =~ /ar\z/
          mall_array << $worksheet.Range("B#{line}").value
        end
        line += 1
      end
      instance[:mall] = mall_array
#payment
    line = instance[:column]
      while $worksheet.Range("C#{line}").value != nil
        if  $worksheet.Range("C#{line}").value =~ /ar\z/
          payment_array << $worksheet.Range("C#{line}").value
        end
        line += 1
      end
      instance[:payment] = payment_array
  end
end

file_to_instance

$workbook.close
$excel.Quit
