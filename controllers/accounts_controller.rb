class AccountController < ApplicationController

  get '/' do
    erb :account_create
  end

  post '/create' do
    user = Account[username: params[:username]]
    if !user
      password = BCrypt::Password.create(params[:password])
      @account = Account.create username: params[:username], email: params[:email],  password: password
      session[:logged_in] = true
      session[:username] = params[:username]
      session[:email] = params[:email]
      session[:password] = password
      session[:user_id] = @account.id
      redirect '/weather'
    else
      $message = "This username exists.  Please input a different username."
      redirect '/accounts'
    end
  end

  get '/create' do
    redirect '/' if !session[:logged_in]
    accounts = Account.all
    sessionName = "Hello #{session[:username]}! #{session[:email]} #{session[:password]} Welcome back!"
  end

  post '/login' do
    account = Account.where(email: params[:username]).first
    compare_to = BCrypt::Password.new(account.password)
    if compare_to == params[:password]
      session[:logged_in] = true
      session[:email] = params[:username]
      session[:user_id] = account.id
      redirect '/weather'
    else
      $message = "Incorrect username or password, please try again."
      redirect '/accounts'
    end
  end

  get '/login' do
    session[:logged_in] = false
  end

  get '/logout' do
    session[:logged_in] = false
    redirect '/accounts'
  end
end
