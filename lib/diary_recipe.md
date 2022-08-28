{{PROBLEM}} Multi-Class Planned Design Recipe

1. Describe the Problem
Put or write the user story here. Add any clarifying notes you might have.

    As a user
    So that I can record my experiences (add) - DONE
    I want to keep a regular diary < this would be the main object

    As a user
    So that I can reflect on my experiences (list?) - DONE
    I want to read my past diary entries < diary entries << get the content

    As a user
    So that I can reflect on my experiences in my busy day (suggestion(time)) - DONE
    I want to select diary entries to read based on how much time I have and my reading speed

    As a user
    So that I can keep track of my tasks (show_todolist) - DONE
    I want to keep a todo list along with my diary < todo list

    As a user
    So that I can keep track of my contacts - DONE
    I want to see a list of all of the mobile phone numbers in all my diary entries < list of all mobile phone numbers in the diary entries... an object contacts showing in the diary entries which at the same time are in the main object
    // Empieza por + o por 00? Tiene X dígitos? Empieza por 020/07...? < esto depende de si empieza por + o por 00 > just UK - then +44

    We are looking for a program which the main object is the "Diary" and then it has some objects associated to it:
    - Diary entry < with the title and the contents and its options
    - Taskslist < Just showing a list? We will need add/completed < Task as an object

    DIARY 
    - We need to add diary entries which is another object add(diary_entry//class)
    --> We need to initialize an array []
    - We need to be able to list all the diary entries
    - We initialize a hash for the phone numbers
    and we merge phone numnbers information from the diary entries object
    - Get the best entry based on time of the user (minutes the user has)


    DIARY ENTRIES (2 arguments - title, content)
    - when we initialize them we take the value for the title 
    - we take the value for the content
    - we can make the count of words
    - another method to ID phone numbers - which looks for numbers starting with +44 or 0044 and 10/11 digits long
    phone_list{phone number => 00447498345983498
                entry related to => title} << everytime I add a new entry we scan and add the telephone number to the list

    {"date & title": title of diary entry
    "content": content of diary entry
    "number of words of the entry": Integer with number of words
    }

    TODOLIST (TASK --> another object)
    - add
    - list
    

    TASK
    - hash {task: "this is a task"
    completed?: true/false}
    - completed

2. Design the Class System
Consider diagramming out the classes and their relationships. Take care to focus on the details you see as important, not everything. The diagram below uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com


    ┌──────────────────────────────────────────┐
    │                  DIARY                   │
    │                                          │
    │       initialize (1 array 1 hash)        │
    │      add (takes diary_entry object)      │
    │        list all entries by title         │
    │ list of phone numbers related to entries │
    └──────────┬────────────────────────┬──────┘
               │                        │
 ┌─────────────▼──────────┐             │
 │     DIARY ENTRIES      │             │
 │                        │   ┌─────────▼────────┐
 │ add (title, contents)  │   │     TODOLIST     │
 │         title          │   │                  │
 │        content         │   │add (task  object)│
 │ scan for phone numbers │   │       list       │
 └────────────────────────┘   └─────────┬────────┘
                                        │
                        ┌───────────────▼─────────────┐
                        │         TASK (task)         │
                        │ initialize hash task, false │
                        │         completed?          │
                        └─────────────────────────────┘

        ┌──────────────────────────────────────────┐
        │                  DIARY                   │
        │                                          │
        │          initialize (3 arrays)           │
        │                add_entry                 │
        │                entry_list                │
        │                find entry                │
        │     find_best_entry_for_reading_time     │
        │                 add_task                 │
        │              list_all_tasks              │
        │          list_all_phone_numbers          │
        │                                          │
        └─┬───────────────────┬──────────────────┬─┘
          │                   │                  │
  ┌───────▼───────┐ ┌─────────▼──────────┐ ┌─────▼──────────┐
  │  DiaryEntry   │ │ PhoneNumberScanner │ │   DiaryTask    │
  │               │ │                    │ │                │
  │  initialize   │ │     initialize     │ │   initialize   │
  │  count_words  │ │   add_phone_num    │ │ completed_task │
  │  attr_reader  │ │ scan_phone_numbers │ │  attr_reader   │
  │               │ │     attr_reader    │ │                │
  │               │ │                    │ │                │
  └───────────────┘ └────────────────────┘ └────────────────┘

Also design the interface of each class in more detail.

class Diary
    def initialize
        @diaryentries = []
        @full_phone_list = []
        @tasklist = []
    end

    def add_entry (entry < diaryentry object)
    end

    def entry_list 
        return list of diary entries
    end

    def find_entry (takes two args, number  for index and string for title search)
        return entry to find
    end

    def find_best_entry_for_reading_time(wpm, minutes)
        returns the best entry for the arguments provided
    end

    def add_task
        add a task to the list
    end

    def list_all_tasks
        return a list of all the tasks
    end

    def list_all_numbers
        return a list of phone numbers from the entries
    end
end

class DiaryEntry
    def initialize (takes the content and title)
        @title = title
        @contents = contents
        @totalwords = 0
    end

    def count_words (boolean which indicates if we modified the entry)
        return the number of words
    end

end

class PhoneNumberScanner

    def initialize (takes the text and the keyworkd o statement we associate it to)
        @contents = text
        @association = association
        @phone_list = []
    end

    def add_phone_num(takes the phone)
        formats the telephone number
        links it to the associated word/statement
        add it to the list
    end

    def scan_phone_numbers
        adds phone numbers found to a list
            return phonelist
        end
    end
end    

Class DiaryTask
    def initialize (task)
        task = {"task" => task, "completed" => false}
    end

    def completed
        task["completed"] = true
    end
end

3. Create Examples as Integration Tests
Create examples of the classes being used together in different situations and combinations that reflect the ways in which the system will be used.

# EXAMPLE

# Create a Diary and test with no entries
    diary = Diary.new
    diary.diaryentries => []
    diary.entrylist => Error no entries on the list

# Create entries and test it
    entry1 = DiaryEntry.new(title1, content1)
    entry1.title = title1
    entry1.contents = content1
    entry1.count_words = x
    same with the different entries we would like to test

# Add the entries to the Diary
    We take the same entries as before
    diary.add_entry(entry1, 2, 3...) => entry1, 2, 3...

# Test find entry in empty Diary
    diary = Diary.new
    diary_challenge.find_entry => returns error (empty)

# Test find entry after adding some entries
    diary = Diary.new
    entry = DiaryEntry.new
    diary.add_entryy(entry1, 2, 3)

# Test method to find entry for a reading time with empty Diary
    diary = Diary.new
    diary.find_entry => returns error (empty)

# Test method to find entry with entries
    Same as before, we create the Diary and entries

4. Create Examples as Unit Tests
Create examples, where appropriate, of the behaviour of each relevant class at a more granular level of detail.

# EXAMPLE

# Creates a DiaryEntry
diary_challenge = Diary.new
expect(diary_challenge.diary_entries).to eq ([])
diary_challenge.entry_list => "There are no entries in the Diary"
entry_01 = DiaryEntry.new("Title01", "Contents01 llamé a 00447387472627 y luego a +447383453447")
entry_01.title => "Title01"
entry_01.contents => "Contents01 llamé a 00447387472627 y luego a +447383453447"
entry_01.count_words => 8
entry_02 = DiaryEntry.new("Title02", "Contents02 I'm learning to code at Makers 02038178870 or 07975777666")
entry_02.title => "Title02"
entry_02.contents => "Contents02 I'm learning to code at Makers 02038178870 or 07975777666"
entry_02.count_words => 10
entry_03 = DiaryEntry.new("Title03", "Contents03 I'm adding an entry without any phone number.")
entry_03.title => "Title03"
entry_03.contents => "Contents03 I'm adding an entry without any phone number."
entry_03.count_words => 9
entry_04 = DiaryEntry.new("Title04", "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666")
entry_04.title => "Title04"
entry_04.contents => "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666"
entry_04.count_words => 5
diary_challenge.diary_entries => [entry_01, entry_02, entry_03, entry_04]
# With empty Diary
diary_challenge.find_entry(0, nil) => nil
# With entries
diary_challenge.find_entry(2, nil) => "Contents02 I'm learning to code at Makers 02038178870 or 07975777666"
diary_challenge.find_entry(nil, "Title03") => "Contents03 I'm adding an entry without any phone number."
diary_challenge.find_entry(33, nil) => nil
diary_challenge.find_entry(nil, "Trittle02") => nil
diary_challenge.find_entry(nil, nil) => nil
# Empty Diary
diary_challenge.find_best_entry_for_reading_time(5, 5) => nil
# With entries
diary_challenge.find_best_entry_for_reading_time(5, 1) => "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666"
diary_challenge.find_best_entry_for_reading_time(5, 2) => "Contents02 I'm learning to code at Makers 02038178870 or 07975777666"
diary_challenge.find_best_entry_for_reading_time(1, 1)) => nil
# Empty Diary
diary_challenge.list_all_phone_numbers => []
# With entries
diary_challenge.list_all_phone_numbers).to eq ([{"phone_number"=>"+447387472627", "associated_to"=>"Title01"}, {"phone_number"=>"+447383453447", "associated_to"=>"Title01"}, {"phone_number"=>"+442038178870", "associated_to"=>"Title02"}, {"phone_number"=>"+447975777666", "associated_to"=>"Title02"}, {"phone_number"=>"+441623432115", "associated_to"=>"Title05"}, {"phone_number"=>"+441992132112", "associated_to"=>"Title05"}])
# No entries
diary_challenge.list_all_tasks => []
diary_challenge.add_task("") => nil
diary_challenge.list_all_tasks => []
# With entries
diary_challenge.add_task("Sleep 8 hours")
diary_challenge.list_all_tasks => diary_challenge.tasklist
diary_challenge.add_task("End the lesson before Friday")
diary_challenge.add_task("Finish code for lesson 09")
diary_challenge.add_task("Read and finish paperwork from the employer")
diary_challenge.add_task("Make food for the week")
diary_challenge.list_all_tasks => diary_challenge.tasklist
diary_challenge.list_all_tasks[0].task["task"] => "End the lesson before Friday"
diary_challenge.list_all_tasks[3].task["task"] => "Make food for the week"


5. Implement the Behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.