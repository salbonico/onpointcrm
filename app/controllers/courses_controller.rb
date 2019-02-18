class CoursesController < ApplicationController

	get '/courses' do
    	if session["user_id"] != nil
    		@user = User.find(session["user_id"])
    		erb :'/courses/courses'
    	else
    		redirect '/login'
    	end
  	end

	get '/courses/new' do
  		if session["user_id"] != nil
  			@user = User.find(session["user_id"])
  			erb :'courses/new'
  		else
    		redirect '/login'
  		end
	end

	post '/courses' do
  		if params[:description] != "" && params[:title] != ""
			course = Course.create(:user_id => params[:user_id], :description => params[:description], :title => params[:title])
			redirect "/courses/#{course.id}"
  		else
  		redirect 'courses/new'
  		end
	end

	get '/courses/:id/edit' do
  		if session["user_id"] == nil
    		redirect "/login"
  		end
  		@course = Course.find(params[:id])
  		if session["user_id"] == @course.user_id
    		erb :'/courses/edit_course'
  		else
    		redirect "/login"
  		end
	end

	patch '/courses/:id' do
		@course = Course.find(params[:id])
  		if params[:description] != "" && params[:title] != ""
			@course.title = params[:title]
			@course.description = params[:description]
			@course.save
			redirect "/courses/#{@course.id}"
  		else
    		redirect "/courses/#{@course.id}/edit"
  		end
	end

	get '/courses/:id/delete' do
  		@course = Course.find(params[:id])
  		if session["user_id"] == @course.user_id
    		@course.destroy
    		redirect "/courses"
  		else
    		redirect "/courses"
  		end
	end

	delete '/courses/:id/delete' do
  		@course = Course.find(params[:id])
  		if session["user_id"] == @course.user_id
  			@course.destroy
  			redirect '/courses'
		else
  			redirect '/login'
		end
	end


	get '/courses/:id' do
  		@course = Course.find(params[:id])
  		@rights = 0
  		if session["user_id"] != nil
    		@rights = 1
    		erb :'/courses/show_course'
  		else
  			redirect :'/login'
  		end
	end
end
