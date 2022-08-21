class ContactsController < ApplicationController
  require 'securerandom' #ランダムURLを使用する為のメソッド(乱数)
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    # URL直打ちでcontact/showページを見せない様にURLに乱数を使用する
    @contact.token = SecureRandom.urlsafe_base64 #tokenに乱数を代入
    if @contact.save
       redirect_to contact_show_path(@contact.token)
    else
       redirect_to request.referer
    end
  end
  
  def show
    @contact = Contact.find_by(token: params[:token])
  end
  
  # 管理者のみ閲覧可(直打ち禁止)
  def index
    if current_user.name == "管理者"
       @contacts = Contact.all
    else
      redirect_to user_path(current_user)
    end
    @contacts = @contacts.page(params[:page]).per(7)
  end
  
  # 管理者のみ削除可
  def destroy
    if current_user.name == "管理者"
      @contact = Contact.find(params[:id])
      @contact.destroy
      redirect_to contacts_path
    else
       redirect_to request.referer
    end
  end
  
  private
  
  def contact_params
     params.require(:contact).permit(:name, :email)
  end
end
