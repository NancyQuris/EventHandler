class CategoriesController < ActionController::Base
  skip_before_action :verify_authenticity_token 

  def create
    category = request.params[:category]
    if Category.exists?(categoryName: category)
      new_category = Category.create(categoryName: category, 
        createdTime: DateTime.now, updatedTime: DateTime.now)
      json = {"categoryId" => new_category.id, 
              "category" => category}
      render :json => json
    else
      head 400 #bad request, the category name has been occupied
    end 
  end

  def delete
    category_id = request.query_parameters[:categoryId]
    if Category.exists?(category_id)
      category = Category.find(category_id)
      category.destroy
      json = {"result" => "Category deleted"}
      render :json => json
    else 
      head 500
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
      if Category.exists?(categoryName: category_name)
        category = Category.find(category_id)
        category.categoryName = category_name
        category.updatedTime = DateTime.now
        json = {"categoryId" => category.id, 
          "category" => category_name}
        render :json => json
      else
        head 400 #bad request, the category name has been occupied
      end
    else
      head 500
    end
  end

end
