#!/usr/bin/env ruby -wKU

require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_BUNDLE_SUPPORT'] + '/bin/parser.rb'

begin
  choices = []
  
  env_current_word  = ENV["TM_CURRENT_WORD"]
  env_file_path     = ENV["TM_FILEPATH"]
  env_project_path  = ENV["TM_PROJECT_DIRECTORY"]
  
  # Build the list of completion choice.
  #choices = [{'display' => 'foo'}, {'display' => 'foo bar'},  {'display' => 'foo bar foo'}]

  # Options
  

  # Display the completion popup.
  #TextMate::UI.complete(choices, options)
  
  #return
  #puts "env_current_word:" + env_current_word
  
  
  #search for static functions  
  if env_current_word.index("::") != nil
    klass = env_current_word.split("::")[0]
    #env_current_word = env_current_word.split("::")[1]
    env_current_word = ""
    
    functions = Parser.get_static_functions(env_project_path, klass);
    functions.each { |r|
      item = r
      display = item.gsub(%r{\(.*}, "") #removing params
      insert  = item.gsub(%r{.*\(}, "(")
      #puts display
      choices += OSX::PropertyList.load(Parser.parse_choice(display, "(" + Parser.parse_function_parameters_to_insert(insert) + ")"))
    }
  else
    #search for classes
    classes = Parser.find_classes(env_project_path, env_current_word)
    classes.each { |r|
      item = r
      #puts item
      choices += OSX::PropertyList.load(Parser.parse_choice(item, ""))
    }
    
    #search for constants
    constants = Parser.find_constants(env_project_path, env_current_word)
    constants.each { |r|
      item = r
      choices += OSX::PropertyList.load(Parser.parse_choice(item, ""))
    }
    
    #general
    choices += OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/functions.plist'))
    choices += OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/syntax.plist'))
        
  end
  
  #puts choices
  
  options = {:extra_chars => ' _', :case_insensitive => false, :initial_filter => env_current_word}
  TextMate::UI.complete(choices, options)
end