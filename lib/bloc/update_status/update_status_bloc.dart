
import 'package:flutter_bloc/flutter_bloc.dart';

import '../update_status/update_status_event.dart';
import '../update_status/update_status_state.dart';


class UpdateStatusBloc extends Bloc<UpdateStatusEvent,UpdateStatusState>
{
  UpdateStatusBloc() : super(UpdateStatusInitState())
  {
    on<UpdateStatusEvent>((event, emit) async {
      if(event is UpdateStatusConfirmEvent) {
        await _statusComplete(emit);
      }  else if(event is UpdateStatusCompleteEvent) {
        await _statusConfirm(emit);
      }
    });
  }
  _statusComplete(Emitter emit) async {
    emit(UpdateStatusCompletedState(false));
  }
  _statusConfirm(Emitter emit) async {
    emit(UpdateStatusCompletedState(true));
  }
}