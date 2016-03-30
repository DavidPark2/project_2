class AccountController < ApplicationController

  get '/' do
    erb :account_create
  end

  post '/create' do
    password = BCrypt::Password.create(params[:password])

    Account.create username: params[:username], email: params[:email],  password: password

    session[:logged_in] = true
    session[:username] = params[:username]
    session[:email] = params[:email]
    session[:password] = password

    redirect '/accounts/create'
  end

  get '/create' do
    redirect '/' if !session[:logged_in]

    accounts = Account.all

    sessionName = "Hello #{session[:username]}! #{session[:email]} #{session[:password]} Welcome back!"

  end

  post '/login' do
    account = Account[username: params[:username]]

    compare_to = BCrypt::Password.new(account.password)
    if compare_to == params[:password]
      session[:logged_in] = true
      session[:email] = params[:email]
      session[:email] = account.email
      session[:user_id] = account.id

      # redirect '/weather'
      "Welcome back #{session[:email]}!"
    else
      redirect '/accounts'
    end
  end

  get '/login' do
    session[:logged_in] = false
  end
end
