part of 'network_connection_bloc.dart';

sealed class NetworkConnectionEvent extends Equatable {
  const NetworkConnectionEvent();

  @override
  List<Object> get props => [];
}

final class NetworkConnectionRun extends NetworkConnectionEvent {}