class FeedbacksController < ActionController::Base
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
    json = {"update" => ["update1", "update2"]}
    render :json => json
  end

end
