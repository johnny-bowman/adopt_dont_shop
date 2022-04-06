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
       app_pets.status == "Approved"
     end
  end

  def rejected_or_approved
    self.application_pets.all? { |app_pets| app_pets.status == "Approved" || app_pets.status == "Rejected" }
  end

  def adopt_pet
    self.pets.each do |pet|
      pet.adoptable = false
      pet.save
    end
  end
end
