require 'sinatra/base'
require 'sinatra/assetpack'
require 'sinatra/activerecord'
require 'sinatra/cache'

configure :development do
  set :database, "sqlite3:db/ap.db"
  set :show_exceptions, true
end

configure :production do
  db = URI.parse('postgres://localhost/ap')

  ActiveRecord::Base.establish_connection(
    adapter: db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  )
end

class App < Sinatra::Base
  register Sinatra::AssetPack
  register Sinatra::Cache

  set :root, File.dirname(__FILE__)
  set :cache_enabled, true
  set :cache_environment, :development
  set :cache_output_dir, Proc.new { File.join(root, 'public', 'cache') }

  assets do
    serve '/images', from: 'app/images'
    serve '/plugins', from: 'app/plugins'
    serve '/fonts', from: 'app/fonts'

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
    erb :layout, cache: true
  end
end

