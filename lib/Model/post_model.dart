import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final id;
  final title;
  final description;

  const Post({
    this.id,
    required this.title,
    required this.description,
});

  Map<String, dynamic> toFirestore(){
    return{
      'Title': title,
      'Description': description
    };
  }
  factory Post.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return Post(
        id: document.id,
        title: data["Title"],
        description: data["Description"]
    );
  }

}