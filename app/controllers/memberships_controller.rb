class MembershipsController < ApplicationController
	before_filter :find_group
	def index
		@people = @group.people
	end

	def show
		@person = @group.people.find_by_id(params[:id])
	end

  	def new
		@person = @group.people.build
  	end

  	def create 
		s = params[:short]
		id = params[:id]
		p = Person.find_by_short(s) || Person.find(id)
		if p
			if !@group.people.find_by_id(p.id)
				@group.people.push(p)
			end
			redirect_to(:back, :notice => 'succeeded to add ' + p.name)
		else
			redirect_to :back, :alert => 'cannot find person ' + s
		end
	  end

	def destroy
		membership = Membership.find_by_group_id_and_person_id(@group.id, params[:id])
		membership.destroy
		redirect_to :back
	end

	def find_group
		@group = Group.find(params[:group_id])
	end
end
