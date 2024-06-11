part of 'cloud_messaging_bloc.dart';

sealed class CloudMessagingEvent extends Equatable {
  const CloudMessagingEvent();

  @override
  List<Object> get props => [];
}


final class CloudMessagingRun extends CloudMessagingEvent {
  final bool? isEnabled;

  const CloudMessagingRun({
    this.isEnabled,
  });

}
