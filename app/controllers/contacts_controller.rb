class ContactsController < ApplicationController

  def index
    @contacts = Contact.paginate(:page => params[:page])
    render :layout => params['ic-request'].blank?
  end

  def contact_rows
    @contacts = Contact.paginate(:page => params[:page])
    render :partial => 'contact_rows'
  end

  def contacts_table
    if request.post?
      if params['ic-element-id'] == 'activate-btn'
        Contact.find(params['ids']).each &:activate
      else
        Contact.find(params['ids']).each &:deactivate
      end
      render :nothing => true
    else
      @contacts = Contact.paginate(:page => params[:page])
      render :partial => 'contacts_table'
    end
  end

  def email
    if params[:id]
      @contact = Contact.find(params[:id])
    else
      @contact = Contact.new
    end
    @contact.assign_attributes(person_params)
    @contact.valid?
    render :partial => 'email'
  end

  def show
    @contact = Contact.find(params[:id])
    render :layout => params['ic-request'].blank?
  end

  def edit
    @contact = Contact.find(params[:id])
    headers['X-IC-SetLocation'] = edit_contact_path @contact
    render :layout => params['ic-request'].blank?
  end

  def new
    @contact = Contact.new
    headers['X-IC-SetLocation'] = new_contact_path
    render :layout => params['ic-request'].blank?
  end

  def create
    @contact = Contact.create(person_params)
    if @contact.save
      flash[:notice] = 'Created Contact'
      headers['X-IC-SetLocation'] = contact_path @contact
      render action: :show, :layout => params['ic-request'].blank?
    else
      flash[:error] = 'Could not create Contact'
      render action: :new, :layout => params['ic-request'].blank?
    end
  end

  def flash_content
    render :partial => 'layouts/flash_content'
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(person_params)
      flash[:notice] = 'Updated Contact'
      headers['X-IC-SetLocation'] = contact_path @contact
      render action: :show, :layout => params['ic-request'].blank?
    else
      flash[:error] = 'Could not update contact!'
      render action: :edit, :layout => params['ic-request'].blank?
    end
  end

  private

  def person_params
    params.require(:contact).permit(:first_name, :last_name, :email, :status)
  end

end
