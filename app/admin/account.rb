ActiveAdmin.register Account do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  
 sidebar "Account Details", only: [:show, :edit] do
    ul do
      li link_to "Stores", admin_account_stores_path(account)
      li link_to "Users", admin_account_users_path(account)
    end
  end


ActiveAdmin.register Store do
permit_params :account_id,:name,:description
	belongs_to :account
		sidebar "Product Details", only: [:show, :edit] do
			ul do
				li link_to "Products", admin_store_products_path(store)
			end
		end	
	ActiveAdmin.register Product do
	permit_params :store_id,:title,:description,:image_url,:price
		belongs_to :store
	end
 end
  
ActiveAdmin.register User do
  belongs_to :account
end
end


