module AccessTimesTrackable
  extend ActiveSupport::Concern

  private

  def increase_counter
    session[:counter] = 0 if session[:counter].nil?
    @counter = session[:counter] += 1
  end

  def clear_counter
    @counter = session[:counter] = 0
  end
end
