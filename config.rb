#部署配置的EXCEL文件
$deploy_excel = 'E:/lib/deploy.xlsx'
#部署包的目录
$deploy_dir = 'E:/lib/'

#展示层app01
$instance_cp_01 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '192.168.1.4',
    :port => 22,
    :username => 'root',
    :password => 'zerolin',
    :column => 2,#EXCEL中的行数
    :destination => '/opt/app01/server/default/deploy/'
  }

#展示层app02
$instance_cp_02 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '192.168.1.4',
    :port => 22,
    :username => 'root',
    :password => 'zerolin',
    :column => 9,#EXCEL中的行数
    :destination => '/opt/app02/server/default/deploy/'
  }

#展示层app03
$instance_cp_03 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '192.168.1.4',
    :port => 2,
    :username => 'root',
    :password => 'zerolin',
    :column => 14,#EXCEL中的行数
    :destination => '/opt/app03/server/default/deploy/'
  }

#核心层app01
$instance_cc_01 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '10.48.192.13',
    :port => 22,
    :username => 'app01',
    :password => 'handpay',
    :column => 2,#EXCEL中的行数
    :destination => '/opt/app01/server/default/deploy/'
  }

#核心层app02
$instance_cc_02 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '10.48.192.13',
    :port => 22,
    :username => 'app02',
    :password => 'handpay',
    :column => 2,#EXCEL中的行数
    :destination => '/opt/app02/server/default/deploy/'
  }


#核心层app03
$instance_cc_03 = {
    :common => nil, 
    :mall => nil, 
    :payment => nil, 
    :ip => '10.48.192.13',
    :port => 22,
    :username => 'app03',
    :password => 'handpay',
    :column => 2,#EXCEL中的行数
    :destination => '/opt/app03/server/default/deploy/'
  }

#所有实例
#$instance=[$instance_cc_01,$instance_cc_02,$instance_cc_03,$instance_cp_01,$instance_cp_02,$instance_cp_03]
$instance=[$instance_cc_01,$instance_cc_02,$instance_cc_03]