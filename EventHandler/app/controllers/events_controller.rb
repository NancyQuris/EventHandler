class EventsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def create
    event_name = request.params[:eventName]
    start_date_time = request.params[:startDateTime]
    end_date_time = request.params[:endDateTime]
    max_participants = request.params[:maxParticipants]
    min_participants = request.params[:minParticipants]
    organizer_name = request.params[:organizerName]
    description = request.params[:description]
    category_id = request.params[:categoryId]
    event_status = request.params[:eventStatus]
    
    if event_name.present? && start_date_time.present? && end_date_time.present? 
      && organizerName.present? &&  description.present? && category_id.present?
      && event_status.present?
      
      begin
        new_event = Event.create(eventName: event_name,
          startDateTime: start_date_time, endDateTime: end_date_time, 
          maxParticipants: max_participants, minParticipants: min_participants, 
          organizerName: organizer_name, description: description, 
          categoryId: category_id, eventStatus: event_status)
        
          event_cate = EventCategory.create(categoryId: params[:categoryId], eventId: new_event.id)
        
          json = {
                    "eventId" => new_event.id,
                    "eventName" => new_event.eventName,
                    "startDateTime" => new_event.startDateTime,
                    "organizerName" => new_event.organizerName,
                    "categoryId" => event_cate.categoryId,
                    "description" => new_event.description,
                    "maxParticipants" => new_event.maxParticipants,
                    "minParticipants" => new_event.minParticipants,
                    "eventStatus" => new_event.eventStatus
                }
          render :json => json
      rescue Exception => e
        head 500
      end
    else
      head 400
    end 
  end


  def delete
    event_id = request.query_parameters[:eventId]
    if event_id.present?
      if Event.exists?(event_id)
        begin
          Event.find_by(id: event_id).destroy
          json = {"result" => event_id}
          render :json => json
        rescue Exception => e
          head 500
        end
      else 
        head 500
      end
    else
      head 400
    end
    
  end

  def get
    begin
      id = request.query_parameters["eventId"]
      search = request.query_parameters["search"]
      cate = request.query_parameters["categoryId"]
      if (id)
        render :json => get_by_id()
      elsif (search)
        render :json => {"events" => get_by_search()}
      elsif (cate)
        render :json => {"events" => get_by_cate()}
      else
        render :json => {"events" => all_events()}
      end
    rescue Exception => e
    end
  end

  def update
    update = false
    event_id = request.query_parameters[:eventId]
    if !event_id.present?
      head 400
    else
      if Event.exists?(event_id)
        event = Event.find(event_id)
        event_name = request.params[:eventName]
        start_date_time = request.params[:startDateTime]
        end_date_time = request.params[:endDateTime]
        organizer_name = request.params[:organizerName]
        category_id = request.params[:categoryId]
        description = request.params[:description]
        max_participants = request.params[:maxParticipants]
        min_participants = request.params[:minParticipants]
        event_status = request.params[:eventStatus]

        if event_name.present?
          event.eventName = event_name
          update = true
        end

        if start_date_time.present?
          event.startDateTime = start_date_time
          update = true
        end

        if end_date_time.present?
          event.endDateTime = end_date_time
          update = true
        end

        if organizer_name.present?
          event.organizerName = organizer_name
          update = true
        end

        if category_id.present?
          event.categoryId = category_id
          update = true
        end

        if description.present?
          event.description = description
          update = true
        end

        if max_participants.present?
          event.maxParticipants = max_participants
          update = true
        end

        if min_participants.present?
          event.minParticipants = min_participants
          update = true
        end

        if event_status.present?
          event.eventStatus = event_status
          update = true
        end

        if update
          event.updatedTime = DateTime.now
        end

        json = {"eventId" => event_id,
          "eventName" => event.eventName,
          "startDateTime" => event.startDateTime,
          "endDateTime" => event.endDateTime,
          "organizerName" => event.organizerName,
          "categoryId" => event.categoryId,
          "description" => event.description,
          "maxParticipants" => event.maxParticipants,
          "minParticipants" => event.minParticipants,
          "eventStatus" => event.eventStatus}
        render :json => json
      else 
        head 500
      end
    end    
  end

  def get_by_id()
    id = request.query_parameters[:eventId]
    if Event.exists?(id)
      e = Event.find(id)
      return {
              "eventId" => e.id,
              "eventName" => e.eventName,
              "startDateTime" => e.startDateTime,
              "endDateTime" => e.endDateTime,
              "organizerName" => e.organizerName,
              "categoryId" => params[:categoryId],
              "description" => e.description,
              "maxParticipants" => e.maxParticipants,
              "minParticipants" => e.minParticipants,
              "eventStatus" => e.eventStatus
            } 
    else
      head 500
    end 
  end

  def get_by_search()
    events = Event.where("eventName LIKE ?", "%#{request.query_parameters[:search]}%")
    events.each do |event|
      event.numOfParticipants = count_num_of_participants(event.id)
    end
    return events
  end

  def get_by_cate()
    category_id = request.query_parameters[:categoryId]
    events = Event.where(categoryId: category_id)
    events.each do |event|
      event.numOfParticipants = count_num_of_participants(event.id)
    end
    return events
  end

  def get_by_from_and_to_time
    from_time = params[:from_time]
    to_time = params[:to_time]
    events = Event.where(startDateTime: from_time..to_time)
    events.each do |event|
      event.numOfParticipants = count_num_of_participants(event.id)
    end
    render :json => {"events" => events}
  end

  def all_events()
    return Event.all
  end

  def count_num_of_participants(event_id)
    participants = VolunteerRegistration.where(eventId: event_id, status: "registered").or(VolunteerRegistration.where(eventId: event_id, status: "attended"))
    participants.size
  end

end
