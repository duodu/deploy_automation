require 'net/ssh'
require 'net/scp'
require File.expand_path('../test_excel.rb', __FILE__)
Dir::chdir('E:/lib/')

$instance.each do |instance|
  puts 'do you want to delete ' + instance[:destination] + ' ?' + '(y or n)'
  str = gets.chomp
  if str == 'y'
    Net::SSH.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |ssh|
      ssh.exec! "rm -f #{instance[:destination]}*"
    end
  elsif str == 'n'
    puts 'deploy package will be cover'
  end
  instance[:common].each do |common|

    puts 'deploy common package'
    if File::exists?(common)
      puts common +' exists'
      Net::SCP.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |scp|
        scp.upload! common, instance[:destination] + 'common'
        puts common + ' upload successfully'
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
        puts mall + ' upload successfully'
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
        puts payment + ' upload successfully'
      end
    else
      puts payment + ' not exists'
    end
  end
  puts 'do you want to restart ' + instance[:destination] + instance[:username] + ' ?' + '(y or n)'
  str = gets.chomp
  if str == 'y'
    Net::SSH.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |ssh|
      puts instance[:ip] + instance[:username] + 'will restart at once'
      ssh.exec! "hp restart"
    end
  else
    puts instance[:ip] + instance[:username] + 'will not restart'
  end
end
