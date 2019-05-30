# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#  id          :integer      not null, primary key
#  movie_id    :integer      not null
#  actor_id    :integer      not null
#  ord         :integer

def find_angelina
  Actor.find_by(name: 'Angelina Jolie')
end

def find.first
  Actor.find

def top_titles
  Movie
    .select(:id, :title)
    .where('score >= 9')
end

def star_wars
  Movie
    .select(:id, :title, :yr)
    .where('title LIKE \'%Star Wars%\'')
end


def below_average_years
  Movie
    .select('yr', 'COUNT(*) as bad_movies')
    .where('score < 5')
    .group('yr')
    .order('bad_movies DESC')
end

def alphabetized_actors
  Actor
    .order('name ASC')
    .limit(10)
end

def pulp_fiction_actors
  Actor
    .select(:id, :name)
    .joins(:movies)
    .where('title = \'Pulp Fiction\'')
end

def uma_movies
  Movie
    .select(:id, :title, :yr)
    .joins(:actors)
    .where('name = \'Uma Thurman\'')
    .order('yr ASC')
end
