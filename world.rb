class World

  attr_accessor :cells, :size
  
  def initialize(size=3)
    @size = size
    @cells = Array.new(size * size){|cell| Cell.new}
    setup_cell_neighbors
  end
  
  def cell_count
    @cells.size
  end
  
  def get_cell_index(index)
    @cells[index]
  end
  
  def get_cell_xy(x, y)
    if x.between?(0, @size - 1) && y.between?(0, @size - 1)
      @cells[x * @size + y]
    end
  end
  
  def index_to_xy(index)
    y = index % @size
    x = (index - y) / @size
    return x, y
  end
  
  def spawn_cell(x, y)
    cell = get_cell_xy(x, y)
    cell.alive = true
  end
  
  def generate
    @cells.each do |cell|
      cell.generate
    end
  end
  
  def update
    @cells.each do |cell|
      cell.update
    end
  end
  
  private
  
  def setup_cell_neighbors
    @cells.each_with_index do |cell, index|
      x, y = index_to_xy(index)
      
      # Top Row.
      cell.add_neighbor get_cell_xy(x - 1, y - 1)
      cell.add_neighbor get_cell_xy(x - 1, y)
      cell.add_neighbor get_cell_xy(x - 1, y + 1)
      
      # Middle Row.
      cell.add_neighbor get_cell_xy(x, y - 1)
      cell.add_neighbor get_cell_xy(x, y + 1)
      
      # Bottom Row.
      cell.add_neighbor get_cell_xy(x + 1, y - 1)
      cell.add_neighbor get_cell_xy(x + 1, y)
      cell.add_neighbor get_cell_xy(x + 1, y + 1)
    end
  end
end
