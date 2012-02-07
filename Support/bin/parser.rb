class Parser
  
  def self.find_classes(path, keyword)
    #result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "/class (.*)#{keyword}{/" "#{path}" )
    #result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git '^class [A-Za-z]#{keyword}' "#{path}" )
    #result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git 'class ([a-z,A-Z])#{keyword}([a-z,A-Z])' "#{path}" )
    classes = []
    result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git 'class #{keyword}.*' "#{path}" ).split("\n")
    
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
    
    return classes;
  end
  
  def self.find(path, pattern)
    return result = %x( grep -Rni --include=\*.php --exclude=.svn --exclude=.git "#{pattern}" "#{path}" ).split("\n")
  end
  
  def self.find_constants(path, keyword)
    constants = []
    #pattern = "define\((.*)\,";
    pattern = "define.*(.*" + keyword;
    result = Parser.find(path, pattern)
    
    result.each { |r|
      item = r
      
      item = r.split(":")[2]
      item = item.gsub(%r{'|define.*\(|\"|\t| }, "")
      item = item.split(",")[0]
      #item = item.sub("define(", "")
      
      item = item.sub("\t", "")
      item = item.sub("\n", "")
      item = item.sub("\"", "")
      item = item.sub("'", "")
      
      constants.push(item)
    }
    
    return constants
  end
  
  def self.get_file_by_class(path, klass)
    pattern = "class.*" + klass + ".*{"
    file = Parser.find(path, pattern)[0]
    file = file.split(":")[0]
    return file;
  end
  
  def self.parse_function_parameters_to_insert(params)
    #"${" + i.to_s() + ":" + param + "}"
    params = params.gsub(%r{\(|\)}, "")
    puts params
    return params
  end
  
  def self.get_static_functions(path, klass)
    file = Parser.get_file_by_class(path, klass)
    functions = []
    pattern = "public static function.*{";
    result = Parser.find(file, pattern)
    
    result.each { |r|
      item = r
      item = item.gsub(%r{.*public static function| }, "")
      item = item.gsub(%r{\).*}, ")")
      functions.push(item)
    }
    
    return functions
  end
  
  def self.parse_choice(display, insert)
    return "({display = '" + display + "'; insert = '" + insert + "';},)"
    #return "({display = '" + display + "'; insert = '(" + insert + ")';},)"
    
    #choice = "({display = '" + display + "'; insert = '(" + insert + ")';},)"
  end
  
end