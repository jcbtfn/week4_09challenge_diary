class Diary

    def initialize
        @diary_entries = []
        @full_phone_list = []
        @tasklist = []
    end

    def add_entry (entry)
        entry.count_words
        @diary_entries << entry
        extractphone = PhoneNumberScanner.new(entry.contents, entry.title)
        @full_phone_list.concat(extractphone.scan_phone_numbers)
    end

    def entry_list
        puts "\nList of entries stored in the Diary: "
        puts "**************"
        if @diary_entries != []
            @diary_entries.each_index do |i| 
                puts "[" + i.to_s + "] " + @diary_entries[i].title + (": ") + 
                @diary_entries[i].contents[0..25] + "..."
            end
        else
            puts "There are no entries in the Diary"
        end
        puts "**************"
        puts "End of entries"
    end

    def find_entry (index = nil, title = nil)
        if (index == nil && title != nil)
            index = @diary_entries.bsearch_index {|index| index.title == title}
        end
        if ((index != nil) && (@diary_entries[index.to_i] != nil))
            puts "\n[Located diary entry " + (index+1).to_s + "]: " + 
            @diary_entries[index].title +
            "\n" + @diary_entries[index].contents
            return @diary_entries[index].contents
        else
            puts "\n[!] No task/entry for this value/task, please input the value again."
            return nil
        end
    end

    def find_best_entry_for_reading_time(wpm, minutes)
        puts "\nSuggested reading: "
        puts "**************"
        # can_read = wpm * minutes >>> the words the user can read for the time given
        aux_entry = DiaryEntry.new("","")
        @diary_entries.each_index do |index|
            if ((@diary_entries[index].totalwords <= (wpm * minutes)) && 
                (@diary_entries[index].totalwords > aux_entry.totalwords))
                aux_entry = @diary_entries[index]
            end
        end
        if (aux_entry.title == "" && aux_entry.contents == "")
            puts ("No entry match for the time available, " + 
                        "all the entries require more time to read")
            return nil
        else
            puts ("For a " + minutes.to_s + " minute(s) read, entry suggested is: " + 
            aux_entry.title + "\n" + aux_entry.contents)
            return aux_entry.contents
        end
        puts "**************"
    end

    def new_task(task)
        if [nil, "", " "].include?(task) #(task != nil && task != "" && task != " ")
            puts "Can't add an empty task."
            return nil
        else
            @tasklist << DiaryTask.new(task)
        end
    end

    def list_all_tasks
        puts "\nList of tasks associated to this Diary: "
        puts "**************"
        if (@tasklist == [])
            puts "The list of tasks is empty."
        end
        @tasklist.each_index do |i| 
            puts "Task " + (i + 1).to_s + 
            if @tasklist[i].task["completed"]
                " [completed]"
            else
                " [incompleted]"
            end +
            ": " + @tasklist[i].task["task"]
        end
        puts "**************"
        return @tasklist
    end

# def completed (tasknum = nil, task = "")
#     if ((@list[tasknum.to_i - 1] != nil) && tasknum != nil)
#         return @list.delete_at(tasknum.to_i)
#     elsif @list.include?(task)
#         return @list.delete(task)
#     else
#         return "No task/entry for this value/task, please check again."
#     end
# end

    def list_all_phone_numbers
        puts "\nList of phone numbers found in the Diary entries: "
        puts "**************"
        if @full_phone_list != []
            @full_phone_list.each do |index| 
                puts "Phone number: " + index["phone_number"].to_s +
                " associated to entry " + index["associated_to"]
            end
        else
            puts "List is empty. No phone numbers were detected in the Diary entries."
        end
        puts "**************"
        return @full_phone_list
    end

    attr_reader :diary_entries, :full_phone_list, :tasklist

end