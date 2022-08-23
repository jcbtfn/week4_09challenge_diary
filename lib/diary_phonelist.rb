class PhoneNumberScanner

    def initialize(text, association)
        @contents = text
        @title = association
        @phone_list = []
    end

    def add_phone_num(string)
        @phone_list << {
            "phone_number" => ("+44" + string[-10..-1]), 
            "associated_to" => @title
        }
    end

    def scan_phone_numbers #UK edition
        @contents.split(/[^+0-9]/).each do |string|
            if ((string[0..3] == "0044") && (string.length == 14)) ||
            ((string[0..2] == "+44") && (string.length == 13)) ||
            ["01", "02", "07"].include?(string[0..1]) && (string.length == 11)
                add_phone_num(string)
            end
        end
        return @phone_list
    end
    
    attr_reader :phone_list

end