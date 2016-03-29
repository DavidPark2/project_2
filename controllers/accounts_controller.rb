class AccountController < ApplicationController

  get '/' do
    erb :account_create
  end

  # post '/' do

  # end


  post '/login' do
    password = BCrypt::Password.create(params[:password])

    Account.create username: params[:username], email: params[:email],  password: password

    session[:logged_in] = true
    session[:username] = params[:username]

    redirect '/accounts'
  end

  get '/login' do
    redirect '/' if !session[:logged_in]

    accounts = Account.all

    "Hello #{session[:username]}! Welcome back!"

    erb :accounts
  end

  post '/create' do
    user = User[username: params[:username]]

    compare_to = Bcrypt::Password.new(user.password)
    if compare_to == params[:password]
      session[:logged_in] = true
      session[:username] = parmas[:username]
      "Welcome back #{params[:username]}!"
    else
      "You entered the wrong username or password"
    end
  end
end
