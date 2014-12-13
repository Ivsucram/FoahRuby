
class PostsController < ApplicationController
	def get_public_posts
		f = File.join("#{Rails.root}/public/posts.json")
	    if File.exists?f
	      data = File.read(f)
	      posts = JSON.parse(data) rescue {}
	    end
	    render :json => {"posts" => posts}.to_json
	end
end