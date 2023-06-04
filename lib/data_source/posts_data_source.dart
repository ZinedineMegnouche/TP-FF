import 'package:tp_flutter_firebase/Model/post_model.dart';

abstract class PostsDataSource {
  Future<List<Post>> getPosts();
  Future<void> addPosts(Post post);
  Future<void> updatePost(Post post);
}
