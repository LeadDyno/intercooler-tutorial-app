class Contact < ActiveRecord::Base

  validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  def activate
    self.status = 'active'
    self.save!
  end

  def deactivate
    self.status = 'deactivate'
    self.save!
  end

end
