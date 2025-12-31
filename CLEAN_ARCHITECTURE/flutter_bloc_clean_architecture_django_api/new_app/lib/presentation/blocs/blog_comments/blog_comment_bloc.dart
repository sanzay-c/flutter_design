import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_app/domian/entities/blog_comment_entity.dart';
import 'package:new_app/domian/usecases/get_comment.dart';

part 'blog_comment_event.dart';
part 'blog_comment_state.dart';

class BlogCommentBloc extends Bloc<BlogCommentEvent, BlogCommentState> {
  final GetComment blogComment;

  BlogCommentBloc({required this.blogComment}) : super(BlogCommentInitial()) {
    on<FetchBlogCommentEvent>(_onFetchBlogCommentEvent);
    on<AddBlogCommentEvent>(_onAddBlogCommentEvent);
  }

  FutureOr<void> _onFetchBlogCommentEvent(
      FetchBlogCommentEvent event, Emitter<BlogCommentState> emit) async {
    try {
      emit(BlogCommentLoading());
      final blogComments = await blogComment.call(event.id);
      emit(BlogCommentLoaded(blogComment: blogComments));
    } catch (e) {
      emit(
        BlogCommentError(
          errorMessage:
              "There is some error in the blog comment state management",
        ),
      );
    }
  }

  FutureOr<void> _onAddBlogCommentEvent(AddBlogCommentEvent event, Emitter<BlogCommentState> emit) async {
    if (state is BlogCommentLoaded) {
      final currentState = state as BlogCommentLoaded;
      final updatedComments = List<BlogCommentEntity>.from(currentState.blogComment)..add(event.comment);
      emit(BlogCommentLoaded(blogComment: updatedComments));
    }
  }
}
