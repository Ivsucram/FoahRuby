class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def get_user
  	mobile_number = params[:number].sub("+","")
	@user = User.find_by_number(mobile_number) rescue nil
  end
end
