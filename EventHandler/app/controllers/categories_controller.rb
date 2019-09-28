class CategoriesController < ActionController::Base
  skip_before_action :verify_authenticity_token
  
  #TO-DO: ensure distinction of category name 

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
    if Category.exists?(category_id)
      category = Category.find(category_id)
      category.destroy
      json = {"result" => "Category deleted"}
      render :json => json
    else 
      # TO-DO: change to HTTP status code
      json = {"result" => "error"}
      render :json => json
    end 
  end

  def get
    categories = Category.all()
    all_categroies = []
    categories.each do |category|
      all_categroies.push({"categoryId" => category.id, "category" => category.categoryName}) 
    end 
    json = {"categories" => all_categroies}
    render :json => json
  end

  def update
    category_id = request.query_parameters[:categoryId]
    category_name = request.params[:category]
    if Category.exists?(category_id)
      category = Category.find(category_id)
      category.categoryName = category_name
      category.updatedTime = DateTime.now
      json = {"categoryId" => category.id, 
        "category" => category_name}
      render :json => json
    else
      # TO-DO: change to HTTP status code
      json = {"result" => "error"}
      render :json => json
    end
  end

end
