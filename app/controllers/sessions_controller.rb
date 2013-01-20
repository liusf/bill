class SessionsController < ApplicationController
  skip_before_filter :auth, :only => [:new, :create, :destroy]

  # GET /index.json
  def index
    groups = @user.groups
    summary = {:group_count => groups.length, :total_account => 0}
    gs = []
    ret = {:summary => summary, :groups => gs}
    groups.each do |group|      
      g = {:group => {:id => group.id, :name => group.name, :count => group.memberships.count, :user_account => group.summary(@user.id)}}
      gs << g
      #group.
      summary[:total_account] = summary[:total_account] + g[:group][:user_account]
    end
  
    respond_succ ret
  end
  
  def new
    
  end

  # POST /login.json
  def create
    @user = User.find_by_name(params[:name])
    unless @user
      @user = User.create(:name => params[:name])
    end
    session[:user_id] = @user.id
    respond_succ
#      respond_succ
#    ldap = Net::LDAP.new
#    ldap.host = '220.181.8.40'
#    ldap.port = 389
#    ldap.auth "uid=#{params[:name]},ou=people,dc=rd,dc=netease,dc=com", params[:password]
#    if ldap.bind
#      @user = User.find_by_name(params[:name])
#      unless @user
#        @user = User.create(:name => params[:name])
#      end
#      #TODO set login cookie
#      #cookies[:login] = { :value => "XJ-122", :expires => 1.hour.from_now }
#      session[:user_id] = @user.id
#      respond_succ
#    else
#      respond_fail 'login failed'
#    end
  end

  def destroy
    session[:user_id] = nil
    # TODO clear login cookie
    respond_succ
  end

  # /user.json
  def users
    prefix = params[:prefix]
    if valid_prefix?(prefix)
      puts 'insucc'
      @users = User.where("name like '#{prefix}%'")
      respond_succ :users => @users
    else
      respond_fail
    end
  end

  private

  def valid_prefix?(prefix)
    prefix !=nil && prefix.strip =~ /[a-z_]+/
  end
  
end
