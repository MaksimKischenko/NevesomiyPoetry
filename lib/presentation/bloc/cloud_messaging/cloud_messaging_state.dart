part of 'cloud_messaging_bloc.dart';

sealed class CloudMessagingState extends Equatable {
  const CloudMessagingState();
  
  @override
  List<Object?> get props => [];
}


final class CloudMessagingLoading extends CloudMessagingState {}

final class CloudMessagingActivation extends CloudMessagingState {
  final bool isEnabled;

  const CloudMessagingActivation({
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [isEnabled];
}

final class CloudMessagingReceive extends CloudMessagingState {
  final RemoteMessage data;

  const CloudMessagingReceive({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

