import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_firebase/add_post_screen.dart';
import 'package:tp_flutter_firebase/data_source/firestore_posts_data_source.dart';
import 'package:tp_flutter_firebase/detail_post_screen.dart';
import 'package:tp_flutter_firebase/post_bloc/post_bloc.dart';
import 'package:tp_flutter_firebase/repository/posts_repository.dart';

class FeedScreen extends StatelessWidget {
  static const String routeName = '/FeedScreen';

  //static const String routeName = '/CartScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        repository: RepositoryProvider.of<PostsRepository>(context),
      )..add(
          GetPosts(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tweetos"),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
          switch (state.status) {
            case PostsStatus.initial:
              {
                return const SizedBox();
              }
            case PostsStatus.loading:
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            case PostsStatus.error:
              {
                return const Center(
                  child: Text("Error"),
                );
              }
            case PostsStatus.updated:
              {
                print("updated");
                return Text("Updated");
              }
            case PostsStatus.success:
              {
                final posts = state.posts;
                if (posts.isEmpty) {
                  return const Center(
                    child: Text("Rien dans votre fil d'actualité"),
                  );
                }
                return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.description),
                          onTap:() => DetailPostScreen.navigateTo(context, post),
                          );
                    });
              }
          }
        }),
        floatingActionButton: FloatingActionButton(
            tooltip: 'Tweeter',
            onPressed: () {
              AddPostScreen.navigateTo(context);
            },
            child: const Icon(
              CupertinoIcons.add,
            )),
      ),
    );
  }
}
