class AccountController < ApplicationController
  post '/' do
    password = BCrypt::Password.create(params[:passoword])
    User.create username: params[:username], password: Password

    session[:logged_in] = true
    session[:username] = params[:username]
  end

  get '/' do
    # redirect '/' if !session[:logged_in]
    #
    # users = User.all
    #
    # "Hello #{session[:username]}! Welcome back!"

    erb :account_create
  end

end
