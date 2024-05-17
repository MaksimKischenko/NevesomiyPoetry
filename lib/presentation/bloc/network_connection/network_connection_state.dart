part of 'network_connection_bloc.dart';

sealed class NetworkConnectionState extends Equatable {
  const NetworkConnectionState();
  
  @override
  List<Object?> get props => [];
}


final class NetworkConnectionLoading extends NetworkConnectionState {}

final class NetworkConnectionEnabled extends NetworkConnectionState {
  final bool isEnabled;

  const NetworkConnectionEnabled({
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [isEnabled];
}

