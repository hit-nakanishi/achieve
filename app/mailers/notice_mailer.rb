class NoticeMailer < ApplicationMailer

  # ブログ投稿
  def sendmail_blog(blog)
    @blog = blog

    mail to: "naka24naka24@gmail.com",
         subject: '【Achieve】ブログが投稿されました'
  end

  # お問い合わせ投稿（お客様）
  def sendmail_contact(contact)
    @contact = contact

    mail to: @contact.email,
         subject: '【Achieve】お問い合わせありがとうございます'
  end

  # お問い合わせ投稿（admin）
  def sendmail_contact_admin(contact2)
    @contact = contact2
    
    mail to: "naka24naka24@gmail.com",
    subject: '【Achieve】お問い合わせが届きました'
  end
end
