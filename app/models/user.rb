class User < ActiveRecord::Base
  
  has_many :urls
  validates :email, uniqueness: true
  # validates :email, format: {with: (/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/)}
  validates :email, :format => { :with => /[a-z]*@[a-z]*.[a-z]{2,}/, :message => "error"}
  
  def check_password(password)
    if self.password == password
      true
    else
      false
    end
  end

end