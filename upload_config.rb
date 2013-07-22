#部署包的目录
$deploy_dir = 'E:/lib'

#展示层app01
instance_cp_01 = {
    :common => nil,
    :mall => nil,
    :payment => nil,
    :ip => '10.48.192.16',
    :port => 10051,
    :username => 'app01',
    :password => 'handpay',
    :delete => false,
    :restart => false,
    :dir => [ '/opt/app01/server/default/deploy/mall/',
              '/opt/app01/server/default/deploy/payment/',
              '/opt/app01/server/default/deploy/common/' ]
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
    :delete => false,
    :restart => false,
    :dir => [ '/opt/app02/server/default/deploy/mall/',
              '/opt/app02/server/default/deploy/payment/',
              '/opt/app02/server/default/deploy/common/' ]
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
    :delete => false,
    :restart => false,
    :dir => [ '/opt/app03/server/default/deploy/mall/',
              '/opt/app03/server/default/deploy/payment/',
              '/opt/app03/server/default/deploy/common/' ]
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
    :delete => false,
    :restart => false,
    :dir => [ '/opt/app01/server/default/deploy/mall/',
              '/opt/app01/server/default/deploy/payment/',
              '/opt/app01/server/default/deploy/common/' ]
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
    :delete => false,
    :restart => false,
    :dir => [ '/opt/app02/server/default/deploy/mall/',
              '/opt/app02/server/default/deploy/payment/',
              '/opt/app02/server/default/deploy/common/' ]
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
    :delete => false,
    :restart => false,
    :dir => [ '/opt/app03/server/default/deploy/mall/',
              '/opt/app03/server/default/deploy/payment/',
              '/opt/app03/server/default/deploy/common/' ]
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