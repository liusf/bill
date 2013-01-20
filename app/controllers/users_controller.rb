# /groups/1/users
class UsersController < ApplicationController
  before_filter :find_group
  
  # GET /users.json
  def index
    @users = @group.users
    respond_succ :users => @users
  end

  # GET /users/new
  def new
    
  end
  
  # POST /users.json
  def create
    ids = params[:ids]
    if (ids != nil && ids.strip.split(',').length > 0)
      id_array = ids.strip.split(',')
      count = 0
      id_array.each do |id|
        if /[0-9+]/ =~ id
          begin
            if User.find(id)
              membership = Membership.create!(:group_id => @group.id, :user_id => id)
              count = count + 1 if membership.save
            end
          rescue
            
          end
        end
      end
      respond_succ :count => count
    else
      respond_fail
    end
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
    # only accessed by group member?
    unless Membership.find_by_group_id_and_user_id(@group.id, session[:user_id])
      respond_fail
    end   
  end
end
