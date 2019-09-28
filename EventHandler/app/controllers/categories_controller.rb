class CategoriesController < ActionController::Base
  skip_before_action :verify_authenticity_token
  
  def create
    category = request.params[:category]
    new_category = Category.create(categoryName: category, 
      createdTime: DateTime.now, updatedTime: DateTime.now)
    json = {"categoryId" => new_category.id, 
            "category" => category}
    render :json => json
  end

  def delete
    category_id = request.query_parameters[:categoryId]
    begin
      category = Category.find(category_id)
      category.destroy
      json = {"result" => "Category deleted"}
      render :json => json
    rescue ActiveRecord::RecordNotFound => exception
      render :status => :internal_server_error
    end
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
