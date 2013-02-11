#!/usr/bin/env ruby
 
require 'world'
require 'cell'
require 'curses'

def init_game
  board_size = 50
  world = World.new(board_size)  
end

def init_screen
  Curses.noecho
  Curses.init_screen
  Curses.stdscr.keypad(true)
  Curses.timeout = 0
  
  begin
    yield
  ensure
    Curses.close_screen
  end
end

def write(line, column, text)
  Curses.setpos(line, column)
  Curses.addstr(text)
end

def random_initialize_world
  world = World.new(50)
  
  cells = world.cells.each do |cell|
    rand(100)
    cell.alive = rand(100) > 55 ? false : true
  end
  
  return world
end

def initialize_world_with_acorn
  world = World.new(50)
  
  world.spawn_cell(11, 12)
  world.spawn_cell(12, 14)
  world.spawn_cell(13, 11)
  world.spawn_cell(13, 12)
  world.spawn_cell(13, 15)
  world.spawn_cell(13, 16)
  world.spawn_cell(13, 17)
  
  return world
end

def initialize_world_with_glider
  world = World.new(20)
  
  world.spawn_cell(0, 1)
  world.spawn_cell(1, 2)
  world.spawn_cell(2, 0)
  world.spawn_cell(2, 1)
  world.spawn_cell(2, 2)
  
  return world
end

def display(world)
  cells = world.cells.each_with_index do |cell, index|
    x, y = world.index_to_xy(index)
    write x, y, cell.alive ? '*' : ' '
  end
end

init_screen do
  world = random_initialize_world
  
  loop do
    display world
    
    world.generate
    world.update
    
    sleep(0.15)
    
    case Curses.getch
    when ?q then break
    end
  end
end