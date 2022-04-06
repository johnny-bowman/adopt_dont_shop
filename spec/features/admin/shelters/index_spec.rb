require 'rails_helper'

RSpec.describe "admin shelters index" do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  end

  it "lists all shelters in reverse alphabetical order" do
    visit "/admin/shelters"
    # save_and_open_page

    expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
    expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
  end
end
