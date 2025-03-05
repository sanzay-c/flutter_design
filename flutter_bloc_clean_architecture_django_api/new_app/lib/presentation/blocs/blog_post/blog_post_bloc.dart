import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_app/domian/entities/blog_entity.dart';
import 'package:new_app/domian/usecases/post_blog.dart';

part 'blog_post_event.dart';
part 'blog_post_state.dart';

class BlogPostBloc extends Bloc<BlogPostEvent, BlogPostState> {
  final PostBlog postBlog;

  BlogPostBloc({required this.postBlog}) : super(BlogPostInitial()) {
    on<PostEvent>(_onPostEvent);
  }

  FutureOr<void> _onPostEvent(PostEvent event, Emitter<BlogPostState> emit) async {
    try {
      emit(BlogPostLoading());
      final createdBlog = await postBlog(event.blogPost);
      emit(BlogPostSuccess(blogPost: createdBlog));
    } catch (e) {
      emit(BlogPostError(errorMessage: "Failed to post blog: $e"));
    }
  }
}
