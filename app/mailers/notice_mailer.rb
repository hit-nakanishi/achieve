class NoticeMailer < ApplicationMailer

  # ブログ投稿
  def sendmail_blog(blog)
    
    @blog = blog

    mail to: "naka24naka24@gmail.com",
         subject: '【Achieve】ブログが投稿されました'
  end

  # お問い合わせ投稿
  def sendmail_contact(contact)

    @contact = contact

    mail to: "naka24naka24@gmail.com",
         subject: '【Achieve】お問い合わせが届きました'
  end
end
