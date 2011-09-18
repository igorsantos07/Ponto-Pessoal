class PontoPessoal < Padrino::Application
  register SassInitializer
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::Admin::AccessControl

  set :haml, :format => :html5
  set :full_date, '%d/%m/%Y %H:%M:%S'
  set :full_date_no_seconds, '%d/%m/%Y %H:%M'
  set :iso_date, '%Y-%m-%d'
  set :simple_time, '%H:%M'

	set :login_page, '/login'

  enable :sessions
	disable :store_location

  access_control.roles_for :any do |role|
    role.protect '/'
		role.allow ["/login", '/sobre', '/cadastrar', '/esqueci-minha-senha']
  end

  access_control.roles_for :user, :admin do |role|
    role.project_module :workday, "/hoje"
  end

  get 'stylesheets/:file.css' do
    content_type 'text/css', :charset => 'utf-8'
    sass params[:file]
  end

  before '/cadastrar', '/esqueci-minha-senha', '/login' do
    redirect '/' unless current_account.nil?
  end

  configure :development, :test do
    set :jquery_root, '/javascripts/jquery/'
  end

  configure :production do
    set :jquery_root, 'http://code.jquery.com/'
  end

  ##
  # Caching support
  #
  # register Padrino::Cache
  # enable :caching
  #
  # You can customize caching store engines:
  #
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
  #   set :cache, Padrino::Cache::Store::Memory.new(50)
  #   set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
  #

  ##
  # Application configuration options
  #
  # set :raise_errors, true     # Raise exceptions (will stop application) (default for test)
  # set :dump_errors, true      # Exception backtraces are written to STDERR (default for production/development)
  # set :show_exceptions, true  # Shows a stack trace in browser (default for development)
  # set :logging, true          # Logging in STDOUT for development and file for production (default only for development)
  # set :public, "foo/bar"      # Location for static assets (default root/public)
  # set :reload, false          # Reload application files (default in development)
  # set :default_builder, "foo" # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"     # Set path for I18n translations (default your_app/locales)
  # disable :sessions           # Disabled sessions by default (enable if needed)
  # disable :flash              # Disables rack-flash (enabled by default if Rack::Flash is defined)
  # layout  :my_layout          # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #

  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #     disable :asset_stamp # no asset timestamping for dev
  #   end
  #

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #
  #   error 505 do
  #     render 'errors/505'
  #   end
  #
end