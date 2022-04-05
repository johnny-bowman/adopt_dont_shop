class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: { "In Progress" => "0", "Pending" => "1", "Approved" => "2", "Rejected" => "3" }

  def all_pets_approved
     self.application_pets.all? do |app_pets|
       binding.pry
       app_pets.status == "2"
     end
  end
end
