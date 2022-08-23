class DiaryTask

    def initialize(task)
        @task = {
            "task" => task,
            "completed" => false
        }
    end

    def completed_task
        @task["completed"] => true
    end

    attr_reader :task

end


