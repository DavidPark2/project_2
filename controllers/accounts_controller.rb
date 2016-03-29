class AccountController < ApplicationController

  get '/' do
    erb :account_create
  end

  post '/create' do
    password = BCrypt::Password.create(params[:password])

    Account.create username: params[:username], email: params[:email],  password: password

    session[:logged_in] = true
    session[:username] = params[:username]

    redirect '/accounts/create'
  end

  get '/create' do
    redirect '/' if !session[:logged_in]

    accounts = Account.all

    "Hello #{session[:username]}! #{session[:password]} Welcome back!"
  end

  post '/login' do
    account = Account[username: params[:username]]

    compare_to = BCrypt::Password.new(account.password)
    if compare_to == params[:password]
      session[:logged_in] = true
      session[:username] = params[:username]
      # redirect '/weather'
      "Welcome back #{params[:username]}!"
    else
      redirect '/'
      wrong = "You entered the wrong username or password"
    end
  end

  get '/login' do
    session[:logged_in] = false
  end
end
