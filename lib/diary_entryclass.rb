class DiaryEntry

    def initialize(title, contents) # title, contents are strings
        @title = title
        @contents = contents
        @totalwords = 0
    end

    def count_words(updated = false) # In case I would like to add an edit method in the future
        if (@totalwords == 0 || updated)
            updated != false
            return @totalwords = @contents.split.count
        else
            return @totalwords
        end
    end

    attr_reader :title, :contents, :totalwords

end