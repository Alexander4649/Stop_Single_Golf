class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
       redirect_to contact_path(@contact)
    else
       redirect_to request.referer
    end
  end
  
  def show
    @contact = Contact.find(params[:id])
  end
  
  private
  
  def contact_params
     params.require(:contact).permit(:name, :email)
  end
end
