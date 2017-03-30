class StoresController < ApplicationController
  include AccessTimesTrackable
  include Cartable

  skip_before_action :authorize

  before_action :increase_counter, only: [:index]
  before_action :set_cart

  def index
    if params[:set_locale]
      redirect_to stores_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
end
