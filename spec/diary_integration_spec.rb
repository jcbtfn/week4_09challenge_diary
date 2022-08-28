require "diary_superchallenge"
require "diary_entryclass"
require "diary_phonelist"
require "diary_task"

RSpec.describe "Class Diary and all the interactions with other classes" do

    context "When Diary is created and there are no entries" do
        it "#Initialize the Diary, main object on top of the hierarchy" do
            diary_challenge = Diary.new
            expect(diary_challenge).to be_a Diary
            expect(diary_challenge.diary_entries).to eq ([])
        end 
        it "#Call the list of entries in the Diary when is empty" do
            diary_challenge = Diary.new
            expect{diary_challenge.entry_list}.to raise_error ("There are no entries in the Diary")
        end
    end

    context "Create entries to add the main Diary" do
        it "#Creates entry 01 for the diary and check values (includes phone numbers)" do
            entry_01 = DiaryEntry.new("Title01", "Contents01 llamé a 00447387472627 y luego a +447383453447")
            expect(entry_01).to be_a DiaryEntry
            expect(entry_01.title).to eq "Title01"
            expect(entry_01.contents).to eq "Contents01 llamé a 00447387472627 y luego a +447383453447"
            expect(entry_01.count_words).to eq 8
        end
        it "#Creates entry 02 for the diary and check values (includes phone numbers)" do
            entry_02 = DiaryEntry.new("Title02", "Contents02 I'm learning to code at Makers 02038178870 or 07975777666")
            expect(entry_02.title).to eq "Title02"
            expect(entry_02.contents).to eq "Contents02 I'm learning to code at Makers 02038178870 or 07975777666"
            expect(entry_02.count_words).to eq 10
        end
        it "#Creates entry 03 for the diary and check values (without phone numbers)" do
        entry_03 = DiaryEntry.new("Title03", "Contents03 I'm adding an entry without any phone number.")
            expect(entry_03.title).to eq "Title03"
            expect(entry_03.contents).to eq "Contents03 I'm adding an entry without any phone number."
            expect(entry_03.count_words).to eq 9
        end
        it "#Creates entry 04 for the diary and check values (wrong phone numbers format)" do
        entry_04 = DiaryEntry.new("Title04", "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666")
            expect(entry_04.title).to eq "Title04"
            expect(entry_04.contents).to eq "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666"
            expect(entry_04.count_words).to eq 5
        end
    end

    context "Add the entries to the Diary so we can test interaction and new methods" do
        diary_challenge = Diary.new
        entry_01 = DiaryEntry.new("Title01", "Contents01 llamé a 00447387472627 y luego a +447383453447")
        entry_02 = DiaryEntry.new("Title02", "Contents02 I'm learning to code at Makers 02038178870 or 07975777666")
        entry_03 = DiaryEntry.new("Title03", "Contents03 I'm adding an entry without any phone number.")
        entry_04 = DiaryEntry.new("Title04", "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666")
        it "#Adds and check the entries just created to the main Diary" do
            diary_challenge.add_entry(entry_01)
            expect(diary_challenge.diary_entries).to eq ([entry_01])
            diary_challenge.add_entry(entry_02)
            expect(diary_challenge.diary_entries).to eq ([entry_01, entry_02])
            diary_challenge.add_entry(entry_03)
            expect(diary_challenge.diary_entries).to eq ([entry_01, entry_02, entry_03])
            diary_challenge.add_entry(entry_04)
            expect(diary_challenge.diary_entries).to eq ([entry_01, entry_02, entry_03, entry_04])
        end
        it "#Calls the method to check is working" do
            diary_challenge.entry_list
        end
    end

    context "Test method find entry in an empty Diary" do
        diary_challenge = Diary.new
        it "#Returns nil with an empty diary" do
            expect(diary_challenge.find_entry(0, nil)).to eq nil
        end
    end

    context "Find and return entries stored in the main Diary" do
        diary_challenge = Diary.new
        diary_challenge.add_entry(DiaryEntry.new("Title01", "Contents01 llamé a 00447387472627 y luego a +447383453447"))
        diary_challenge.add_entry(DiaryEntry.new("Title02", "Contents02 I'm learning to code at Makers 02038178870 or 07975777666"))
        diary_challenge.add_entry(DiaryEntry.new("Title03", "Contents03 I'm adding an entry without any phone number."))
        diary_challenge.add_entry(DiaryEntry.new("Title04", "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666"))
        it "#Retrieve an entry given a number for index or the title of the entry" do
            expect(diary_challenge.find_entry(2, nil)).to eq "Contents02 I'm learning to code at Makers 02038178870 or 07975777666"
            expect(diary_challenge.find_entry(nil, "Title03")).to eq "Contents03 I'm adding an entry without any phone number."
        end 
        it "#Returns nil and error message if there is no entry or arguments are wrong" do
            expect(diary_challenge.find_entry(33, nil)).to eq nil
            expect(diary_challenge.find_entry(nil, "Trittle02")).to eq nil
            expect(diary_challenge.find_entry(nil, nil)).to eq nil
        end
    end

    context "Test method find_best_entry_for_reading_time in an empty Diary" do
        diary_challenge = Diary.new
        it "#Returns nil with an empty diary" do
            expect(diary_challenge.find_best_entry_for_reading_time(5, 5)).to eq nil
        end
    end

    context "Find the best entry for a given time and the words per minute a user is able to read" do
        diary_challenge = Diary.new
        diary_challenge.add_entry(DiaryEntry.new("Title01", "Contents01 llamé a 00447387472627 y luego a +447383453447"))
        diary_challenge.add_entry(DiaryEntry.new("Title02", "Contents02 I'm learning to code at Makers 02038178870 or 07975777666"))
        diary_challenge.add_entry(DiaryEntry.new("Title03", "Contents03 I'm adding an entry without any phone number."))
        diary_challenge.add_entry(DiaryEntry.new("Title04", "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666"))
        it "#Retrieve an entry given a number for index or the title of the entry" do
            expect(diary_challenge.find_best_entry_for_reading_time(5, 1)).to eq "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666"
            expect(diary_challenge.find_best_entry_for_reading_time(5, 2)).to eq "Contents02 I'm learning to code at Makers 02038178870 or 07975777666"
            expect(diary_challenge.find_best_entry_for_reading_time(1, 1)).to eq nil
        end 
        
    end

    context "With an empty Diary Class, Test PhoneNumberScanner Class" do
        diary_challenge = Diary.new
        it "#Returns nil with an empty diary and an error message" do
            expect(diary_challenge.list_all_phone_numbers).to eq []
        end
    end

    context "Test PhoneNumberScanner Class interaction with the main Diary Class - one entry" do
        diary_challenge = Diary.new
        diary_challenge.add_entry(DiaryEntry.new("Title01", "Contents01 llamé a 00447387472627 y luego a +447383453447."))
        it "#Returns nil with an empty diary and an error message" do
            expect(diary_challenge.list_all_phone_numbers).to eq ([{"phone_number"=>"+447387472627", "associated_to"=>"Title01"}, 
                {"phone_number"=>"+447383453447", "associated_to"=>"Title01"}])
        end
    end

    context "Test PhoneNumberScanner Class interaction with the main Diary Class - multiple entries" do
        diary_challenge = Diary.new
        diary_challenge.add_entry(DiaryEntry.new("Title01", "Contents01 llamé a 00447387472627 y luego a +447383453447."))
        diary_challenge.add_entry(DiaryEntry.new("Title02", "Contents02 I'm learning to code at Makers 02038178870 or 07975777666."))
        diary_challenge.add_entry(DiaryEntry.new("Title03", "Contents03 I'm adding an entry without any phone number."))
        diary_challenge.add_entry(DiaryEntry.new("Title04", "Contents04 004473A7472627 +44738LL53447 0205538178870 17975777666."))
        diary_challenge.add_entry(DiaryEntry.new("Title05", "Contents05 I am trying other numbers as 01623432115 or +441992132112."))
        it "#Returns nil with an empty diary and an error message" do
            expect(diary_challenge.list_all_phone_numbers).to eq ([{"phone_number"=>"+447387472627", "associated_to"=>"Title01"}, 
                {"phone_number"=>"+447383453447", "associated_to"=>"Title01"}, 
                {"phone_number"=>"+442038178870", "associated_to"=>"Title02"}, 
                {"phone_number"=>"+447975777666", "associated_to"=>"Title02"}, 
                {"phone_number"=>"+441623432115", "associated_to"=>"Title05"}, 
                {"phone_number"=>"+441992132112", "associated_to"=>"Title05"}])
        end
    end

    context "Test DiaryTask Class interaction with the main Diary Class - empty values" do
        diary_challenge = Diary.new
        it "#When calling the list without entries" do
            expect(diary_challenge.list_all_tasks).to eq []
        end

        it "#When trying to add an empty task" do
            expect(diary_challenge.add_task("")).to eq nil
            expect(diary_challenge.list_all_tasks).to eq []
        end        
    end

    context "Test DiaryTask Class interaction with the main Diary Class - one entry" do
        diary_challenge = Diary.new
        diary_challenge.add_task("Sleep 8 hours")
        it "#When calling the list with entries added before" do  
            expect(diary_challenge.list_all_tasks).to eq diary_challenge.tasklist
        end      
    end

    context "Test DiaryTask Class interaction with the main Diary Class" do
        diary_challenge = Diary.new
        diary_challenge.add_task("End the lesson before Friday")
        diary_challenge.add_task("Finish code for lesson 09")
        diary_challenge.add_task("Read and finish paperwork from the employer")
        diary_challenge.add_task("Make food for the week")
        it "#When calling the list with entries added before" do  
            expect(diary_challenge.list_all_tasks).to eq diary_challenge.tasklist
            expect(diary_challenge.list_all_tasks[0].task["task"]).to eq "End the lesson before Friday"
            expect(diary_challenge.list_all_tasks[3].task["task"]).to eq "Make food for the week"
        end      
    end

end