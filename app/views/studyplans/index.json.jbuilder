json.array!(@studyplans) do |studyplan|
    json.id studyplan.id
    json.title Subject.find(studyplan.subject_id).subject_name
    # json.start studyplan.start_daytime
    json.start Studyplan.format_change_datetime_ymd_fullcalendar(studyplan.start_daytime)
    # json.end studyplan.end_daytime 
    json.url edit_studyplan_path(studyplan.id)

end