class ContactsController < ApplicationController

  def index
    @contacts = Contact.paginate(:page => params[:page])
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.create(person_params)
    if @contact.save
      flash[:notice] = 'Created Contact'
      redirect_to @contact
    else
      flash[:error] = 'Could not create Contact'
      render action: :new
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(person_params)
      flash[:notice] = 'Updated Contact'
      redirect_to @contact
    else
      flash[:error] = 'Could not update contact!'
      render action: :edit
    end
  end

  private

  def person_params
    params.require(:contact).permit(:first_name, :last_name, :email, :status)
  end

end
