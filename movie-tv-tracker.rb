require 'sqlite3'

# create sqlite3 db
db = SQLite3::Database.new("movie_tv_ratings.db")
db.results_as_hash = true # format the databse structures as hashes

create_reviews_table = <<-SQL
  CREATE TABLE IF NOT EXISTS reviews(
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    seasons INT,
    stars INT,
    comment VARCHAR(255),
    movie_or_tv INT
    );
SQL

create_types_table = <<-SQL
  CREATE TABLE IF NOT EXISTS types(
  id INTEGER PRIMARY KEY,
  type VARCHAR(255)
  );
SQL

db.execute(create_reviews_table)
db.execute(create_types_table)



# Driver code
puts "~~~ MOVIE AND TV TRACKER ~~~"
puts "Would you like to..."
puts "1. View the current list (type '1')"
puts "2. Add a movie or TV show to the list (type '2')"
action = gets.chomp

