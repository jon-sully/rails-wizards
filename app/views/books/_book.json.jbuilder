json.extract! book, :id, :title, :author_name, :year_published, :isbn, :primary_topic, :fictionaility, :created_at, :updated_at
json.url book_url(book, format: :json)
