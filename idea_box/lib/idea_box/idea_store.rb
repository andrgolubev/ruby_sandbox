require 'yaml/store'

module Constants
  DATABASE_PATH = "db/ideabox_db"
end

class IdeaStore
  def self.create(attributes)
    database.transaction do |db|
      db['ideas'] << attributes
    end
  end
  
  def self.all
    ideas = []
    raw_ideas.each_with_index do |data, i|
      ideas << Idea.new(data.merge('id' => i))
    end
    ideas
  end
  
  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end
  
  def self.delete(position)
    database.transaction do |db|
      db['ideas'].delete_at(position)
    end
  end
  
  def self.find(id)
    raw_idea = find_raw_idea(id)
    Idea.new(raw_idea.merge('id' => id))
  end
  
  def self.find_raw_idea(id)
    database.transaction do |db|
      db['ideas'].at(id)
    end
  end
  
  def self.update(id, data)
    database.transaction do |db|
      db['ideas'][id] = data
    end
  end
  
  #create new database or fetch existing - using ||=
  def self.database
    return @database if @database
    
    @database = YAML::Store.new(Constants::DATABASE_PATH)
    @database.transaction do
      @database['ideas'] ||= []
    end
    @database
  end
  
  def database
    Idea.database
  end
end