class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alphabetical_order
    @shelters_with_pending_apps = Shelter.with_pending_applications
  end

  def show
    @shelter = Shelter.find_with_id(params[:id])
<<<<<<< HEAD
    # binding.pry
=======
>>>>>>> 36c6ba13ac39d8a858565025b2bad320c71da555
  end
end
