PontoPessoal.controllers :account do

  get :new, :map => '/cadastrar' do
    render 'account/new'
  end

  post :new, :map => '/cadastrar' do
    unless params[:account]['name'].empty?
      parts = params[:account]['name'].partition ' '
      params[:account]['name'] = parts[0]
      params[:account]['surname'] = parts[2]
    end

    @account = Account.new params[:account]
    @account.role = :user
    if @account.save
      flash[:notice] = 'Conta criada!'
      set_current_account(@account)
      redirect '/'
    else
      flash[:warning] = 'Ocorreu um problema ao efetuar seu cadastro.'
      render 'account/new'
    end
  end

  get :forgot_password, :map => '/esqueci-minha-senha' do
    render 'account/forgot_password'
  end

end