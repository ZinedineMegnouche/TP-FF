import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_firebase/feed_screen.dart';
import 'package:tp_flutter_firebase/post_bloc/post_bloc.dart';

import 'Model/post_model.dart';

class DetailPostScreen extends StatefulWidget {
  final Post post;
  static const String routeName = '/DetailPostScreen';

  static void navigateTo(BuildContext context, Post post) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  const DetailPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.post.title);
    final descriptionController =
        TextEditingController(text: widget.post.description);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            icon: const Icon(CupertinoIcons.pencil_circle),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              readOnly: !isEditing,
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            TextField(
              readOnly: !isEditing,
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            Spacer(),
            if (isEditing)
              ElevatedButton(
                  onPressed: () {
                    final idPost = widget.post.id;
                    final titlePost = titleController.text;
                    final descriptionPost = descriptionController.text;
                    if (titlePost.isNotEmpty && descriptionPost.isNotEmpty){
                      BlocProvider.of<PostBloc>(context).add(
                        UpdatePost(
                          Post(
                              id: idPost,
                              title: titlePost,
                              description: descriptionPost),
                        ),
                      );
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
                  },
                  child: const Center(child: Text('Modifier le post'))),
            const Spacer(),
          ],
        ),
      ),
    );
  }
/*bool isFieldsOk(){
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

  }*/
}
