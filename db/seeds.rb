 ApplicationPet.destroy_all
 Shelter.destroy_all
 Pet.destroy_all
 VeterinaryOffice.destroy_all
 Veterinarian.destroy_all
 Application.destroy_all

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9, address: "384 Notreal Hwy, Aurora, CO, 38596")
@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5, address: "384 Unreal Ave, Harlingen, TX, 39486")
@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10, address: '1234 Fake St, Denver, CO, 48675')

@pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
@pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
@pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
@pet_5 = @shelter_1.pets.create(name: 'Duke', breed: 'beagle', age: 1, adoptable: true)

@application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street",
   city: "Birmingham", state: "AL", zip_code: "54738", description: 'empty', status: "0")
 @pet_1.applications << @application_1
 @pet_2.applications << @application_1
@application_2 = Application.create!(name: "John H", street_address: "123 Anywhere",
   city: "Denver", state: "CO", zip_code: "80204", description: 'I want one', status: "Pending")

@application_3 = Application.create!(name: "Johnny B ", street_address: "123 Anywhere",
   city: "Denver", state: "CO", zip_code: "80204", description: 'I want one', status: "Approved")

 @pet_3.applications << @application_2
 @pet_4.applications << @application_2
 @pet_5.applications << @application_2
 @pet_5.applications << @application_3

 @pet_application_1 = ApplicationPet.find_or_create_by!(application_id: @application_2.id, pet_id: @pet_5.id)
