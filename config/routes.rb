Refinery::Core::Engine.routes.draw do
  namespace "photo_gallery", :path => 'photo-gallery' do
    root :to => "collections#index"
  
    match "/collections/:collection_id/albums/:id/page-:page" => "albums#show"
    
    resources :collections, :only => [:index,:show] do
      resources :albums, :only => [:show] do
      end
    end
  end


  namespace "photo_gallery", :path => '' do
    namespace :admin, :path => 'refinery' do
      scope :path => 'photo-gallery' do
        root :to => "albums#index"

        resources :photos do
          collection do
            put :update_multiple
          end
        end

        resources :albums do
          resources :photos do
            collection do
              get :upload
              get :edit_multiple
            end
          end
        end

        resources :collections

      end
    end
  end

  # Frontend routes
  namespace :photo_gallery do
    resources :photo_pages, :only => [:index, :show]
  end

  # Admin routes
  namespace :photo_gallery, :path => '' do
    namespace :admin, :path => 'refinery/photo_gallery' do
      resources :photo_pages, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
