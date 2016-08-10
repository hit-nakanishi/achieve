class CommentsController < ApplicationController
  before_action :authenticate_user!
  after_action :sending_pusher, only: [:create]
  
  # コメントを保存、投稿するためのアクションです。
  def create
    # ログインユーザーに紐付けてインスタンス生成するためbuildメソッドを使用します。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    
    @notification = @comment.notifications.build(recipient_id: @blog.user_id, sender_id: current_user.id)

    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
#        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
#        format.json { render :show, status: :created, location: @comment }
        format.js { render :index }
      else
#        format.html { render :new }
#        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @blog = @comment.blog
    @comment.destroy
    
    respond_to do |format|
      format.js { render :index }
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end

    def sending_pusher
      if @blog.user_id != current_user.id?
        Notification.sending_pusher(@notification.recipient_id)
      end
    end
end