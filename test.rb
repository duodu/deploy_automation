require 'win32ole'
test_excel = 'E:/lib/test2.xlsx'

excel = WIN32OLE::new('excel.Application')
workbook = excel.Workbooks.Open(test_excel)
worksheet = workbook.Worksheets(1)
worksheet.Select

#rows2 = workbook.Worksheets(1).UsedRange.rows.Count
#columns2 = workbook.Worksheets(1).UsedRange.columns.Count
end_row_line = workbook.Worksheets(1).UsedRange.rows.Count
col = Array.new
i = 0
line = 1
while i < 6 && line <= end_row_line
  if worksheet.Range("A#{line}").value == 'commom'
    col[i] = line
    puts col[i]
    i += 1
  end
  line += 1
end

workbook.close
excel.Quit

puts col.size