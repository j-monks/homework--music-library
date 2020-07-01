require_relative("../db/sql_runner")

class Album

    attr_reader :id
    attr_accessor :title, :genre, :artist_id

    def initialize(options)
        @id = options["id"].to_i() if options["id"]
        @title = options["title"]
        @genre = options["genre"]
        @artist_id = options["artist_id"].to_i()
    end

    def save() # CREATE
        sql = "INSERT INTO albums
        (title, genre, artist_id)
        VALUES
        ($1, $2, $3) RETURNING id" 
        values = [@title, @genre, @artist_id]
        result = SqlRunner.run(sql, values)
        @id = result[0]["id"].to_i()
    end

    def self.find(id) # READ
        sql = "SELECT * FROM albums
        WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values)
        return nil if result.first() == nil
        album_data = result[0] 
        return Album.new(album_data)
    end

    def self.find_by_genre(genre) # READ
        sql = "SELECT * FROM albums
        WHERE genre = $1"
        values = [genre]
        result = SqlRunner.run(sql, values)
        return nil if result.first() == nil
        album_data = result[0]
        return Album.new(album_data)
    end
     
    def self.all() # READ
        sql = "SELECT * FROM albums"
        result = SqlRunner.run(sql)
        return result.map { |album| Album.new(album) }
    end

    def artist() # READ
        sql = "SELECT * FROM artists
        WHERE id = $1"
        values = [@artist_id]
        result = SqlRunner.run(sql, values)
        artist_data = result[0]
        artist = Artist.new(artist_data)
    end

    def update() # UPDATE
        sql = "UPDATE albums 
        SET 
        (title, genre, artist_id) 
        = ($1, $2, $3) 
        WHERE id = $4"
        values = [@title, @genre, @artist_id, @id]
        result = SqlRunner.run(sql, values)
    end

    def self.delete_all() # DELETE
        sql = "DELETE FROM albums"
        result = SqlRunner.run(sql)
    end

    def delete() # DELETE
        sql = "DELETE FROM albums
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

end