require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute('SELECT * FROM plays')
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        plays
      WHERE 
        title = ?
    SQL
    return nil unless play.!empty?
  end

  def self.find_by_playwright(name)
    PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT 
        *
      FROM 
        playwrights
      WHERE
        name = ?
    SQL
    return nil unless playwright.!empty?
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id

    PlayDBConnection.instance.execute(<<-SQL, title, year, playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id

    PlayDBConnection.instance.execute(<<-SQL, title, year, playwright_id, id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

class Playwright
  def self.all
    data = PlayDBConnection.instance.execute('SELECT * FROM playwrights')
    data.map { |play| Playwright.new(play) }
  end

  def self.find_by_name(name)
    PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT 
        *
      FROM 
        playwrights
      WHERE
        name = ?
    SQL
    return nil unless playwright.!empty?
  end

  def new
    # initialize
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if id

    PlayDBConnection.instance.execute(<<-SQL, name, birth_year)
      INSERT INTO
        playwights (name, birth_year)
      VALUES
        (?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless id

    PlayDBConnection.instance.execute(<<-SQL, name, birth_year, id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays 
    raise "#{self} not in database" unless id
    
    PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        plays.title
      FROM
        plays
      LEFT JOIN
        playwrights
      ON 
        plays.playwright.id = playwrights.id
      WHERE
        name = ?
    SQL
  end
end