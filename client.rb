require 'socket'
require 'thread'


class Chatclient
  attr_reader :socket, :handle

  def initialize
    print "choose your username: "
    @handle = $stdin.gets.chomp   
    @socket = TCPSocket.new 'localhost',9999
    puts "Welcome to KrAzY-cHaT #{handle}"
  end

  def run
    while line = @socket.gets
       input = $stdin.gets.chomp
      break if input == "quit"
      puts input
      print "#{handle} >> #{line}"
     
   end
   socket.close
  end

end

user = Chatclient.new
user.run
