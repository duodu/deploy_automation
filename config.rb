require 'win32ole'

#部署配置的EXCEL文件
$deploy_excel = 'E:/lib/deploy_colorful.xlsx'
#部署包的目录
$deploy_dir = 'E:/lib/mall'

#取EXCEL行数
excel = WIN32OLE::new('excel.Application')
workbook = excel.Workbooks.Open($deploy_excel)
worksheet = workbook.Worksheets(1)
worksheet.Select

end_row_line = workbook.Worksheets(1).UsedRange.rows.Count
col = Array.new
i = 0
line = 1
while i < 6 && line <= end_row_line
  if worksheet.Range("A#{line}").value == 'common'
    col[i] = line
    i += 1
  end
  line += 1
end
workbook.close
excel.Quit
#展示层app01
instance_cp_01 = {
    :common => nil,
    :mall => nil,
    :payment => nil,
    :ip => '10.48.192.16',
    :port => 10051,
    :username => 'app01',
    :password => 'handpay',
    :column => col[0],#EXCEL中的行数
    :delete => false,
    :restart => false,
    :destination => '/opt/app01/server/default/deploy/'
  }

#展示层app02
instance_cp_02 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '10.48.192.16',
    :port => 10051,
    :username => 'app02',
    :password => 'handpay',
    :column => col[1],#EXCEL中的行数
    :delete => false,
    :restart => false,
    :destination => '/opt/app02/server/default/deploy/'
  }

#展示层app03
instance_cp_03 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '10.48.192.16',
    :port => 10051,
    :username => 'app03',
    :password => 'handpay',
    :column => col[2],#EXCEL中的行数
    :delete => false,
    :restart => false,
    :destination => '/opt/app03/server/default/deploy/'
  }

#核心层app01
instance_cc_01 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '10.48.192.13',
    :port => 22,
    :username => 'app01',
    :password => 'handpay',
    :column => col[3],#EXCEL中的行数
    :delete => false,
    :restart => false,
    :destination => '/opt/app01/server/default/deploy/'
  }

#核心层app02
instance_cc_02 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '10.48.192.13',
    :port => 22,
    :username => 'app02',
    :password => 'handpay',
    :column => col[4],#EXCEL中的行数
    :delete => false,
    :restart => false,
    :destination => '/opt/app02/server/default/deploy/'
  }


#核心层app03
instance_cc_03 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '10.48.192.13',
    :port => 22,
    :username => 'app03',
    :password => 'handpay',
    :column => col[5],#EXCEL中的行数
    :delete => false,
    :restart => false,
    :destination => '/opt/app03/server/default/deploy/'
  }

#所有实例
$instance=[
  instance_cp_01,
  instance_cp_02,
  instance_cp_03,
  instance_cc_01,
  instance_cc_02,
  instance_cc_03

  ]
#$instance=[$instance_cp_01,$instance_cp_02,$instance_cp_03]