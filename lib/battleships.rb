require 'sinatra/base'
require 'battleships'

class BattleshipsApp < Sinatra::Base
set :views, Proc.new { File.join(root, "..", "views") }

  get '/' do
    erb :index
  end

  get '/new_game' do
    erb :new_game
  end

  post '/start_game' do
    @name = params[:name]
    @game = Game.new Player, Board
    @board = @game.own_board_view @game.player_1
    erb :start_game
  end

  get '/place_ship' do
    erb :place_ship
    # form for 5 ships
    #   >>Ship 1 Battleship text = '' name = 'coordinate1'
  end

  post '/place_ship' do
    @game = Game.new Player, Board
    @battleship = params[:coordinate1]
    @game.player_1.place_ship Ship.battleship, @battleship, :vertically
    @board = @game.own_board_view @game.player_1
    erb :ship_placed
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end