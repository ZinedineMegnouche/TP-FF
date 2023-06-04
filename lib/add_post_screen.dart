import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_firebase/data_source/firestore_posts_data_source.dart';
import 'package:tp_flutter_firebase/feed_screen.dart';
import 'package:tp_flutter_firebase/post_bloc/post_bloc.dart';
import 'package:tp_flutter_firebase/repository/posts_repository.dart';

import 'Model/post_model.dart';

class AddPostScreen extends StatefulWidget {
  static const String routeName = '/AddPostScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un post"),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Titre'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(onPressed: _addPost, child: const Text("Tweeter !"),),
          )
        ],
      ),
    );
  }


  bool isFieldsOk(){
    if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
      return true;
    }
    return false;
  }

  void _addPost(){
    if (isFieldsOk()){
      final post = Post(title: titleController.text, description: descriptionController.text);
      //RepositoryProvider.of<PostsRepository>(context).addPost(post);
      BlocProvider.of<PostBloc>(context).add(AddPost(post));
      //BlocProvider.of<PostBloc>(context).add(GetPosts());
      FeedScreen.navigateTo(context);
    }else {
      showDialog(context: context, builder: (BuildContext context){
        return  AlertDialog(title: const Text("Champs manquants"),actions: [
          ElevatedButton(onPressed: () {
          Navigator.pop(context);
          },
              child: const Center(child: Text('OK')))
        ],);
      });
    }

  }
}

