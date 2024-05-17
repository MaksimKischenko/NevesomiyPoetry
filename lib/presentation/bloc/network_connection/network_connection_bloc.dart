import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevesomiy/domain/domain.dart';

part 'network_connection_event.dart';
part 'network_connection_state.dart';

class NetworkConnectionBloc extends Bloc<NetworkConnectionEvent, NetworkConnectionState> {

  final NetworkConnectivityService service;
  NetworkConnectionBloc() 
    : service = NetworkConnectivityService.instance,
     super(NetworkConnectionLoading()) {
      on<NetworkConnectionEvent>(_onEvent);
     } 

  Future<void>? _onEvent(
    NetworkConnectionEvent event,
    Emitter<NetworkConnectionState> emit,
  ) {
    if (event is NetworkConnectionRun) return _onRun(event, emit);
    return null;
  }

  Future<void> _onRun(
    NetworkConnectionRun event,
    Emitter<NetworkConnectionState> emit
  ) async {
    await Future.wait([
     service.initialise(),
     emit.forEach<bool>(
      service.myStream, 
      onData: (isConnected) => NetworkConnectionEnabled(
          isEnabled: isConnected
        )
    )]);
  }
}
