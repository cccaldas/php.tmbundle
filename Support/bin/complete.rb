#!/usr/bin/env ruby

# -wKU


require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

begin
  choices = OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/functions.plist'))
  choices += OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/syntax.plist'))
  #result = %x( echo 'hi' )
  #result = %x( grep -E -n -r --include=\*.php --exclude=.svn --exclude=.git "function i\w+\s*\(" . )
  #
  #result.sub("(","")
  #result = %x( ls )
  #result = %x( grep -E -n -r --include=\*.php --exclude=.svn --exclude=.git "public function" . )
  #dom = ‘www.gotripod.com‘
  #@whois = %x[whois #\{dom\}]
  project_path = ENV["TM_PROJECT_DIRECTORY"]
  
  
  #result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "public function" "#\{project_path\}" )
  #print exec("grep -Rni --include=\*.php --exclude=.svn --exclude=.git \"public function\" . ")
  #result = exec("grep -Rni --include=\*.php --exclude=.svn --exclude=.git \"public function\" . ")
  
  #result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "public function" . )
  
  #public static function
  result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "public static function" "#{project_path}" )
  
  #public function
  result += %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "public function" "#{project_path}" )
  
  #result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "function" "#{project_path}" )

  result.each { |r|
    item = r
    item = item.split(":")[2]
    item = item.sub("\t", "")
    item = item.sub("public function","")
    item = item.sub("public static function","")
    item = item.sub(" ", "")
    item = item.sub("{","")
    item = item.sub("}","")
    display = item.split("(")[0]
    insert = "${1:resource dict}"
    insert = ""
    params = item.split("(")[1].split(",")
    i = 0
    
    params.each {
      |param|
      i = i + 1
      param = param.sub(" ", "")
      param = param.sub(")", "")
      param = param.sub("\t", "")
      param = param.sub("\n", "")
      param = param.sub("$", "")
      insert += "${" + i.to_s() + ":" + param + "}"
      if i < params.length
        insert += ", "
      end
      #print i
      #insert += param + ","
    }
    
    #debug
    #print "{display = '" + display + "'; insert = '(" + insert + ")';})" + "\n"
    
    #print insert
    #print project_path
    
    #insert = "${1:resource dict}, ${2:string word}"
    #print "({display = '" + item + "'; insert = '" + item + "';},)"
    #print item
    #choices += OSX::PropertyList.load("({display = 'complete'; insert = '" + item + "';},)")
    
    begin
    # something potentially bad
      choices += OSX::PropertyList.load("({display = '" + display + "'; insert = '(" + insert + ")';})")
    rescue Exception=>e
      print e
    # handle e
    end
    
    
  	#{display = 'enchant_dict_quick_check'; insert = '(${1:resource dict}, ${2:string word}, ${3:[array &suggestions]})';},
    
    #choices += OSX::PropertyList.load("({display = '" + display + "'; insert = '" + item + "';},)")
    
    #choices += OSX::PropertyList.load("({display = 'concatenatetest'; insert = '';},)")
    
    #print item + "\n"
    }
  #result = result.sub("public function","")
  #result = result.sub("{","")
  #result = result.sub("}","")
  #puts result
  
  #choices += OSX::PropertyList.load("({display = 'concatenatetest'; insert = '';},)")
  
  
  
  TextMate::UI.complete(choices, :initial_filter => ENV['TM_CURRENT_WORD'], :extra_chars => '_')
end