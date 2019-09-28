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
    json = {"update" => ["update1", "update2"]}
    render :json => json
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

  end

  def all_events()
    return Event.all
  end

end
