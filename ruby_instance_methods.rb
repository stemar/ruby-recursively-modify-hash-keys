# Include instance methods to Ruby core
#
# @example Print a hash with symbolized keys
#   puts [{"a"=>"a", "b"=>{"c"=>"c", :d=>"d"}}].keys_to_symbol
#   # => [{:a=>"a", :b=>{:c=>"c", :d=>"d"}}]
# @example Print a hash with string keys
#   puts [{:a=>"a", :b=>{"c"=>"c", :d=>"d"}}].keys_to_symbol
#   # => [{"a"=>"a", "b"=>{"c"=>"c", "d"=>"d"}}]
module RubyInstanceMethods
  module StringInstanceMethods
    # Convert any space character and dash into an underscore in a string
    def to_underscore
      self.gsub(/\s|-/, "_")
    end

    # Convert an underscored string to lower case
    def to_underscore_downcase
      self.to_underscore.downcase
    end

    # Convert a lower-cased, underscored string into a symbol
    def to_symbol
      self.to_underscore_downcase.to_sym
    end
  end
  ::String.send :include, StringInstanceMethods

  module SymbolInstanceMethods
    # Convert a symbol into a lower-cased, underscored string
    def to_underscore_downcase
      self.to_s.to_underscore_downcase
    end

    # Convert a symbol into a lower-cased, underscored symbol
    def to_symbol
      # self
      self.to_underscore_downcase.to_sym
    end
  end
  ::Symbol.send :include, SymbolInstanceMethods

  module ObjectInstanceMethods
    # Symbolize the keys recursively in a Hash using `to_sym`
    def keys_to_sym
      recursively_modify_keys(:to_sym)
    end

    # Self-modifying keys_to_sym
    def keys_to_sym!
      replace(self.keys_to_sym)
    end

    # Symbolize the keys recursively in a Hash using `to_symbol`
    def keys_to_symbol
      recursively_modify_keys(:to_symbol)
    end

    # Self-modifying keys_to_symbol
    def keys_to_symbol!
      replace(self.keys_to_symbol)
    end

    # Convert the keys to string recursively in a Hash using `to_underscore_downcase`
    def keys_to_string
      recursively_modify_keys(:to_underscore_downcase)
    end

    # Self-modifying keys_to_string
    def keys_to_string!
      replace(self.keys_to_string)
    end

    private

    def recursively_modify_keys(modifying_method)
      calling_method ||= caller_locations(1,1)[0].label.to_sym
      if is_a? Hash
        inject({}) do |result, (key, value)|
          result[(key.send(modifying_method) rescue key)] = value.send(calling_method) rescue value
          result
        end
      elsif is_a? Array
        map{|value| value.send(calling_method)}
      else
        self
      end
    end
  end
  ::Object.send :include, ObjectInstanceMethods
end