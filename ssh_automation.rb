require 'net/ssh'
require 'net/scp'
require File.expand_path('../test_excel.rb', __FILE__)
require File.expand_path('../config.rb', __FILE__)
Dir::chdir($deploy_dir)
str = nil
$instance.each do |instance|
  while str != 'y' && str != 'n' do
    puts 'do you want to delete ' + instance[:destination] + ' ?' + '(y or n)'
    str = gets.chomp
    if str == 'y'
      Net::SSH.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |ssh|
        puts "rm -f #{instance[:destination]}common/*"
        ssh.exec! "rm -f #{instance[:destination]}common/*"
        puts "rm -f #{instance[:destination]}mall/*"
        ssh.exec! "rm -f #{instance[:destination]}mall/*"
        puts "rm -f #{instance[:destination]}payment/*"
        ssh.exec! "rm -f #{instance[:destination]}payment/*"
        puts instance[:destination] + ' deleted '
      end
    elsif str == 'n'
      puts 'deploy package will be cover'
    else
      puts 'You should type (y or n)'
    end    
  end
  instance[:common].each do |common|

    puts 'deploy common package'
    if File::exists?(common)
      puts common +' exists'
      Net::SCP.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |scp|
        scp.upload! common, instance[:destination] + 'common'
        puts common + ' to ' + instance[:destination] + 'common' + ' upload successfully'
      end
    else
      puts common + ' not exists'
    end
  end
  instance[:mall].each do |mall|
    puts 'deploy mall package'
    if File::exists?(mall)
      puts mall +' exists'
      Net::SCP.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |scp|
        scp.upload! mall, instance[:destination] + 'mall'
        puts mall + ' to ' + instance[:destination] + 'mall' + ' upload successfully'
      end
    else
      puts mall + ' not exists'
    end
  end
  instance[:payment].each do |payment|
    puts 'deploy payment package'
    if File::exists?(payment)
      puts payment +' exists'
      Net::SCP.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |scp|
        scp.upload! payment, instance[:destination] + 'payment'
        puts payment + ' to ' + instance[:destination] + 'payment' + ' upload successfully'
      end
    else
      puts payment + ' not exists'
    end
  end
  while str != 'y' && str != 'n' do
    puts 'do you want to restart ' + instance[:destination] + instance[:username] + ' ?' + '(y or n)'
    str = gets.chomp
    if str == 'y'
      Net::SSH.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |ssh|
        puts instance[:ip] + instance[:username] + 'will restart at once'
        ssh.exec! "hp restart"
      end
    elsif str == 'n'
      puts instance[:ip] + instance[:username] + 'will not restart'
    else
      puts 'You should type (y or n)'
    end
  end

end
