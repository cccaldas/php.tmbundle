#!/usr/bin/env ruby

# -wKU


require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

begin
  choices = OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/functions.plist'))
  choices += OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/syntax.plist'))
  #result = %x( echo 'hi' )
  #result = %x( grep -E -n -r --include=\*.php --exclude=.svn --exclude=.git "function i\w+\s*\(" . )
  #result.sub(")","")
  #result.sub("(","")
  #result = %x( ls )
  
  

  #choices += OSX::PropertyList.load("({display = 'concatenatetest'; insert = '" + result  + "';},)")
  
  
  
  TextMate::UI.complete(choices, :initial_filter => ENV['TM_CURRENT_WORD'], :extra_chars => '_')
end