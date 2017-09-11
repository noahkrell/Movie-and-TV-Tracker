require 'sqlite3'

# create sqlite3 db
db = SQLite3::Database.new("movie_tv_ratings.db")
# db.results_as_hash = true # format the databse structures as hashes

create_reviews_table = <<-SQL
  CREATE TABLE IF NOT EXISTS reviews(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    stars REAL,
    comment VARCHAR(255),
    type_id INT,
    genre_id INT,
    FOREIGN KEY (type_id) REFERENCES types(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
    );
SQL

create_types_table = <<-SQL
  CREATE TABLE IF NOT EXISTS types(
  id INTEGER PRIMARY KEY,
  type VARCHAR(255),
  UNIQUE(id, type)
  );
SQL

create_genres_table = <<-SQL
  CREATE TABLE IF NOT EXISTS genres(
  id INTEGER PRIMARY KEY,
  genre VARCHAR(255),
  UNIQUE(id, genre)
  );
SQL

db.execute(create_reviews_table)
db.execute(create_types_table)
db.execute(create_genres_table)

# db.execute("INSERT INTO types (type) VALUES ('Movie')")
# db.execute("INSERT INTO types (type) VALUES ('TV Show')")
# db.execute("INSERT INTO genres (genre) VALUES ('Action')")
# db.execute("INSERT INTO genres (genre) VALUES ('Comedy')")
# db.execute("INSERT INTO genres (genre) VALUES ('Drama')")
# db.execute("INSERT INTO genres (genre) VALUES ('Musical')")
# db.execute("INSERT INTO genres (genre) VALUES ('Sci-Fi')")
# db.execute("INSERT INTO genres (genre) VALUES ('Fantasy')")
# db.execute("INSERT INTO genres (genre) VALUES ('Documentary')")
# db.execute("INSERT INTO genres (genre) VALUES ('Family')")
def print_slowly
  dots = [".",".","."]
  dots.each {|i| print i; sleep 0.20}
  puts "\n"
end

def add_item(db)
  puts "What is the name of the movie/show?"
  title = gets.chomp
  puts "Rating out of 5?"
  stars = gets.chomp
  puts "Feel free to enter a short review!"
  comment = gets.chomp
  puts "Is it a Movie (type '1') or a TV Show (type '2') ?"
  type = gets.chomp
  puts "What genre? Type the corresponding number. Action(1), Comedy(2), Drama(3), Musical(4), Sci-fi(5), Fantasy(6), Documentary(7), Family(8)"
  genre = gets.chomp 
  db.execute("INSERT INTO reviews (title, stars, comment, type_id, genre_id) VALUES (?, ?, ?, ?, ?)", [title, stars, comment, type, genre])
  print_slowly
  puts "CONFIRMATION: Item has been added to the list!"
end

def view_list(db)
  puts "Would you like to..."
  puts "View MOVIES you've rated (type '1'), TV SHOWS you've rated (type '2'), or BOTH (type '3')?"
  list_type = gets.chomp
  print_slowly
  if list_type == "3"
    entries = db.execute("SELECT * FROM reviews")
    puts "***** MOVIES AND TV SHOWS YOU'VE RATED *****"
    entries.each do |item|
      puts "•"+item[1].upcase + " | " + item[2].to_s + " stars" + " | "
    end
  elsif list_type == "1"
    movies = db.execute("SELECT * FROM reviews WHERE type_id=1")
    puts "***** MOVIES YOU'VE RATED *****"
    movies.each do |item|
      puts "•"+item[1].upcase + " | " + item[2].to_s + " stars" + " | " 
    end
  elsif list_type == "2"
    shows = db.execute("SELECT * FROM reviews WHERE type_id=2")
    puts "***** TV SHOWS YOU'VE RATED *****"
    shows.each do |item|
      puts "•"+item[1].upcase + " | " + item[2].to_s + " stars" + " | " 
    end
  end
  puts "\n \n"
end

def search_list(db)
  puts "Search for movie/show title:"
  search_title = gets.chomp
  print_slowly
  title = db.execute("SELECT * FROM reviews WHERE title='#{search_title}'")
  title.each do |item|
    puts "•"+item[1].upcase + " | " + item[2].to_s + " stars" + " | " + item[3]
  end
end

# Driver code
puts "~~~ MOVIE AND TV TRACKER ~~~"
done = false
until done == true
  puts "WOULD YOU LIKE TO:"
  puts "1. View the current list (type '1')"
  puts "2. Add a movie or TV show to the list (type '2')"
  puts "3. Search for a movie (type '3')"
  puts "4. Exit the program (type '4')"
  action = gets.chomp
  if action == "2"
    print_slowly
    add_item(db)
  elsif action == "1"
    print_slowly
    view_list(db)
  elsif action == "3"
    print_slowly
    search_list(db)
  elsif action == "4"
    done = true
  end
end
