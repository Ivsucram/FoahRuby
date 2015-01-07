class PostsController < ApplicationController
	before_filter :get_user, :only => [:create_post]

	def get_public_posts
		f = File.join("#{Rails.root}/public/posts.json")
	    if File.exists?f
	      data = File.read(f)
	      posts = JSON.parse(data) rescue {}
	    end
	    render :json => {"posts" => posts}.to_json
	end

	def create_post
		message = params[:message]
		location = params[:location]
  		if !@user.nil?
  			if message.nil?
	  			response = Error::NULL_POST_MESSAGE
				response["success"] = false 
  			elsif location.nil?
	  			response = Error::NULL_LOCATION
				response["success"] = false 
  			else
	  			loc = Location.new
	  			loc.latitude = location[:latitude]
	  			loc.longitude = location[:latitude]
	  			loc.radius = location[:radius]
	  			loc.save
	  			post = Post.new
	  			post.message = message
	  			post.user = @user
	  			post.location = loc
	  			loc.save
	  			post.save
	  			response = {"success" => true}
	  		end
  		end
  		render :json => response.to_json
	end

end