module SubjectsHelper

    def join_subject_group_name(subject)
        
        if subject.joining_subject_group_judge then
            subject_group = subject.joining_subject_group
            return subject_group.name
        else
            return "-"
        end
    end

end