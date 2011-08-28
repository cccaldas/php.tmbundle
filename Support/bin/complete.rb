#!/usr/bin/env ruby

# -wKU


require ENV['TM_SUPPORT_PATH'] + '/lib/osx/plist'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

begin
  choices = []
  
  env_current_word = ENV["TM_CURRENT_WORD"]
  
  def search(word)
    project_path = ENV["TM_PROJECT_DIRECTORY"]
    result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "#{word}" "#{project_path}" )
    return result
  end
  
  def search_in_file(word, file)
    result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "#{word}" "#{file}" )
    return result
  end
  
  def get_classes(word)
    result = search("class " + word)
    classes = []
    result.each { |r|
      item = r
      
      item = r.split(":")[2]
      item = item.sub("class ", "")
      item = item.sub("\t", "")
      item = item.sub("\n", "")
      item = item.sub(" ", "")
      item = item.sub("{", "")
      item = item.split("extends")[0]
      
      classes.push(item)
    }
    return classes
  end
  
  def get_static_methods(_class, word)
    result = search("class " + _class)
    result = result.split(":")[0]
    result = search_in_file("public static function", result)
    #print "result \n"
    #print result + "\n"
    methods = []
    result.each {
      |method|
      method = method.split(":")[1]
      methods.push(parse_method_to_choice(method))
      #method = method.split(":")[2]
      #print method
      #method = method.sub("\t", "")
      #method = method.sub("public function","")
      #method = method.sub("public static function","")
      #method = method.sub(" ", "")
      #method = method.sub("{","")
      #method = method.sub("}","")
    }
    
    #print result
    return methods
  end
  
  def parse_method_to_choice(method)
    method = method.sub("\t", "")
    method = method.sub("public function","")
    method = method.sub("public static function","")
    method = method.sub(" ", "")
    method = method.sub("{","")
    method = method.sub("}","")
    #return method
    
    params = method.split("(")[1].split(",")
    
    display = method.split("(")[0].strip
    insert = ""
    
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
    
    choice = "({display = '" + display + "'; insert = '(" + insert + ")';},)"
    #choice = "({display = '" + display + "'; insert = $0;},)"
    #"({display = '" + _class + "'; insert = $0;},)"
    
    return choice
  end
  
  #classes
  
  
  #print env_current_word + "\n"
  #print ENV["TM_CURRENT_LINE"]
  #print ENV["TM_SCOPE"]
  #print ENV["TM_COLUMN_NUMBER"] + "\n"
  #print ENV["TM_CURRENT_WORD"] + "\n"
  #print ENV["TM_CURRENT_LINE"] + "\n"
  
  
  #statics
  if env_current_word.index("::") != nil
    print "statics \n"
    methods = get_static_methods(env_current_word.split("::")[0], env_current_word.split("::")[1])
    methods.each {
      |method|
      #print method
      choices += OSX::PropertyList.load(method)
    }
  #elsif
   else
     
     #general
     choices += OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/functions.plist'))
     choices += OSX::PropertyList.load(File.read(ENV['TM_BUNDLE_SUPPORT'] + '/syntax.plist'))
     
      #classes
      classes = get_classes(env_current_word)
      classes.each {
        |_class|
        choice = "({display = '" + _class + "'; insert = $0;},)"
        choices += OSX::PropertyList.load(choice)
      }
  end
  
  
  
  
  #result = %x( echo 'hi' )
  #result = %x( grep -E -n -r --include=\*.php --exclude=.svn --exclude=.git "function i\w+\s*\(" . )
  #
  #result.sub("(","")
  #result = %x( ls )
  #result = %x( grep -E -n -r --include=\*.php --exclude=.svn --exclude=.git "public function" . )
  #dom = ‘www.gotripod.com‘
  #@whois = %x[whois #\{dom\}]
  
  #result = result.sub("public function","")
  #result = result.sub("{","")
  #result = result.sub("}","")
  #puts result
  
  #choices += OSX::PropertyList.load("({display = 'concatenatetest'; insert = '';},)")
  
  
  
  #print get_classes("adas")
  
  if env_current_word.index("::") != nil
    env_current_word = ""
  end
  
  TextMate::UI.complete(choices, :initial_filter => env_current_word, :extra_chars => '_')
end
  


def test
  project_path = ENV["TM_PROJECT_DIRECTORY"]
  
  
  #result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "public function" "#\{project_path\}" )
  #print exec("grep -Rni --include=\*.php --exclude=.svn --exclude=.git \"public function\" . ")
  #result = exec("grep -Rni --include=\*.php --exclude=.svn --exclude=.git \"public function\" . ")
  
  #result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "public function" . )
  
  #public static function
  result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "public static function" "#{project_path}" )
  
  #public function
  result += %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "public function" "#{project_path}" )
  
  print ENV["TM_CURRENT_WORD"]
  
  #result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "function" "#{project_path}" )

  result.each { |r|
    item = r
    source = item.split(":")[0]
    source = source.sub(project_path, "")
    #print source
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
      #choices += OSX::PropertyList.load()
      choice = "({display = '" + display + "'; insert = '(" + insert + ")';})"
      #choice = "({display = '" + display + "'; insert = '(" + insert + ")')"
      choices += OSX::PropertyList.load(choice)
      #print choice + "\n"
    rescue Exception=>e
      #print e
      print "\n"
      print choice
      print "\n \n"
    # handle e
    end
    
    
  	#{display = 'enchant_dict_quick_check'; insert = '(${1:resource dict}, ${2:string word}, ${3:[array &suggestions]})';},
    
    #choices += OSX::PropertyList.load("({display = '" + display + "'; insert = '" + item + "';},)")
    
    #choices += OSX::PropertyList.load("({display = 'concatenatetest'; insert = '';},)")
    
    #print item + "\n"
    }
end