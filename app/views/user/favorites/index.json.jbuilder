json.data do
  json.items do
    json.array!(@reviews) do |review|
      json.id review.id
      json.user do
        json.name review.user.name
      end
      json.image url_for(review.image)
      json.shop review.shop
      json.address review.address
      json.genre review.genre
      json.favorites review.favorites.count
      json.latitude review.latitude
      json.longitude review.longitude
    end
  end
end