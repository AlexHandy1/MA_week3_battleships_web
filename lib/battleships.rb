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
    @name = params[:name]
    erb :start_game
  end

  get '/ship/new' do
    erb :place_ship
  end

  post '/ship' do
    #while @@game.player_1.board.ships < 5 do this...
    @battleship = params[:coordinate1]
    @@game.player_1.place_ship Ship.battleship, @battleship, :vertically
    @board = @@game.own_board_view @@game.player_1
    erb :ship_placed
    #else do this...
  end

  get '/shots/new' do
    erb :take_shots
  end

  post '/shots' do
    #while @@game.has_winner? == false
    @shot = params[:shot]
    @@game.player_1.shoot @shot.to_sym
    @opponent_board = @@game.opponent_board_view @@game.player_1
    erb :view_shots
    # else include route to winning page
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end