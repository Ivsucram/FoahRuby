class UserController < ApplicationController

	before_filter :get_user, :only => [:check, :login, :phone_activated, :register_name]

	#this function checks the mobile number. if already registered or not
	def check
		if !@user.nil?
			response = {"success" => true}
		else
			response = Error::USER_NOT_EXISTS
			response["success"] = false
		end
		render :json => response.to_json
	end

	#this function logins the user and also deactivated the old phone and register new phone
	def login 
		mobile_uid = params[:uid] 
		if !@user.nil?
			cellphone = @user.cell_phones.activated.first
			if cellphone.phone_uid != mobile_uid
				deactivate_old_phone(cellphone)
				register_new_phone(mobile_uid)
			end
			response = {"success" => true}
		else
			response = Error::USER_NOT_EXISTS
			response["success"] = false
		end
		render :json => response.to_json
	end

	#this functions check if phone is activated or not
	def phone_activated
		if !@user.nil?
			cellphone = @user.cell_phones.activated.first
			if cellphone.phone_uid == mobile_uid
				response = {"success" => true}
			else
				response = Error::PHONE_NOT_ACTIVATED
				response["success"] = false
			end
		else
			response = Error::USER_NOT_EXISTS
			response["success"] = false 
		end 
		render :json => response.to_json
	end

	# this function registers the user and also register new device
	def register
		mobile = params[:number]
		if !mobile.nil?
			mobile = mobile.sub("+","").strip
			@user = User.new
			@user.mobile_number = mobile
			@user.save
			register_new_phone(params[:uid])
			response = {"success" => true}
		else
			response = Error::NULL_MOBILE_NUMBER
  			response["success"] = false
		end
		
		render :json => response.to_json
	end

	# changes or sets user's  nick name
	def register_name
		name = params[:name]
		if !@user.nil?
			@user.name = name
			@user.save
			response = {"success" => true}
		else
			response = Error::USER_NOT_EXISTS
			response["success"] = false 
		end
		render :json => response.to_json
	end

	private 

	# registers new phone
	def register_new_phone(mobile_uid)
		cp = CellPhone.new
		cp.phone_uid = mobile_uid
		cp.active = true
		cp.user = @user
		cp.save
	end

	# deacativates the old phone
	def deactivate_old_phone(cellphone)
		cellphone.active = false
		cellphone.save
	end

end