module BulutfonSDK
  module Helpers
    module DataHelper

      ##
      # Convert hash to object
      def convert_to_obj(hash)
        open_struct =  OpenStruct.new
        set_open_struct_variables( open_struct, hash )
        open_struct
      end

      ##
      # Set hash variable to open_struct
      # Recursive method for hash values
      def set_open_struct_variables(open_struct, hash)
        hash.each do |key,value|
          if value.is_a? Hash
            # create new open struct value
            new_open_struct = OpenStruct.new
            open_struct.send("#{key}=", new_open_struct)
            set_open_struct_variables(new_open_struct, value)
          elsif value.is_a? Array
            open_struct.send("#{key}=", value)
            value.each_with_index do |val, index|
              if val.is_a? Hash
                # create new open struct value
                new_open_struct = OpenStruct.new
                # set array index value variable
                value[index] = new_open_struct
                set_open_struct_variables(new_open_struct, val)
              else
                # Do nothing
                # value[index] = val
              end
            end
          else
            open_struct.send("#{key}=", value)
          end
        end
      end

    end
  end
end
