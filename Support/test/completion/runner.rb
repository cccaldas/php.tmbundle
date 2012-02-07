#!/usr/bin/env ruby
require "../../bin/parser.rb"

begin
  
  def run_classes
    puts "run_classes"
    puts ""
    
    puts "search for: Model_Entity_P"
    classes = Parser.find_classes("./classes/", "Model_Entity_P")
    puts classes
    puts ""
    
    puts "search for: Model_"
    classes = Parser.find_classes("./classes/", "Model_")
    puts classes
    puts ""
    
    puts "search for: Model_DAO"
    classes = Parser.find_classes("./classes/", "Model_DAO")
    puts classes
    puts ""
  end
  
  def run_constants
    puts "run_constants"
    puts ""
    
    puts "search for: DAO_STATIC_"
    constants = Parser.find_constants("./classes/", "DAO_STATIC_")
    puts constants
    puts ""
    
    puts "search for: PRODUCT"
    constants = Parser.find_constants("./classes/", "PRODUCT")
    puts constants
    puts ""
  end
  
  def run_static_functions
    puts "run_static_functions"
    puts ""
    
    puts "search for: Model_DAO_Products"
    functions = Parser.get_static_functions("./classes/", "Model_DAO_Products")
    puts functions
    puts ""
  end
  
  #run
  #run_classes
  run_constants
  #run_static_functions
    
end
