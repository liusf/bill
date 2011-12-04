class EventsController < ApplicationController
	before_filter :find_group
	before_filter :find_event, :only => ['show', 'detail', 'add', 'detail2', 'add2', 'update', 'edit', 'destroy']
  # GET /events
  # GET /events.xml
  def index
    @events = @group.events

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = @group.events.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.xml
  def create
    @event = @group.events.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(detail_group_event_path(@group, @event), :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
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
  # PUT /events/1.xml
  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to detail_group_event_path(@group, @event), :notice => 'Event was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(group_events_path(@group)) }
      format.xml  { head :ok }
    end
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def find_event 
    @event = @group.events.find(params[:id])
  end
end
