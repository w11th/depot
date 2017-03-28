class StoresController < ApplicationController
  include AccessTimesTrackable
  include Cartable

  before_action :increase_counter, only: [:index]
  before_action :set_cart

  def index
    @products = Product.order(:title)
  end
end
