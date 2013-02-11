require "world"
require "test/unit"

class TestWorld < Test::Unit::TestCase
  
  def test_world_initialized
    world = World.new
    assert (world.cell_count == 9), 'world did not initialize to correct size'
    
    world = World.new(4)
    assert (world.cell_count == 16), 'world did not initialize to correct size'
  end
  
  def test_world_get_top_left_cell
    world = World.new
    
    cell_index = world.get_cell_index(0)
    cell_xy = world.get_cell_xy(0, 0)
    
    assert (cell_index == cell_xy), 'index to xy lookup is incorrect'
  end
  
  def test_world_get_top_right_cell
    world = World.new
    
    cell_index = world.get_cell_index(2)
    cell_xy = world.get_cell_xy(0, 2)
    
    assert (cell_index == cell_xy), 'index to xy lookup is incorrect'
  end
  
  def test_world_get_bottom_left_cell
    world = World.new
  
    cell_index = world.get_cell_index(6)
    cell_xy = world.get_cell_xy(2, 0)
    
    assert (cell_index == cell_xy), 'index to xy lookup is incorrect'
  end
  
  def test_world_get_bottom_right_cell
    world = World.new
  
    cell_index = world.get_cell_index(8)
    cell_xy = world.get_cell_xy(2, 2)
    
    assert (cell_index == cell_xy), 'index to xy lookup is incorrect'
  end
  
  def test_world_get_center_cell
    world = World.new
    
    cell_index = world.get_cell_index 4
    cell_xy = world.get_cell_xy 1, 1
    
    assert (cell_index == cell_xy), 'index to xy lookup is incorrect'
  end
  
  def test_world_index_to_xy_zero
    world = World.new

    x, y = world.index_to_xy 0

    assert (x == 0), 'x != 0'
    assert (y == 0), 'y != 0'
  end
  
  def test_world_index_to_xy_eight
    world = World.new
    
    x, y = world.index_to_xy 8
    
    assert (x == 2), 'x != 2'
    assert (y == 2), 'y != 2'
  end
  
  def test_world_get_cell_out_of_bounds
    world = World.new

    assert_nil world.get_cell_xy(-1, -1), 'Out of bounds cell is not nil'
    assert_nil world.get_cell_xy(0, -1), 'Out of bounds cell is not nil'
    assert_nil world.get_cell_xy(-1, 0), 'Out of bounds cell is not nil'
    assert_nil world.get_cell_xy(4, 4), 'Out of bounds cell is not nil'
  end
  
  def test_world_still_life_block
    world = World.new(2)
    
    world.spawn_cell 0, 0
    world.spawn_cell 0, 1
    world.spawn_cell 1, 0
    world.spawn_cell 1, 1
    
    world.generate
    world.update
    
    assert_equal true, world.get_cell_xy(0, 0).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(0, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 0).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 1).alive, 'Cell is not alive'
  end
  
  def test_world_still_life_behive
    world = World.new(4)
    
    world.spawn_cell 0, 1
    world.spawn_cell 0, 2
    world.spawn_cell 1, 0
    world.spawn_cell 1, 3
    world.spawn_cell 2, 1
    world.spawn_cell 2, 2
        
    world.generate
    world.update
    
    assert_equal true, world.get_cell_xy(0, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(0, 2).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 0).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 3).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 2).alive, 'Cell is not alive'
  end
  
  def test_world_still_life_loaf
    world = World.new(4)
    
    world.spawn_cell 0, 1
    world.spawn_cell 0, 2
    world.spawn_cell 1, 0
    world.spawn_cell 1, 3
    world.spawn_cell 2, 1
    world.spawn_cell 2, 3
    world.spawn_cell 3, 2
    
    world.generate
    world.update
    
    assert_equal true, world.get_cell_xy(0, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(0, 2).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 0).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 3).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 3).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(3, 2).alive, 'Cell is not alive'
  end
  
  def test_world_oscillator_blinker
    world = World.new(3)
    
    world.spawn_cell 1, 0
    world.spawn_cell 1, 1
    world.spawn_cell 1, 2
  
    world.generate
    world.update
  
    assert_equal false, world.get_cell_xy(1, 0).alive, 'Cell is not dead'
    assert_equal false, world.get_cell_xy(1, 2).alive, 'Cell is not dead'
    
    assert_equal true, world.get_cell_xy(0, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 1).alive, 'Cell is not alive'
  end
  
  def test_world_oscillator_toad_1
    world = World.new(4)
    
    world.spawn_cell 1, 1
    world.spawn_cell 1, 2
    world.spawn_cell 1, 3
    world.spawn_cell 2, 0
    world.spawn_cell 2, 1
    world.spawn_cell 2, 2
    
    world.generate
    world.update
    
    assert_equal true, world.get_cell_xy(0, 2).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 0).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 3).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 0).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 3).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(3, 1).alive, 'Cell is not alive'
  end
  
  def test_world_oscillator_toad_2
    world = World.new(4)
    
    world.spawn_cell 0, 2
    world.spawn_cell 1, 0
    world.spawn_cell 1, 3
    world.spawn_cell 2, 0
    world.spawn_cell 2, 3
    world.spawn_cell 3, 1
    
    world.generate
    world.update
    
    assert_equal true, world.get_cell_xy(1, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 2).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 3).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 0).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 2).alive, 'Cell is not alive'
  end
  
  def test_world_oscillator_beacon
    world = World.new(4)
    
    world.spawn_cell 0, 0
    world.spawn_cell 0, 1
    world.spawn_cell 1, 0
    world.spawn_cell 1, 1
    world.spawn_cell 2, 2
    world.spawn_cell 2, 3
    world.spawn_cell 3, 2
    world.spawn_cell 3, 3
    
    world.generate
    world.update
    
    assert_equal true, world.get_cell_xy(0, 0).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(0, 1).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(1, 0).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(2, 3).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(3, 2).alive, 'Cell is not alive'
    assert_equal true, world.get_cell_xy(3, 3).alive, 'Cell is not alive'
    assert_equal false, world.get_cell_xy(1, 1).alive, 'Cell is not dead'
    assert_equal false, world.get_cell_xy(2, 2).alive, 'Cell is not dead'
  end
end