require('pg')

class Bounty

  attr_accessor :name, :danger_level, :value, :homeworld
  attr_reader :id

  def initialize(spec)
    @name = spec['name']
    @danger_level = spec['danger_level']
    @value = spec['value'].to_i
    @homeworld = spec['homeworld']
    @id = spec['id'].to_i if spec['id']
  end

  def save()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "INSERT INTO bounties
    (name, danger_level, value, homeworld)
    VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@name, @danger_level, @value, @homeworld]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close
  end

  def Bounty.delete_all()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties"
    db.prepare("delete_all",sql)
    db.exec_prepared("delete_all")
    db.close
  end

  def Bounty.all()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties"
    db.prepare("select_all", sql)
    specs = db.exec_prepared("select_all")
    db.close
    return specs.map {|spec| Bounty.new(spec)}
  end

  def delete()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    bounties = db.exec_prepared("delete_one", values)
    db.close
  end

  def update()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "UPDATE bounties SET (name, danger_level, value, homeworld)
    = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @danger_level, @value, @homeworld, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def Bounty.find_by_name(name)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    specs = db.exec_prepared("find_by_name", values)
    db.close
    if specs.count > 0
      specs_hash = specs[0]
    else
      return nil
    end
    bounty = Bounty.new(specs_hash)
    return bounty
  end



 # def Bounty.find_by_id(id)
 #   db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
 #   sql = "SELECT * FROM bounties WHERE id = $1"
 #   values = [id]
 #   db.prepare("find_by_id", sql)
 #   specs = db.exec_prepared("find_by_id", values)
 #   db.close
 #   specs_hash = specs[0]
 #   bounty = Bounty.new(specs_hash)
 #   return bounty
 # end

end
