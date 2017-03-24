class StoresController < ApplicationController
  include AccessTimesTrackable
  before_action :increase_counter, only: [:index]

  def index
    @products = Product.order(:title)
  end
end
