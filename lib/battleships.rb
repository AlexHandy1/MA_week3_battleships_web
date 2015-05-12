require 'sinatra/base'
require 'battleships'

class BattleshipsApp < Sinatra::Base
set :views, Proc.new { File.join(root, "..", "views") }

  @@game = Game.new Player, Board
  @board = @@game.own_board_view @@game.player_1

  get '/' do
    erb :index
  end

  get '/game/new' do
    erb :new_game
  end

  post '/game' do
    p @@game
    @name = params[:name]
    @board = @@game.own_board_view @@game.player_1
    erb :start_game
  end

  get '/ship/new' do
    erb :place_ship
  end

  post '/ship' do
    p @@game
    @battleship = params[:coordinate1]
    @@game.player_1.place_ship Ship.battleship, @battleship, :vertically
    @board = @@game.own_board_view @@game.player_1
    erb :ship_placed
  end

  get '/board' do

  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end