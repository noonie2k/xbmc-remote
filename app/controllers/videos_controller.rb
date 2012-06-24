
class VideosController < ApplicationController
  def movies
    @all_movies = []
    Xbmc::VideoLibrary::get_movies().each do |movie|
      @all_movies << Xbmc::VideoLibrary::get_movie_details({
        movieid: movie['movieid'].to_i,
        properties: ['thumbnail', 'title']
      })
    end
  end

  def tvshows
  end

  def details
    @movie_details = Xbmc::VideoLibrary::get_movie_details({
      movieid: params[:id].to_i,
      properties: ['thumbnail', 'title', 'year', 'runtime', 'plot', 'genre', 'director']
    })

    respond_to do |format|
      format.js
    end
  end

  def operation
    case params[:operation]
      when 'open'      then @result = Xbmc::Player::open({ item: { movieid: params[:id].to_i } })
      when 'playpause' then @result = Xbmc::Player::play_pause({ playerid: active_player['playerid'].to_i })
      when 'stop'      then @result = Xbmc::Player::stop({ playerid: active_player['playerid'].to_i })
    end
    p @result

    respond_to do |format|
      format.js
    end
  end
end
