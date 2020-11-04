module EventHelper
  def can_join?
    event = Event.find(params[:id])

    if Attendance.where(event_id: current_user.id, event_id: event.id).exists?
      return false
    elsif current_user.id == event.organizer_id
      return false
    else
      true
    end
  end

  def registered_users
    @registered_users = []
    attendancees = Attendance.where(event_id: params[:id])
    attendancees.each do |att|
      @registered_users << User.where(id: att)
    end
  end
end
