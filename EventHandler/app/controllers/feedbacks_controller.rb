class FeedbacksController < ActionController::Base
  skip_before_action :verify_authenticity_token
  
  def create
    feedback = request.params[:feedback]
    userId = request.params[:userId]
    eventId = request.query_parameters[:eventId]
    # Check the validity first 
    if not (feedback.nil? or userId.nil? or eventId.nil?) and Event.exists?(eventId)
      feedback_instance = Feedback.create(feedback: feedback, 
        userId: userId, eventId: eventId)
      json = {
        "feedbackId" => feedback_instance.id,
        "feedback" => feedback, 
        "userId" =>  userId,
        "eventId" => eventId,
      }
      render :json => json
    else
      # Return HTTP 500 Error
      head 500
    end
  end


  def get
    event_id = request.query_parameters[:eventId]
    feedback_id = request.query_parameters[:feedbackId]
    if feedback_id.nil?
      result_json = {"eventId" => event_id,
        "feedbacks" => Feedback.where(eventId: event_id)}
      render :json => result_json
    else
      result_json = Feedback.where(eventId: event_id, feedbackId: feedback_id)[0]
      render :json => result_json
    end
  end

end
