require "cell"
require "exceptions"
require "test/unit"

class TestCell < Test::Unit::TestCase
  
  def test_cell_initialized
    cell = Cell.new(true)
    assert_equal(true, cell.alive)
  
    cell = Cell.new(false)
    assert_equal(false, cell.alive)
    
    cell = Cell.new
    assert_equal(false, cell.alive)
  end
  
  def test_cell_no_neighbors_add_neighbor
    cell = Cell.new
    
    assert cell.neighbor_count == 0
    
    cell.add_neighbor Cell.new
    
    assert cell.neighbor_count == 1
  end
  
  def test_cell_add_neighbor_nil
    cell = Cell.new
    
    assert cell.neighbor_count == 0, 'Cell neighbor_count is not zero'
    
    cell.add_neighbor nil
    
    assert cell.neighbor_count == 0, 'Cell neighbor_count is not zero'
  end
  
  def test_cell_full_neighbors_add_neighbor
    cell = Cell.new
    
    8.times do
      cell.add_neighbor(Cell.new)
    end
    
    assert_raise Exceptions::NeighborAddError do
      cell.add_neighbor(Cell.new)
    end
  end
  
  def test_alive_cell_has_no_neighbors
    cell = Cell.new(true)
    
    assert_equal(true, cell.alive)
    assert cell.alive_neighbor_count == 0
    
    cell.generate
    cell.update
    
    assert_equal(false, cell.alive)
  end
  
  def test_alive_cell_has_one_alive_neighbor
    cell = Cell.new(true)
    neighbor_cell = Cell.new(true)
    
    assert_equal(true, cell.alive)
    assert_equal(true, neighbor_cell.alive)
    
    cell.add_neighbor neighbor_cell
    
    cell.generate
    cell.update
    
    assert cell.neighbor_count < 2
    assert_equal(false, cell.alive)
  end
  
  def test_alive_cell_has_two_alive_neighbors
    cell = Cell.new(true)
    
    assert_equal(true, cell.alive)
    
    cell.add_neighbor Cell.new(true)
    cell.add_neighbor Cell.new(true)
    
    assert cell.neighbor_count == 2
    
    cell.update
    
    assert_equal(true, cell.alive)
  end
  
  def test_alive_cell_has_three_alive_neighbors
    cell = Cell.new(true)
    
    assert_equal(true, cell.alive)
    
    3.times do
      cell.add_neighbor Cell.new(true)
    end
    
    assert cell.neighbor_count == 3
    
    cell.update
    
    assert_equal(true, cell.alive)
  end
  
  def test_dead_cell_has_less_than_three_alive_neighbors
    cell = Cell.new(false)
    
    cell.add_neighbor Cell.new(true)
    cell.add_neighbor Cell.new(true)
    
    assert cell.neighbor_count < 3
    
    cell.update
    
    assert_equal(false, cell.alive, "Cell should not be alive")
  end
  
  def test_dead_cell_has_exactly_three_alive_neighbors
    cell = Cell.new(false)
    
    3.times do
      cell.add_neighbor Cell.new(true)
    end
    
    assert cell.neighbor_count == 3
    
    cell.generate
    cell.update
    
    assert_equal(true, cell.alive)
  end
end
