class Factory

  def self.new(*args, &block)
    
    Class.new do
      args.each do |a|
        attr_accessor a
      end

      define_method :initialize do |*vars|
        puts "You need #{args.size} arguments instead of #{vars.size}" if args.size != vars.size
        vars.each_with_index do |value, index|
          instance_variable_set("@#{args[index]}", value)
        end  
      end

      define_method :[] do |arg|
        case args.class
        when String
          instance_variable_get("@#{arg}")
        when Symbol
          instance_variable_get("@#{arg}")
        when Integer
          instance_variable_get("@#{arg[index]}")
        end  
      end

      define_method :[]= do |arg, value|
        case args.class
        when String
          instance_variable_set("@#{arg}", value)
        when Symbol
          instance_variable_set("@#{arg}", value)
        when Integer
          instance_variable_set("@#{arg[index]}", value)
        end  
      end

      self.class_eval(&block) if block_given? 

    end

  end

end


Cust = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}! You live at #{address}"
  end
end

puts Cust.new("Dave", "123 Main st.").greeting

Customer = Struct.new(:name, :address, :zip) 
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
 
puts joe.zip
puts joe["name"]
puts joe[:address]
puts joe[0]
