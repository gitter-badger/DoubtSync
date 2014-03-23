class UserController < ApplicationController
	#TODO make sure user does not register with reserved keyword
	#TODO Validation for profile form
	def index
		@id = params['id']
		if @id.is_number?
			@user = User.find_by_id(@id)
			if @user.nil?
				#TODO 404 pages here
				render :text => "Not exist"
			else
				# TODO Show his details
				if @user.role.eql? "student"
					render 'index'
				elsif @user.role.eql? "professor"
					#TODO Profile page for professor
				elsif @user.role.eql? "ambassador"
					#TODO Profile page for ambassador
				end
			end
		else
			@user = User.find_by username: @id
			if @user.nil?
				#TODO 404 pages here
				render :text => "Not exist"
			else
				# TODO Show his details
				render :text => "Found him"
			end
		end
	end
	def manage
		if current_user.role.name.eql? "student"
			@student = Student.find_by user_id: current_user.id
			
			render 'profile'
		else
			render :text => current_user.role.name
		end
	end
	def save
		#TODO Check validation
		#FIXME Dry
		if current_user.role.name.eql? "student"
			if !Student.find_by user_id: current_user.id?
				dob = params['user']
				mobile = params['mobile']
				gender = params['gender'].eql?"male"
				student = Student.new(:first_name => params['first_name'],:last_name => params['last_name'],
					:degree => params['degree'],:graduate_year => params['graduate'],:gender => gender,
					:dob => dob['dob'],:mobile => mobile['phone'],:user_id => current_user.id)
				student.save
					render :text =>  "saved"
			else
				student = current_user.student
				dob = params['user']
				mobile = params['mobile']
				gender = params['gender'].eql?"male"
				student.update(:first_name => params['first_name'],:last_name => params['last_name'],
					:degree => params['degree'],:graduate_year => params['graduate'],:gender => gender,
					:dob => dob['dob'],:mobile => mobile['phone'])
				student.save
				render :text =>  "updated"
			end
		else
			render :text =>  "TODO"+current_user.role.name
		end

	end
end