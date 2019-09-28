class EventsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def create
    json = {"create" => ["create1", "create2"]}
    render :json => json
  end

  def delete
    json = {"delete" => ["delete1", "delete2"]}
    render :json => json
  end

  def get
    json = {"get" => ["get1", "get2"]}
    render :json => json
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

      json = {"eventId" => event_id,
        "eventName" => event.eventName,
        "startDateName" => event.startDateName,
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

end
