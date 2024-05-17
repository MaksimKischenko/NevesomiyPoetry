part of 'remote_resources_bloc.dart';

sealed class RemoteResourcesEvent extends Equatable {
  const RemoteResourcesEvent();

  @override
  List<Object> get props => [];
}


final class RemoteResourcesLoad extends RemoteResourcesEvent {
  final bool syncWithFireStore;
  
  const RemoteResourcesLoad({
    required this.syncWithFireStore,
  });
}
