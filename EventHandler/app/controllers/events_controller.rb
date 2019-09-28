class EventsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def create
    json = {"param" => request.query_parameters["eventId"], 
            "body" => params['test'],
            "data" => Event.find_by(id: 1).id}
    render :json => json
    
  end

  def delete
    id = request.query_parameters["eventId"]
    render :json => json
  end

  def get
    id = request.query_parameters["eventId"]
    search = request.query_parameters["search"]
    cate = request.query_parameters["categoryId"]

    json = {"param" => request.query_parameters["eventId"], 
    "body" => params['test'],
    "data" => Event.find_by(id: 1).id}
    render :json => json
  end

  def update
    json = {"update" => ["update1", "update2"]}
    render :json => json
  end


end
