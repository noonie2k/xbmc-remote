require 'etc'

module ApplicationHelper
  def cover_image(thumbnail)
    image_tag(raw(image_proxy_path({ filename: thumbnail.gsub('special://masterprofile', Etc.getpwuid.dir + '/.xbmc/userdata') })))
  end
end
