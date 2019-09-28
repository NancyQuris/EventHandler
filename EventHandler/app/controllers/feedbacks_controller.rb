class FeedbacksController < ActionController::Base
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
    event_id = request.query_parameters[:eventId]
    event_feedbacks = Feedback.where(eventId: event_id)
    json = {"get" => event_feedbacks}
    render :json => json
  end

  def update
    json = {"update" => ["update1", "update2"]}
    render :json => json
  end

end
