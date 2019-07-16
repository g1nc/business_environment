# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    render json: success_response(UsersListPresenter.new(User.all.order(id: :asc)).present)
  end

  def show
    @user = User.eager_load(:operations).find(params[:id])
    render json: success_response(UserOperationsPresenter.new(@user).present)
  end

  def update
    @user = User.find(params[:id])
    @user.update_balance(params[:amount].to_f)
    render json: success_response(balance: @user.balance)
  end
end
