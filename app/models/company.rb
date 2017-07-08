class Company < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :credits
end
