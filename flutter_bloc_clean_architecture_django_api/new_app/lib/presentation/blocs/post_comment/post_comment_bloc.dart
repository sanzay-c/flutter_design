import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_app/domian/entities/blog_comment_entity.dart';
import 'package:new_app/domian/usecases/post_comment.dart';

part 'post_comment_event.dart';
part 'post_comment_state.dart';

class PostCommentBloc extends Bloc<PostCommentEvent, PostCommentState> {
  final PostComment postComment;

  PostCommentBloc({required this.postComment}) : super(PostCommentInitial()) {
    on<BlogPostCommentEvent>(_onBlogPostCommentEvent);
  }

  FutureOr<void> _onBlogPostCommentEvent(BlogPostCommentEvent event, Emitter<PostCommentState> emit) async {
    try {
      emit(PostCommentLoading());
      final createdComment = await postComment(event.postComment);
      emit(PostCommentSuccess(postComment: createdComment));

      // Use the context passed in the event
    } catch (e) {
      emit(PostCommentError(errorMessage: "Failed to post comment: $e"));
    }
  }
}
