json.array!(@subdomains) do |subdomain|
  json.extract! subdomain, :id, :email
  json.url subdomain_url(subdomain, format: :json)
end
