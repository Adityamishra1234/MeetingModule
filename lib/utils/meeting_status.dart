enum MeetingStatus { Started, Ended, NotStarted }

getMeetingStatus({required bool meetingStarted, required bool meetingEnded}) {
  if (meetingStarted == false && meetingEnded == false)
    return MeetingStatus.NotStarted;
  else if (meetingStarted == true && meetingEnded == false)
    return MeetingStatus.Started;
  else if (meetingStarted == true && meetingEnded == true)
    return MeetingStatus.Ended;
}
