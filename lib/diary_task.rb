class DiaryTask

    def initialize(task)
        @task = task
        @completed = false
    end

    def completed_task
        @completed = true
    end

    attr_reader :task, :completed

end


