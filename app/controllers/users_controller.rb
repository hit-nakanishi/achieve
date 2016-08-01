class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @users = User.all.order(id: :asc)
  end
  
  def show
  end

  private
    # idをキーとして値を取得するメソッド
    def set_user
      @user = User.find(params[:id])
    end
end
