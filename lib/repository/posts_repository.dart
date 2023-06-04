import 'package:tp_flutter_firebase/data_source/posts_data_source.dart';

import '../Model/post_model.dart';

class PostsRepository{
  final PostsDataSource remoteDataSource;

  PostsRepository({
    required this.remoteDataSource
});
  Future<List<Post>> getPosts() async {
    try {
      final posts = await remoteDataSource.getPosts();
      return posts;
    } catch (e) {
      rethrow;
    }

  }
  Future<void> addPost(Post post) async {
    try {
      final posts = await remoteDataSource.addPosts(post);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePost(Post post) async {
    try {
      final posts = await remoteDataSource.updatePost(post);
    } catch (e) {
      rethrow;
    }
  }
}