require 'rails_helper'

RSpec.describe "admin shelters index" do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9, address: '185 Fake St, Aurora, CO, 38476')
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5, address: '832 Unreal AVe, Harlingen, TX, 58375')
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10, address: '957 Notreal Ave, Denver, CO, 38475')

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham", state: "AL", zip_code: "54738", description: 'empty', status: "Pending")

    @application_2 = Application.create!(name: "Adam Fakeman", street_address: "837 Unreal Hwy", city: "Portland", state: "CA", zip_code: "29374", description: 'empty', status: "In Progress")

    @pet_1.applications << @application_1
    @pet_2.applications << @application_2

  end

  it "lists shelter addresses" do
    visit "/admin/shelters/#{@shelter_1.id}"
    # save_and_open_page
    expect(page).to have_content('Name: Aurora shelter')
    expect(page).to have_content('Full Address: 185 Fake St, Aurora, CO, 38476')
  end
end
