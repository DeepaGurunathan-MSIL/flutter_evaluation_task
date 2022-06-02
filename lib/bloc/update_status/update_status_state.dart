
class UpdateStatusState {
}

class UpdateStatusInitState extends UpdateStatusState {}

class UpdateStatusCompletedState extends UpdateStatusState{
  final bool status;
  UpdateStatusCompletedState(this.status);
}