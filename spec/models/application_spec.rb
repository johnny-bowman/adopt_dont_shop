require "rails_helper"

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  describe 'relationships' do
    it { should have_many(:pets) }
  end

  before do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9, address: '185 Fake St, Aurora, CO, 38476')
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5, address: '832 Unreal AVe, Harlingen, TX, 58375')
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10, address: '957 Notreal Ave, Denver, CO, 38475')

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham",
      state: "AL", zip_code: "54738", description: 'empty', status: "Approved")

    @application_2 = Application.create!(name: "John H", street_address: "123 Anywhere Ave", city: "Denver",
      state: "CO", zip_code: "80204", description: 'I would be good at it', status: "Approved")

    #set up the join table ids
#    @application_pets_1 = @pet_1.applications << @application_1
 #   @application_pets_2 = @pet_2.applications << @application_1
 #   @application_pets_3 = @pet_3.applications << @application_2

  end

  describe 'instance methods' do
    it '#all_pets_approved :returns true if all status are Approved' do

      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9, address: '185 Fake St, Aurora, CO, 38476')
      pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham",
        state: "AL", zip_code: "54738", description: 'empty', status: "Approved")

      application_pets_1 = pet_1.applications << application_1
      application_pets_2 = pet_2.applications << application_1
      join_update_1 = ApplicationPet.app_pet(application_1.id, pet_1.id)
      join_update_1.status = "1"
      join_update_1.save
      join_update_2 = ApplicationPet.app_pet(application_1.id, pet_2.id)
      join_update_2.status = "1"
      join_update_2.save
      expect(@application_1.all_pets_approved).to eq(true)
    end

    it '#rejected_or_approved :returns true if all pet applications have a status of Rejected or Approved' do
      @application_pets_1 = @pet_1.applications << @application_1
      @application_pets_2 = @pet_2.applications << @application_1
      @application_pets_3 = @pet_3.applications << @application_2
      expect(@application_2.rejected_or_approved).to eq(false)

      join_update_1 = ApplicationPet.app_pet(@application_1.id, @pet_1.id)
      join_update_1.status = "1"
      join_update_1.save
      join_update_2 = ApplicationPet.app_pet(@application_1.id, @pet_2.id)
      join_update_2.status = "1"
      join_update_2.save
      join_update_3 = ApplicationPet.app_pet(@application_2.id, @pet_3.id)
      join_update_3.status = "1"
      join_update_3.save
      expect(@application_1.all_pets_approved).to be true
    end

    it '#adopt_pet change pet column adoptable to false' do
    @application_pets_1 = @pet_1.applications << @application_1

      expect(@pet_1.adoptable).to be true
      expected = @application_1.adopt_pet
      expect(expected[0].adoptable).to be false
    end
  end

  describe 'class methods' do
  end
end
