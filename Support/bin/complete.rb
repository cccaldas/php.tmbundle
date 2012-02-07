#!/usr/bin/env ruby

require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_BUNDLE_SUPPORT'] + '/bin/parser.rb'

begin
  choices = []
  
  env_current_word  = ENV["TM_CURRENT_WORD"]
  env_file_path     = ENV["TM_FILEPATH"]
  env_project_path  = ENV["TM_PROJECT_DIRECTORY"]
  
  #puts env_current_word
  
  
  #search for static functions
  if env_current_word.index("::") != nil
    klass = env_current_word.split("::")[0]
    env_current_word = env_current_word.split("::")[1]
    functions = Parser.get_static_functions(env_project_path, klass);
    functions.each { |r|
      item = r
      display = item.gsub(%r{\(.*}, "") #removing params
      insert  = item.gsub(%r{.*\(}, "(") #removing params
      choices += OSX::PropertyList.load(Parser.parse_choice(display, insert))
    }
  else
    #search for classes
    classes = Parser.find_classes(env_project_path, env_current_word)
    classes.each { |r|
      item = r
      choices += OSX::PropertyList.load(Parser.parse_choice(item, ""))
    }
    
    #search for static variables
    variables = Parser.find_static_variables(env_project_path, env_current_word)
    variables.each { |r|
      item = r
      choices += OSX::PropertyList.load(Parser.parse_choice(item, ""))
    }
  end
  
  
  TextMate::UI.complete(choices, :initial_filter => env_current_word, :extra_chars => '_')
end