class VolunteerController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def create
    event_id = request.query_parameters[:eventId]
    user_id = request.params[:userId]
    if event_id.present?
      if user_id.present?
        if Event.exists?(id: event_id)
          new_volunteer_registration = VolunteerRegistration.create(eventId: event_id, userId: user_id, status: "registered", createdTime: DateTime.now, updatedTime: DateTime.now)
          json = {"event id: " => new_volunteer_registration.eventId,
                  "user id: " => new_volunteer_registration.userId,
                  "event_status: " => new_volunteer_registration.status}
          render :json => json
        else 
          head 500  
        end
      else 
        head 400
      end
    else 
      head 400
    end
  end

  def delete
    event_id = request.query_parameters[:eventId]
    user_id = request.params[:userId]
    if event_id.present?
      if user_id.present?
        users = VolunteerRegistration.where(eventId: event_id, userId: user_id)
        if users.empty?
          head 500
        else   
          register_id = users.first.id
          user = VolunteerRegistration.find(register_id)
          user.update(status: 'withdrawed')
          json = {"result: " => "Volunteer withdraw from event"}
          render :json => json
        end
      else 
        head 400
      end
    else 
      head 400
    end
  end

  def get
    json = {"get" => ["volunteer_controller_get1", "get2"]}
    render :json => json
  end

  def update
    event_id = request.query_parameters[:eventId]
    user_id = request.params[:userId]
    if event_id.present?
      if user_id.present?
        users = VolunteerRegistration.where(eventId: event_id, userId: user_id)
        if users.empty?
          head 500
        else   
          register_id = users.first.id
          user = VolunteerRegistration.find(register_id)
          user.update(status: 'attended')
          json = {"result: " => "Volunteer attend event"}
          render :json => json
        end
      else 
        head 400
      end
    else 
      head 400
    end
  end

end
