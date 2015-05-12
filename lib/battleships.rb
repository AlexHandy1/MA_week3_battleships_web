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



  # start the server if ruby file executed directly
  run! if app_file == $0
end