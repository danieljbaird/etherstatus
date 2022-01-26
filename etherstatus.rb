#!/opt/csw/bin/ruby
#  etherstatus.rb  
#
#  V.1.0.?     Author: Daniel Baird 2007
#
#  A ruby script for Solaris to show the link status 
#  of Ethernet interfaces. 
# 
#  Currently supported interface types;
#       qfe, hme, eri, dmfe, bge, ce, e1000g
#
unless File.exist?("/etc/path_to_inst")
    puts "ERROR: cant open /etc/path_to_inst , aborting. You have worse problems than this script not working!"
    exit
end

while choice != 1
  choice = gets.chomp
  puts "wrong" 
end

File.open("/etc/path_to_inst") do |devicesfile|
  while line = devicesfile.gets
    if line =~ /e1000g|hme|eri|qfe|bge|ce|dmfe/
        puts line
        # split the line into separate string vars. space is the delimmiter
        if_device, if_instance, if_name = line.chomp.split(/\s+/) 
        # ndd shell command. insert variables and strip off inverted commas
        link_status = `/usr/sbin/ndd -get /dev/#{if_name.gsub(/\"/,"")}#{if_instance} link_status`
    end
  end
end
 