class ApplicationController < ActionController::Base
  protect_from_forgery

  def image_proxy
    response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
    response.headers['Content-Type'] = 'image/jpeg'
    response.headers['Content-Disposition'] = 'inline'
    render :text => open(params[:filename]).read
  end

  def nowplaying
    player = active_player
    return unless player

    movieid = Xbmc::Player::get_item({ playerid: player['playerid'] })['id'].to_i
    @item_playing = Xbmc::VideoLibrary::get_movie_details({
      movieid: movieid,
      properties: ['thumbnail', 'title']
    })

    @playpause = 'play'
    @playpause = 'pause' if is_nowplaying_paused?

    respond_to do |format|
      format.js
    end
  end

  protected
    def active_player
      Xbmc::Player::get_active_players().first rescue nil
    end

    def is_nowplaying_paused?
      player = active_player
      return false unless player

      speed = Xbmc::Player::get_properties({ 
        playerid: player['playerid'].to_i,
        properties: ['speed'],
      })['speed']

      p 'speed' + speed.to_s

      return speed.to_i === 0
    end
end
