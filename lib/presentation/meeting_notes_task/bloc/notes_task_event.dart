part of 'notes_task_bloc.dart';

sealed class NotesTaskEvent extends Equatable {
  const NotesTaskEvent();
}

// enum NotesTypeToShow { open, close, all }

class NotesTaskChangeOpenCloseAllEvent extends NotesTaskEvent {
  int noteType;
  NotesTaskChangeOpenCloseAllEvent(this.noteType);

  @override
  List<Object?> get props => [this.noteType];
}
