class NoticeMailer < ApplicationMailer

  def sendmail_blog(blog)
    
    @blog = blog

    mail to: "naka24naka24@gmail.com",
         subject: '【Achieve】ブログが投稿されました'
  end
end
