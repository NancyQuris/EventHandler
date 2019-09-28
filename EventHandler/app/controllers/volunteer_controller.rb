class VolunteerController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def create
    event_id = request.query_parameters[:eventId]
    user_id = request.params[:userId]
    new_volunteer_registration = VolunteerRegistration.create(eventId: event_id, userId: user_id, status: "registered", createdTime: DateTime.now, updatedTime: DateTime.now)
    json = {"event id: " => new_volunteer_registration.eventId,
            "user id: " => new_volunteer_registration.userId,
            "event_status: " => new_volunteer_registration.status}
    render :json => json
  end

  def delete
    event_id = request.query_parameters[:eventId]
    user_id = request.params[:userId]
    users = VolunteerRegistration.where(eventId: event_id, userId: user_id)
    register_id = users.first.id
    user = VolunteerRegistration.find(register_id)
    user.update(status: 'withdrawed')
    json = {"result: " => "Volunteer withdraw from event"}
    render :json => json
  end

  def get
    json = {"get" => ["get1", "get2"]}
    render :json => json
  end

  def update
    json = {"update" => ["update1", "update2"]}
    render :json => json
  end

end
