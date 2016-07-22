class ContactsController < ApplicationController

  def index
    redirect_to new_contact_path
  end
  
  def new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end
  
  def create
    @contact = Contact.new(contacts_params)
    if @contact.save
      redirect_to root_path, notice: "お問い合わせが完了しました！"
      NoticeMailer.sendmail_contact(@contact).deliver
      NoticeMailer.sendmail_contact_admin(@contact).deliver
    else
      render action: 'new'
    end
  end

  def confirm
    @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  
  end

  private
    def contacts_params
      params.require(:contact).permit(:name, :email, :content)
    end

end
