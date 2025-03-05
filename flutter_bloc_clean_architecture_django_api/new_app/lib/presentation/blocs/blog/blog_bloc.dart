import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
// import 'package:new_app/domian/entities/blog_comment_entity.dart';
import 'package:new_app/domian/entities/blog_entity.dart';
import 'package:new_app/domian/usecases/get_blog.dart';
// import 'package:new_app/domian/usecases/get_comment.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final GetBlog blogs;
  // final GetComment blogComment;

  BlogBloc({
    required this.blogs,
    // required this.blogComment,
  }) : super(BlogInitial()) {
    on<FetchBlogEvent>(_onFetchBlogEvent);
    // on<FetchBlogCommentEvent>(_onFetchBlogCommentEvent);
  }

  FutureOr<void> _onFetchBlogEvent(
      FetchBlogEvent event, Emitter<BlogState> emit) async {
    try {
      emit(BlogLoading());
      final blog = await blogs();
      emit(BlogLoaded(blogs: blog));
    } catch (e) {
      emit(BlogError(
          errorMessage: "There is some error in the state management"));
    }
  }

  // FutureOr<void> _onFetchBlogCommentEvent(
  //     FetchBlogCommentEvent event, Emitter<BlogState> emit) async {
  //   try {
  //     emit(BlogCommentLoading());
  //     final blogComments = await blogComment.call(event.id);
  //     emit(BlogCommentLoaded(blogComment: blogComments));
  //   } catch (e) {
  //     emit(BlogCommentError(
  //         errorMessage:
  //             "There is some error in the blog comment state management"));
  //   }
  // }

}