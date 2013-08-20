require 'socket'
require 'thread'


class Chatclient
  attr_reader :socket, :handle

  def initialize
    #connect:
    @socket = TCPSocket.new 'localhost',9999
    #get username and start:
    print "choose your username: "
    @handle = $stdin.gets.chomp   
    puts "Welcome to KrAzY-cHaT #{handle}"
    #start message loop:
  end

  def start
    Thread.start do  
          while line = @socket.gets
            puts "#{handle} >> #{line}" if line != nil
          end
        end

    Thread.start do 
      loop do 
        input = $stdin.gets.chomp
        p input
        @socket.puts input
        break if input == "quit"
      end
   end
 end



end

user = Chatclient.new

user.start
