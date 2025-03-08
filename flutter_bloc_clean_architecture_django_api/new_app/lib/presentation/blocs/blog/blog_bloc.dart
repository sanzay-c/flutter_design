import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:new_app/domian/entities/blog_entity.dart';
import 'package:new_app/domian/usecases/delete_blog.dart';
import 'package:new_app/domian/usecases/get_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final GetBlog blogs;
  final DeleteBlog deleteBlog;

  BlogBloc({
    required this.blogs,
    required this.deleteBlog,
  }) : super(BlogInitial()) {
    on<FetchBlogEvent>(_onFetchBlogEvent);
    on<DeleteBlogPostEvent>(_onDeleteBlogPostEvent);
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

  FutureOr<void> _onDeleteBlogPostEvent(DeleteBlogPostEvent event, Emitter<BlogState> emit) async {
    if (state is BlogLoaded){
      try {
        await deleteBlog(event.id);
        final currentState = state as BlogLoaded;
        final updatedBlogs = currentState.blogs.where((blog) => blog.id != event.id).toList();
        emit(BlogLoaded(blogs: updatedBlogs));
      } catch (e) {
        emit(BlogError(errorMessage: "Failed to delete the blog post: $e"));
      }
    }
  }
}