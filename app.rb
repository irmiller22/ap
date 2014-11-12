require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/activerecord'

set :database, "sqlite3:db/ap.db"

class App < Sinatra::Base
  register Sinatra::AssetPack
  assets do
    serve '/images', from: 'app/images'
    serve '/plugins', from: 'app/plugins'

    js :application, [
      '/js/jquery-1.10.2.min.js',
      '/js/bootstrap/bootstrap.min.js',
      '/js/plugins/*.js',
      '/js/application/application.min.js'
    ]

    css :application, [
      '/css/bootstrap.css'
    ]
  end

  get "/" do
    @ian = Owner.find_by(name: "Ian Miller")
    erb :layout
  end
end

