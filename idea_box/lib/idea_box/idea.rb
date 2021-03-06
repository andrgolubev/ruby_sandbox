class Idea
  include Comparable
  def <=>(other)
    other.rank <=> rank
  end
  
  
  attr_reader :title, :description, :rank, :id
  
  def initialize(attributes)
    @title = attributes['title']
    @description = attributes['description']
    @rank = attributes['rank'].to_i || 0
    @id = attributes['id'].to_i
  end
  
  def save
    IdeaStore.create(to_h)
  end
  
  def to_h
    {
      "title" => @title,
      "description" => @description,
      "rank" => @rank
    }
  end
  
  def like!
    @rank += 1
  end
end