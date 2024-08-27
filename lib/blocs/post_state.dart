part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoadInProgress extends PostState {}

class PostLoadSuccess extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  const PostLoadSuccess({required this.posts, required this.hasReachedMax});

  @override
  List<Object?> get props => [posts, hasReachedMax];
}

class PostLoadFailure extends PostState {
  final String error;

  const PostLoadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
