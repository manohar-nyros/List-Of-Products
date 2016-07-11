json.array!(@lists) do |list|
  json.extract! list, :id, :title, :description, :text, :price, :quantity, :vat, :total, :product_id
  json.url list_url(list, format: :json)
end
