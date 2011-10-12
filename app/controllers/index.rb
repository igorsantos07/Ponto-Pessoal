PontoPessoal.controller :index do

	get :about, :map => '/sobre' do
    @show_title = true
		render '/index/about'
	end

	get :login do
		render '/index/login'
	end

	post :create_session, :map => '/login' do
    if account = Account.authenticate(params[:login], params[:password])
      set_current_account(account)
      redirect '/'
    else
      flash[:warning] = "Login ou senha incorretos"
      redirect url(:index, :login)
    end
	end

	get :logout do
    set_current_account(nil)
    redirect url(:index, :login)
	end
end