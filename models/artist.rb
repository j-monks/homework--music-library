require_relative("../db/sql_runner")

class Artist

    attr_reader :id
    attr_accessor :name

    def initialize(options)
        @id = options["id"].to_i() if options["id"]
        @name = options["name"]
    end

    def save() # CREATE
       sql = "INSERT INTO artists
       (name)
       VALUES
       ($1) RETURNING id" 
       values = [@name]
       result = SqlRunner.run(sql, values)
       @id = result[0]["id"].to_i()
    end

    def self.all() # READ
        sql = "SELECT * FROM artists"
        result = SqlRunner.run(sql)
        return result.map { |artist| Artist.new(artist) }
    end

    def albums() # READ
        sql = "SELECT * FROM albums
        WHERE artist_id = $1"
        values = [@id]
        result = SqlRunner.run(sql, values)
        albums = result.map { |album| Album.new(album) }
        return albums
    end

    def self.find(id) # READ
        sql = "SELECT * FROM artists 
        WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values)
        return nil if result.first() == nil
        artist_data = result[0] 
        return Artist.new(artist_data)
    end

    def update() # UPDATE
        sql = "UPDATE artists SET (name) 
        = ($1) 
        WHERE id = $2"
        values = [@name, @id]
        result = SqlRunner.run(sql, values)
    end

    def self.delete_all() # DELETE
        sql = "DELETE FROM artists"
        result = SqlRunner.run(sql)
    end

    def delete() # DELETE
        sql = "DELETE FROM artists
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

end