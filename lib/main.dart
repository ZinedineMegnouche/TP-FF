import 'dart:async';
import 'dart:isolate';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_firebase/Model/post_model.dart';
import 'package:tp_flutter_firebase/data_source/firestore_posts_data_source.dart';
import 'package:tp_flutter_firebase/detail_post_screen.dart';
import 'package:tp_flutter_firebase/feed_screen.dart';
import 'package:tp_flutter_firebase/post_bloc/post_bloc.dart';
import 'package:tp_flutter_firebase/repository/posts_repository.dart';
import 'add_post_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);

    runApp(RepositoryProvider(
      create: (context) => PostsRepository(
        remoteDataSource: FirestorePostsDataSource(),
      ),
      child: const MyApp(),
    ));
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
        repository: RepositoryProvider.of<PostsRepository>(context),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tweetor',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const FeedScreen(),
          AddPostScreen.routeName: (context) => const AddPostScreen(),
          FeedScreen.routeName: (context) => const FeedScreen()
        },
        onGenerateRoute: (settings) {
          Widget content = const SizedBox.shrink();

          switch (settings.name) {
            case DetailPostScreen.routeName:
              final arguments = settings.arguments;
              if (arguments is Post) {
                content = DetailPostScreen(post: arguments);
              }
              break;
          }

          return MaterialPageRoute(
            builder: (context) {
              return content;
            },
          );
        },
      ),
    );
  }
}

