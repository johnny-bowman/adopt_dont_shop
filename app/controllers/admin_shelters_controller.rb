class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alphabetical_order
    @shelters_with_pending_apps = Shelter.with_pending_applications
  end
end
