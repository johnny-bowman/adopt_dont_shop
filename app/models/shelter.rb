class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true
  # validates :address, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.rev_alphabetical_order
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC;")
  end

  def self.find_with_id(given_id)
    find_by_sql("SELECT * FROM shelters WHERE shelters.id = #{given_id};").first
  end

  def self.with_pending_applications
    joins(pets: :applications).where("applications.status = '1'").order(:name).distinct
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end
end
