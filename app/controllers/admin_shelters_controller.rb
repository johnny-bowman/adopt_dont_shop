class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alphabetical_order
    @shelters_with_pending_apps = Shelter.with_pending_applications
  end

  def show
    @shelter = Shelter.find_with_id(params[:id])
    binding.pry
  end
end
