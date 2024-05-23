import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nevesomiy/domain/domain.dart';

part 'cloud_messaging_event.dart';
part 'cloud_messaging_state.dart';


class CloudMessagingBloc extends Bloc<CloudMessagingEvent, CloudMessagingState> {
  final FireBaseNotificationService service; 
  CloudMessagingBloc() 
     :service = FireBaseNotificationService.instance,
     super(CloudMessagingLoading()) {
      on<CloudMessagingEvent>(_onEvent);
     } 

  Future<void>? _onEvent(
    CloudMessagingEvent event,
    Emitter<CloudMessagingState> emit,
  ) {
    if (event is CloudMessagingFlag) return _onEnable(event, emit);
    return null;
  }

  Future<void> _onEnable(
    CloudMessagingFlag event,
    Emitter<CloudMessagingState> emit
  ) async {
    try {
      if(event.isEnabled) {
        await Future.wait([
        service.enableFirebaseMessaging(),
        service.editMessagePermissions(),
        emit.forEach<RemoteMessage>(
          service.myOutAppStream, 
          onData: (data) =>  CloudMessagingReceive(
            data: data
          ) 
        )]);
      } else {
        await service.disableFirebaseMessaging();
      }
      emit(CloudMessagingActivation(isEnabled: event.isEnabled));
    } on FirebaseException catch (e) {
      emit(CloudMessagingError(error: e));
    }
  }
}
