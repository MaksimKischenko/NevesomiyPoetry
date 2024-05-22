import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    if (event is CloudMessagingRun) return _onRun(event, emit);
    return null;
  }

  Future<void> _onRun(
    CloudMessagingRun event,
    Emitter<CloudMessagingState> emit
  ) async {
    await Future.wait([
     service.setupFirebaseMessaging(),
     service.editMessagePermissions(),
     emit.forEach<RemoteMessage>(
      service.myOutAppStream, 
      onData: (data) {
        log('onMessageOpenedApp: $data');
        return CloudMessagingReceived();
      } 
    )]);
  }
}
