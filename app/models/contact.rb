class Contact < ApplicationRecord
  
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, presence: true, length: { minimum: 3, maximum: 50 }
  
end
