XbmcController::Application.routes.draw do
  root to: 'videos#movies'
  
  controller :application do
    get 'imageproxy' => :image_proxy, as: 'image_proxy'
    get 'nowplaying' => :nowplaying
  end

  controller :videos do
    get 'movies'  => :movies
    get 'tvshows' => :tvshows
    
    get 'video/details/:type/:id'    => :details,   as: 'video_details'
    get 'video/:operation/:type/:id' => :operation, as: 'video_operation'
  end
end
