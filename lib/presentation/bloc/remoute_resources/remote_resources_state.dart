part of 'remote_resources_bloc.dart';

sealed class RemoteResourcesState extends Equatable {
  const RemoteResourcesState();
  
  @override
  List<Object?> get props => [];
}

final class RemoteResourcesLoading extends RemoteResourcesState {}

final class RemoteResourcesLoaded extends RemoteResourcesState {
  final Map<String, dynamic>? mapResources;

  const RemoteResourcesLoaded({
    required this.mapResources,
  });

  @override
  List<Object?> get props => [mapResources];
}

final class RemoteResourcesError extends RemoteResourcesState {
  final Object? error;

  const RemoteResourcesError({
    required this.error
  });

  @override
  List<Object?> get props => [error];  
}

