IntercoolerTutorialApp::Application.routes.draw do

  resources :contacts

  get "flash_content" => "contacts#flash_content"

end
