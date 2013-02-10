require 'exceptions'

class Cell
  
  attr_accessor :alive, :neighbors
  
  def initialize(alive=false) 
    @alive = @newState = alive
    @neighbors = []
  end
    
  def neighbor_count
    @neighbors.size
  end
  
  def alive_neighbor_count
    @neighbors.find_all{|neighbor| neighbor.alive }.size
  end
    
  def add_neighbor(cell)
    if cell
      if @neighbors.size < 8
        @neighbors << cell
      else
        raise Exceptions::NeighborAddError
      end
    end
  end
  
  def generate
    neighbor_count = alive_neighbor_count
    if @alive
      @newState = (neighbor_count == 2 || neighbor_count == 3)
    else
      @newState = (neighbor_count == 3)
    end
  end
  
  def update
    @alive = @newState
  end
end
