json.array!(@accounts) do |account|
  json.extract! account, :id, :subdomain, :email
  json.url account_url(account, format: :json)
end
