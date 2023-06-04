part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class AddPost extends PostEvent{
  final Post post;

  AddPost(this.post);
}

class UpdatePost extends PostEvent{
  final Post post;

  UpdatePost(this.post);
}

class GetPosts extends PostEvent{
  GetPosts();
}
