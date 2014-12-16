json.array!(@stores) do |store|
  json.extract! store, :id, :name, :description, :account_id
  json.url store_url(store, format: :json)
end
