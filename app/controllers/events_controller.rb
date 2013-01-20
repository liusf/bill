class EventsController < ApplicationController
#	before_filter :find_group
#	before_filter :find_event, :only => ['show', 'detail', 'add', 'detail2', 'add2', 'update', 'edit', 'destroy']
  # GET /events
  # GET /events.json
  def index
    @events = @group.events

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    ##
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json  { respond_event @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    groups = @user.groups
    groups_users = {}    
    groups.each do |group|
      groups_users[group.id] = group.users
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json do
        respond_succ :groups => groups, :event_types => EventType.all, :places => Place.all, :groups_users => groups_users
      end
    end
  end

  # GET /events/1/edit
  def edit
    
  end

#  group_id, date, event_type_id, place_id, user_ids=xx,xx,
  # POST /events
  # POST /events.json
  def create
    @event = Event.new(:event_type_id => params[:event_type_id], :place_id => params[:place_id], :group_id => params[:group_id], :date => params[:date])
    member = Membership.find_by_user_id_and_group_id(@user.id, @event.group_id)
    if !member
      respond_fail
      return
    end
    group = Group.find(@event.group_id)
    users = group.users
    user_map = {}
    users.map { |u| user_map[u.id] = u  }
    ## calc users pay & consume    
    user_ids = params[:user_ids]
    if user_ids == nil || user_ids.strip.length == 0
      respond_fail
      return
    end
    ids = user_ids.split(',')
    validate_ids = ids.select {|id| (/[0-9]+/ =~ id) && id.to_i != @user_id && user_map[id.to_i] }
    validate_ids.uniq!

    pay = params[:pay]
    if pay.nil? || pay.to_f < 0.1
      respond_fail
      return
    end
    total_pay = pay.to_f
    average = (total_pay /  (validate_ids.length + 1))
    
    evts = []
    validate_ids.each do |id|
      evt = EventUser.new(:user_id => id, :consume => average, :pay => 0)
      evts << evt
    end
    
    evt = EventUser.new(:user_id => @user_id, :consume => average, :pay => total_pay)
    evts << evt
    @event.event_users = evts

    respond_to do |format|
      if @event.save
        format.html { redirect_to( event_path(@event), :notice => 'Event was successfully created.') }
        format.json  { respond_event_summary @event}
      else
        format.html { render :action => "new" }
        format.json  { respond_fail }
      end
    end
  end

  def detail 
  end

  def add
    if (params[:event][:person_ids] && @event.update_attributes(params[:event]))
	redirect_to detail2_group_event_path(@group, @event)
    else
	redirect_to detail_group_event_path(@group, @event)
    end
  end

  def detail2
  end

  def add2
    # sum pay
    people = params[:event_person]
    db = []
    sum = 0
    for id, person in people do
      pay = person[:pay].to_i 
      consume = person[:consume].to_i
      sum += pay
      db.push([id, pay, consume])
    end

    equal = sum / people.size
    db.each do |ep|
      EventPerson.find(ep[0]).update_attributes(:pay => ep[1], :consume => equal)
    end 
    redirect_to group_event_path(@group, @event), :notice => sum
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to detail_group_event_path(@group, @event), :notice => 'Event was successfully updated.' }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(group_events_path(@group)) }
      format.json  { head :ok }
    end
  end

  private

  def find_event 
    @event = @group.events.find(params[:id])
  end

  def respond_event(event)
    respond_succ event_summary(event)
  end

  def event_summary(event)
    {:group => event.group, :date => event.date, :event_type => event.event_type, :place => event.place, :users => event.users}
  end

  def respond_event_summary(event)
    account = Group.find(event.group_id).summary(@user_id)
    res = {:account => account, :summary => event_summary(event)}
    respond_succ res
  end
  
end
