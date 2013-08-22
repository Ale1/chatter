require 'socket'
require 'thread'

class Chatclient
  attr_reader :socket, :handle

  def initialize
    #connect:
    @socket = TCPSocket.new 'localhost',9999
    #get username and start:
    
    #start message loop:
  end

  def start
      Thread.start do
        print "choose your username: "
        @handle = $stdin.gets.chomp   
        puts "Welcome to KrAzY-cHaT #{handle}"
        @socket.puts @handle
        loop do     
          @input = $stdin.gets.chomp
          @socket.puts @input
        end
      end
      Thread.start do
        loop do      
          line = @socket.gets
          puts line if line != nil
        end
      end    
  end




end

user = Chatclient.new

user.start
loop do
break if @input == "quit" 
end

