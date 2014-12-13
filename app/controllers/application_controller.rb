class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  # protect_from_forgery with: :exception


  def get_user
  	mobile_number = params[:number]
  	if mobile_number.nil?
  		response = Error::NULL_MOBILE_NUMBER
  		response["success"] = false
  		render :json => response.to_json and return
  	end
  	mobile_number = mobile_number.sub("+","")
	@user = User.find_by_number(mobile_number) rescue nil
  end
end
