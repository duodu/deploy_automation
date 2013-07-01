require 'net/ssh'
require 'net/scp'
require 'timeout'


require File.expand_path('../test_excel.rb', __FILE__)
require File.expand_path('../config.rb', __FILE__)
Dir::chdir($deploy_dir)

$instance.each do |instance|
  #是否需要删除原有包
  if instance[:delete] == true
    Net::SSH.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |ssh|
      puts "rm -f #{instance[:destination]}common/*"
      ssh.exec! "rm -f #{instance[:destination]}common/*"
      puts "rm -f #{instance[:destination]}mall/*"
      ssh.exec! "rm -f #{instance[:destination]}mall/*"
      puts "rm -f #{instance[:destination]}payment/*"
      ssh.exec! "rm -f #{instance[:destination]}payment/*"
      puts instance[:destination] + ' deleted '
    end
  else
    puts 'deploy package will be cover'  
  end
  #上传common包
  instance[:common].each do |common|
    puts 'deploy common package'
    if File::exists?(common)
      puts common +' exists'
      Net::SCP.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |scp|
        #scp.upload! '1.txt', '/opt/app01'
        scp.upload! common, instance[:destination] + 'common' do |ch, name, sent, total|
          print "\r#{name}: #{(sent.to_f * 100 / total.to_f).to_i}%"
        end
        print "\n"
        puts common + ' to ' + instance[:destination] + 'common' + ' upload successfully'
      end
    else
      puts common + ' does not exist'
    end
  end
  #上传mall包
  instance[:mall].each do |mall|
    puts 'deploy mall package'
    if File::exists?(mall)
      puts mall +' exists'
      Net::SCP.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |scp|
        scp.upload! mall, instance[:destination] + 'mall' do |ch, name, sent, total|
          print "\r#{name}: #{(sent.to_f * 100 / total.to_f).to_i}%"
        end
        print "\n"
        puts mall + ' to ' + instance[:destination] + 'mall' + ' upload successfully'
      end
    else
      puts mall + ' does not exist'
    end
  end
  #上传payment包
  instance[:payment].each do |payment|
    puts 'deploy payment package'
    if File::exists?(payment)
      puts payment +' exists'
      Net::SCP.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |scp|
        scp.upload! payment, instance[:destination] + 'payment' do |ch, name, sent, total|
          print "\r#{name}: #{(sent.to_f * 100 / total.to_f).to_i}%"
        end
        print "\n"
        puts payment + ' to ' + instance[:destination] + 'payment' + ' upload successfully'
      end
    else
      puts payment + ' does not exist'
    end
  end
  #是否需要重启JBOSS
  if instance[:restart] == true
    Net::SSH.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |ssh|
      
      begin
      Timeout.timeout(2) {
        ssh.exec! "sh /opt/#{instance[:username]}/bin/hp restart"
      }
      rescue Exception
      end
      puts instance[:ip] + instance[:username] + ' will restart at once'
    end
  else
    puts instance[:ip] + instance[:username] + ' will not restart'
  end
end
