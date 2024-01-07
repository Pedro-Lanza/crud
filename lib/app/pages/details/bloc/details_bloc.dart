import 'package:crud/app/data/providers/details_provider.dart';
import 'package:crud/app/data/providers/post_provider.dart';
import 'package:crud/app/pages/details/bloc/details_event.dart';
import 'package:crud/app/pages/details/bloc/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc({required this.detailsProvider}) : super(LoadingDetails()) {
    on<FetchDetails>(_onFetchDetails);
  }

  final DetailsProvider detailsProvider;

  Future<void> _onFetchDetails(FetchDetails event, Emitter<DetailsState> emit) async {
    emit(LoadingDetails());
    var details = detailsProvider.getByUser(event.user.id!);
    details(
      (l) => emit(ErrorDetails(l)),
      (r) => emit(LoadedDetails(event.user, r)),
    );

    // var posts = postProvider.getByUser(event.user.id!);
    // posts(
    //   (l) => emit(ErrorDetails(l)),
    //   (r) => emit(LoadedDetails(event.user, detail, r)),
    // );
  }
}

class PostsBloc extends Bloc<DetailsEvent, PostsState> {
  PostsBloc({required this.postProvider}) : super(LoadingPosts()) {
    on<FetchPosts>(_onFetchPosts);
    on<AddPost>(_onAddPost);
  }
  final PostProvider postProvider;

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    emit(LoadingPosts());
    var request = postProvider.getByUser(event.user.id!);
    request(
      (l) => emit(ErrorPosts(event.user, l)),
      (r) => emit(LoadedPosts(r, event.user)),
    );
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostsState> emit) async {
    var request = postProvider.addPost(event.post);
    request(
      (l) => emit(ErrorPosts(event.user, l)),
      (r) => add(FetchPosts(event.user)),
    );
  }
}
