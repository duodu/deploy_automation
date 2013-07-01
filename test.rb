require 'net/ssh'
require 'net/scp'
require 'timeout'
Dir::chdir('E:/lib/')

Net::SCP.start('10.48.192.16', 'app01', :password => 'handpay', :port => 10051) do |scp|
  #puts instance[:ip] + instance[:username] + ' will restart at once'
  scp.upload! 'hpCommon.jar', '/opt/app01/server/default/deploy/common' do |ch, name, sent, total|
    print "\r#{name}: #{(sent.to_f * 100 / total.to_f).to_i}%"
  end
  puts "done"
end