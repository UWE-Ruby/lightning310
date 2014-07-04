module TopicsHelper
  def get_student_name_for topic
    return "unknown" if topic.student.nil?
    topic.student.name
  end
end
