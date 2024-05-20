import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevesomiy/domain/domain.dart';

part 'remote_resources_event.dart';
part 'remote_resources_state.dart';

class RemoteResourcesBloc extends Bloc<RemoteResourcesEvent, RemoteResourcesState> {
  final FireStoreService fireStoreservice;
  final CacheService cacheService;
  
  RemoteResourcesBloc() :
    fireStoreservice = FireStoreService.instance,
    cacheService = CacheService.instance, 
    super(RemoteResourcesLoading()) {
      on<RemoteResourcesEvent>(_onEvent);
  }

  Map<String, dynamic>? mapLinks;

   Future<void>? _onEvent(
    RemoteResourcesEvent event,
    Emitter<RemoteResourcesState> emit,
  ) {
    if (event is RemoteResourcesLoad) return _onLoad(event, emit);  
    return null;
  }    

  Future<void> _onLoad(
    RemoteResourcesLoad event,
    Emitter<RemoteResourcesState> emit
  ) async {

    emit(RemoteResourcesLoading());
    
    // if(event.syncWithFireStore) {
    //   final result = await fireStoreservice.getUrlLinks();
    //   result?.fold(
    //     (falure) => emit(RemoteResourcesError(error: falure.message)), 
    //     (right) {
    //       mapLinks = right.data()?.map((key, value) {
    //         value as DocumentReference<Map<String, dynamic>>;
    //         return MapEntry(
    //           key, 
    //           value.path.replaceAll('https:/', 'https://'),
    //         );
    //       });
    //       cacheService.saveLinks(mapLinks); 
    //     }
    //   );
    // } else {
    //   mapLinks = cacheService.getLinks();
    // }
    // emit(RemoteResourcesLoaded(
    //   mapResources: mapLinks,
    // ));
  }
}

