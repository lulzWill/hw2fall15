class Class

  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s   # make sure it's a string
    attr_reader attr_name        # create the attribute's getter
    attr_reader attr_name+"_history" # create bar_history getter
    self.class_eval %Q{
        def #{attr_name}_history
           @#{attr_name}_history || [nil]
        end

        def #{attr_name}=(value)
            @#{attr_name}_history ||= [nil]
            @#{attr_name}=value
            @#{attr_name}_history << value
        end
    }
  end
end

class Foo
 attr_accessor_with_history :bar
end
f = Foo.new
f.bar = 1
f.bar = 2
print f.bar_history # => if your code works, should be [nil,1,2]
f = Foo.new
print f.bar_history