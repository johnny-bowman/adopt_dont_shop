class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alphabetical_order
  end
end
