require 'sinatra/base'
require 'battleships'

class BattleshipsApp < Sinatra::Base
set :views, Proc.new { File.join(root, "..", "views") }
enable :sessions

  @@game = Game.new Player, Board
  @board = @@game.own_board_view @@game.player_1

  get '/' do
    @name = session["name"]
    @name2 = session["name2"]
    erb :index
  end
  #ideas for 2 player version
    #redirect until have 2 players at each stage
    #use at name parameter to toggle between?

  get '/game/new' do
    @error = params[:error]

    if @error.nil?
      @message = "Fill out your name, real quick!"
    else
      @message = "Please fill in your name"
    end
      hurrah = "Get on my page with a local"
      erb :new_game, :locals => {:hurrah => hurrah}
  end

  post '/game' do
    @name = params[:name]
    session["name"] = @name

    if @name.empty?
      redirect to '/game/new?error=name'
    else
      erb :start_game
    end
  end

  get '/ship/new' do
    @board = @@game.own_board_view @@game.player_1
    erb :place_ship
  end

  post '/ship' do
    #while @@game.player_1.board.ships < 5 do this...
    #error handling
    #different size ships
    @name = session["name"]
    @battleship = params[:coordinate1]
    @@game.player_1.place_ship Ship.battleship, @battleship, :vertically
    @board = @@game.own_board_view @@game.player_1
    erb :ship_placed
    #else do this...
  end

  get '/shots/new' do
    @board = @@game.own_board_view @@game.player_1
    erb :take_shots
  end

  post '/shots' do
    #error handling + ensure loops as soon as win (shift to true?)
    if @@game.has_winner? == false
      @shot = params[:shot]
      @name = session["name"]
      @hey = "This is your name #{@name} right?"
      @@game.player_2.shoot @shot.to_sym
      @board = @@game.own_board_view @@game.player_1
      erb :view_shots
    else
      @name = session["name"]
      erb :you_win
    end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end