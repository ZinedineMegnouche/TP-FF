part of 'post_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  updated,
  success,
  error,
}

class PostState {
  final PostsStatus status;
  final List<Post> posts;
  final String? error;

  PostState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.error
});

  PostState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    String? error
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error
    );
  }
}

class PostInitial extends PostState {}
