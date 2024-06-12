import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nevesomiy/domain/domain.dart';

part 'cloud_messaging_event.dart';
part 'cloud_messaging_state.dart';


class CloudMessagingBloc extends Bloc<CloudMessagingEvent, CloudMessagingState> {
  final FireBaseNotificationService service; 
  final CacheService cacheService;
  CloudMessagingBloc() 
     :service = FireBaseNotificationService.instance,
     cacheService = CacheService.instance,
     super(CloudMessagingLoading()) {
      on<CloudMessagingEvent>(_onEvent);
     } 

  Future<void>? _onEvent(
    CloudMessagingEvent event,
    Emitter<CloudMessagingState> emit,
  ) {
    if (event is CloudMessagingRun) return _onEnable(event, emit);
    return null;
  }

  Future<void> _onEnable(
    CloudMessagingRun event,
    Emitter<CloudMessagingState> emit
  ) async {
    
    final isEnabled = event.isEnabled ?? await cacheService.getMessagesFlag();
    try {
      if(isEnabled) {
        await Future.wait([
        service.editMessagePermissions(),
        service.enableFirebaseMessaging(),
        // service.enableFirebaseInAppMessaging(),
        emit.forEach<RemoteMessage>(
          service.myOutAppStream, 
          onData: (data) =>  CloudMessagingReceive(
            data: data
          ) 
        )]);
      } else {
        await service.disableFirebaseMessaging();
      }
      emit(CloudMessagingActivation(isEnabled: isEnabled));
    } on FirebaseException catch (e) {
      emit(CloudMessagingError(error: e));
    }
  }
}
