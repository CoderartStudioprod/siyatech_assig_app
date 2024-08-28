import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Model/post.dart';
import '../repositories/hacker_news_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final HackerNewsRepository repository;
  List<int> _ids = [];
  List<Post> allPosts = [];
  int _currentIndex = 0;
  static const _limit = 10;

  PostBloc({required this.repository}) : super(PostInitial()) {
    on<PostLoadRequested>(_onPostLoadRequested);
  }

  Future<void> _onPostLoadRequested(
      PostLoadRequested event, Emitter<PostState> emit) async {
    try {
      if (_ids.isEmpty) {
        _ids = await repository.fetchTopStoryIds();
      }

      final endIndex = (_currentIndex + _limit < _ids.length)
          ? _currentIndex + _limit
          : _ids.length;
      final idsToFetch = _ids.sublist(_currentIndex, endIndex);

      final posts = <Post>[];
      for (final id in idsToFetch) {
        final post = await repository.fetchPost(id);
        allPosts.add(post);
      }

      _currentIndex = endIndex;

      emit(PostLoadSuccess(
          posts: allPosts, hasReachedMax: _currentIndex >= _ids.length));
    } catch (e) {
      emit(PostLoadFailure(error: e.toString()));
    }
  }
}
