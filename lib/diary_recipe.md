{{PROBLEM}} Multi-Class Planned Design Recipe

1. Describe the Problem
Put or write the user story here. Add any clarifying notes you might have.

    As a user
    So that I can record my experiences
    I want to keep a regular diary < this would be the main object

    As a user
    So that I can reflect on my experiences
    I want to read my past diary entries < diary entries << get the content

    As a user
    So that I can reflect on my experiences in my busy day
    I want to select diary entries to read based on how much time I have and my reading speed

    As a user
    So that I can keep track of my tasks
    I want to keep a todo list along with my diary < todo list

    As a user
    So that I can keep track of my contacts
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


    DIARY ENTRIES (3 arguments - title, content, date)
    - when we initialize them we take the value for the title 
    - we take the value for the content
    - we can make the count of words
    - we can also add a date
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

Also design the interface of each class in more detail.

class Diary
    def initialize
        @diaryentries = []
        @phonelist_complete = []
        @tasklist_complete = []
    end

    def add (entry < diaryentry object)
        diaryentries << entry
        phonelist_complete = phonelist_complete.concat(entry.scan_phone_numbers)
    end

    def list_entries 
        return diaryentries
    end

    def show_entry (indexnumber = nil, title = "")
        if indexnumber != nil
            return diaryentries[indexnumber]
        elsif 
            diaryentries.each do |entry|
                if entry.title == title
                    return entry.contents
                end
            end
        end
        return diaryentries
    end

    def suggest_entry(wpm, minutes)
    end

    def tasklist
        return tasklist_complete
    end

    def list_phones
        return phonelist_complete
    end
end

class DiaryEntry
    def initialize
        entryhash = {}
        phonelist_entry = []
    end

    def add (title, contents)
        entryhash["title"] => title
        entryhash["contents"] => contents
        entryhash["num_of_words"] = contents.split.count
    end

    def title
        return entryhash["title"]
    end

    def contents
        return entryhash["contents"]
    end

    def scan_phone_numbers
        entryhash.contents.split.each do |string|
            if ((string[0..3] == "0044" && string.length == 10 then) || (string[0..3] = "+44" && string.length == 11))
                new_contact = {"telephone_number" => string, "entry_related" => entryhash["title"]}
                phonelist << new_contact
            end
            return phonelist
        end
    end
end    

Class TaskList
    def initialize 
        @list_of_tasks = []
    end

    def add(task)
        @list_of_tasks << task
    end

    def list_all_tasks
        return @list_of_tasks
    end
end


Class Task
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

# Create a Diary
my_diary = Diary.new
entry_1 = DiaryEntry.new("18/08/2022 - first", "This is my first entry 00447451716528")
entry_2 = DiaryEntry.new("19/08/2022 - second", "This is another entry which is the second and +447651411529 I don't know what else to write")
my_diary.add(entry_1)
my_diary.add(entry_2)
my_diary.list_entries eq to [entry_1, entry_2]
my_diary.show_entry(1, nil) eq entry_2
my_diary.show_entry(nil, "18/08/2022 - first") eq entry 1
my_diary.suggest_entry (5, 1) eq to entry_1
task01 = Task.new ("finish lesson 09")
task02 = Task.new ("be alive on Friday")
my_diary.tasklist = [task01, task02]
my_diary.listphones = [00447451716528, +447651411529]



# Gets all tracks
library = MusicLibrary.new
track_1 = Track.new("Carte Blanche", "Veracocha")
track_2 = Track.new("Synaesthesia", "The Thrillseekers")
library.add(track_1)
library.add(track_2)
library.all # => [track_1, track_2]

4. Create Examples as Unit Tests
Create examples, where appropriate, of the behaviour of each relevant class at a more granular level of detail.

# EXAMPLE

# Constructs a track
track = Track.new("Carte Blanche", "Veracocha")
track.title # => "Carte Blanche"
Encode each example as a test. You can add to the above list as you go.

5. Implement the Behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.