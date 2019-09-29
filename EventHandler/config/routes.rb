Rails.application.routes.draw do
  #events related
  post "/events", to: "events#create"
  delete "/events", to: "events#delete"
  get "/events", to: "events#get"
  put "/events", to: "events#update"

  post "/categories", to: "categories#create"
  get "/categories", to: "categories#get"
  put "/categories", to: "categories#update"
  delete "/categories", to: "categories#delete"

  # modify volunteer from event
  post "/events/volunteer", to: "volunteer#create"
  delete "/events/volunteer", to: "volunteer#delete"
  put "/events/volunteer", to: "volunteer#update"
  
  # modify feedback
  post "/events/feedbacks", to: "feedbacks#create"
  get "/events/feedbacks", to: "feedbacks#get"

end
