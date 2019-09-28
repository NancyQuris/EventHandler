class EventsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def create
    new_event = Event.create(eventName: params[:eventName], 
                                startDateTime: params[:startDateTime], 
                                endDateTime: params[:endDateTime],
                                organizerName: params[:organizaterName],
                                # categoryId: params[:categoryId],
                                description: params[:description],
                                maxParticipants: params[:maxParticipants],
                                minParticipants: params[:minParticipants],
                                eventStatus: params[:eventStatus])
    # cate = Category.find(params[:categoryId])
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
  end


  def delete
    event_id = request.query_parameters[:eventId]
    Event.find_by(id: event_id).destroy
    json = {"result" => event_id}
    render :json => json
  end

  def get
    id = request.query_parameters["eventId"]
    search = request.query_parameters["search"]
    cate = request.query_parameters["categoryId"]
    if (id)
      render :json => get_by_id()
    elsif (search)
      render :json => get_by_search()
    elsif (cate)
      render :json => get_by_cate()
    else
      render :json => {"events" => all_events()}
    end
  end

  def update
    update = false
    event_id = request.query_parameters[:eventId]
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
    end    
  end

  def get_by_id()
    id = request.query_parameters[:eventId]
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
  end

  def get_by_search()
    return Event.where("eventName LIKE ?", "%#{request.query_parameters[:search]}%")
  end

  def get_by_cate()
    # to be done
  end

  def get_by_from_and_to_time
    from_time = params[:from_time]
    to_time = params[:to_time]
    events = Event.where(startDateTime: from_time..to_time)
    render :json => {"events" => events}
  end

  def all_events()
    return Event.all
  end

end
