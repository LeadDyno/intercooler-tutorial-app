IntercoolerTutorialApp::Application.routes.draw do

  resources :contacts do
    collection do
      get 'contact_rows'
    end
  end

  get "flash_content" => "contacts#flash_content"

end
