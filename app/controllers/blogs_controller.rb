class BlogsController < ApplicationController
  # ブログ画面にログインするためにauthenticate_user!を追加する。
  before_action :authenticate_user!
  before_action :set_blog, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.all.order(id: :desc)
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
      set_user
    else
      @blog = Blog.new
      set_user
    end
  end
  
  def create
    @blog = Blog.new(blogs_params)
    set_user

    if @blog.save
      redirect_to blogs_path, notice: "ブログを作成しました！"
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    set_user
    
    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを更新しました！"
    else
      render action: 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end
  
  def confirm
    set_user
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

  private
    def blogs_params
      params.require(:blog).permit(:title, :content)
    end
    
    # idをキーとして値を取得するメソッド
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # user_idを代入する
    def set_user
      @blog.user_id = current_user.id
    end
end