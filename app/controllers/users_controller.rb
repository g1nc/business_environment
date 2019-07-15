# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    render json: UsersListPresenter.new(User.all).present
  end

  def show
    @user = User.eager_load(:operations).find(params[:id])
    render json: UserOperationsPresenter.new(@user).present
  end

  def update
    User.find(params[:id]).update_balance(params[:amount].to_f)
    render json: { success: true }
  end
end
