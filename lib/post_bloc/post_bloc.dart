import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:meta/meta.dart';

import '../Model/post_model.dart';
import '../repository/posts_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository repository;

  PostBloc({required this.repository}) : super(PostState()) {

    on<GetPosts>((event, emit) async{
      emit(state.copyWith(status: PostsStatus.loading));
      try {
        final posts = await repository.getPosts();
        emit(state.copyWith(status: PostsStatus.success,posts: posts));
      } catch (e){
        emit(state.copyWith(status: PostsStatus.error,error: e.toString()));
        throw Exception(e);
      }
    });

    on<AddPost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));
      final postAdded = event.post;
      try{
        final post = await repository.addPost(event.post);
        emit(state.copyWith(status: PostsStatus.success,posts: [... state.posts,postAdded]));
      }catch (e){
        emit(state.copyWith(status: PostsStatus.error,error: e.toString()));
        throw Exception(e);
      }
    });

    on<UpdatePost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));
      final postUpdated = event.post;
      try{
        emit(state.copyWith(status: PostsStatus.success));
      }catch (e){
        emit(state.copyWith(status: PostsStatus.error,error: e.toString()));
        throw Exception(e);
      }
    });
  }
}
