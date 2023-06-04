import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp_flutter_firebase/Model/post_model.dart';
import 'package:tp_flutter_firebase/data_source/posts_data_source.dart';

class FirestorePostsDataSource extends PostsDataSource{

  final CollectionReference postsCollection = FirebaseFirestore.instance.collection('Posts');
  @override
  Future<List<Post>> getPosts() async{
    final _db = FirebaseFirestore.instance;
    final snapshot = await _db.collection('Posts').get();
    final postsData = snapshot.docs.map((e) => Post.fromSnapshot(e)).toList();
    for (Post post in postsData){
      print(post.description);
      print(post.title);
    }
    return postsData;
  }

  @override
  Future<void> addPosts(Post post) async {
    try {
      await postsCollection.add(post.toFirestore());
      print("Post Added");
    } catch (error) {
      print("Failed to add post: $error");
    }
  }

  @override
  Future<void> updatePost(Post post) async {
    try {
      await postsCollection
          .doc(post.id)
          .update(post.toFirestore());
    } catch (error) {
      print("Failed to add post: $error");
    }
    throw UnimplementedError();
  }
}