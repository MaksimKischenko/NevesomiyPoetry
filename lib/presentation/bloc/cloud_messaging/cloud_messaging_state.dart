part of 'cloud_messaging_bloc.dart';

sealed class CloudMessagingState extends Equatable {
  const CloudMessagingState();
  
  @override
  List<Object> get props => [];
}

final class CloudMessagingReceived extends CloudMessagingState {}

final class CloudMessagingLoading extends CloudMessagingState {}