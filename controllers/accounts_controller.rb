class AccountController < ApplicationController

  get '/' do
    erb :account_create
  end

  # Create a account
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

  # login
  post '/login' do
    account = Account.where(email: params[:username]).first
    user = Account[email: params[:username]]
    if !user
      $message = "You have entered an incorrect username or password.  Please try again."
      redirect '/accounts'
    elsif BCrypt::Password.new(account.password) == params[:password]
      session[:logged_in] = true
      session[:email] = params[:username]
      session[:user_id] = account.id
      redirect '/weather'
    else
      $message = "You have entered an incorrect username or password.  Please try again."
      redirect '/accounts'
    end
  end

  # logout
  get '/logout' do
    session[:logged_in] = false
    redirect '/accounts'
  end
end
