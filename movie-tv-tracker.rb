require 'sqlite3'

# create sqlite3 db
db = SQLite3::Database.new("movie_tv_ratings.db")
db.results_as_hash = true # format the databse structures as hashes

create_reviews_table = <<-SQL
  CREATE TABLE IF NOT EXISTS reviews(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    stars REAL,
    comment VARCHAR(255),
    type INT
    );
SQL

create_types_table = <<-SQL
  CREATE TABLE IF NOT EXISTS types(
  id INTEGER PRIMARY KEY,
  type VARCHAR(255)
  );
SQL
db.execute("INSERT INTO types (type) VALUES ('Movie')")
db.execute("INSERT INTO types (type) VALUES ('TV Show')")
db.execute(create_reviews_table)
db.execute(create_types_table)

# # code to view data in ruby terminal program
# data = db.prepare "SELECT * FROM reviews"
# entries = data.execute

def add_item(db)
  puts "What is the name of the movie?"
  title = gets.chomp
  puts "Rating out of 5?"
  stars = gets.chomp
  puts "Feel free to enter a short review!"
  comment = gets.chomp
  puts "Is it a Movie (type '1') or a TV Show (type '2') ?"
  type = gets.chomp
  db.execute("INSERT INTO reviews (title, stars, comment, type) VALUES (?, ?, ?, ?)", [title, stars, comment, type])
end

# def view_list(db)


# Driver code
puts "~~~ MOVIE AND TV TRACKER ~~~"
puts "Would you like to..."
puts "1. View the current list (type '1')"
puts "2. Add a movie or TV show to the list (type '2')"
action = gets.chomp

if action == "2"
 add_item(db)
elsif action == "1"

end


