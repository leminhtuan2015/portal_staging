class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def index
  	CustomersController::layout 'accounts'
  end

end
