import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_app/data/datasources/blog_remote_data_sources.dart';
import 'package:new_app/data/repositories/blog_repository_impl.dart';
import 'package:new_app/domian/usecases/post_comment.dart';
import 'package:new_app/presentation/blocs/blog_comments/blog_comment_bloc.dart';
import 'package:new_app/presentation/blocs/post_comment/post_comment_bloc.dart';
import 'package:new_app/presentation/screens/add_comment_screen.dart';

class UserComments extends StatefulWidget {
  const UserComments({super.key, required this.id});

  final int id;

  @override
  State<UserComments> createState() => _UserCommentsState();
}

class _UserCommentsState extends State<UserComments> {
  @override
  void initState() {
    super.initState();
    context.read<BlogCommentBloc>().add(FetchBlogCommentEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    // Use a BlocListener to listen for state changes in the PostCommentBloc and trigger a refresh in the BlogCommentBloc.
    return BlocBuilder<BlogCommentBloc, BlogCommentState>(
      builder: (context, state) {
        if (state is BlogCommentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is BlogCommentError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is BlogCommentLoaded) {
          final blogComments = state.blogComment;

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'COMMENTS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                blogComments.isEmpty
                    ? Text(
                        "Be the first to comment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: const Color.fromARGB(157, 0, 0, 0)),
                      )
                    : ListView.builder(
                        itemCount: blogComments.length,
                        shrinkWrap: true, // Use shrinkWrap for list in Column
                        physics:
                            NeverScrollableScrollPhysics(), // Disable scrolling in ListView
                        itemBuilder: (context, index) {
                          final blogComment = blogComments[index];

                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Card(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                blogComment.text,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                context
                                                    .read<BlogCommentBloc>()
                                                    .add(DeleteBlogCommentEvent(
                                                        blogPostId: widget.id,
                                                        commentId: blogComment
                                                            .id)); // Delete the comment
                                              },
                                              icon: Icon(Icons.delete,
                                                  color: const Color.fromARGB(
                                                      119, 0, 0, 0)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "By ${blogComment.name}",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    151, 0, 0, 0),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Created at:",
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        151, 0, 0, 0),
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat(
                                                          'yyyy-MM-dd hh:mm a')
                                                      .format(blogComment
                                                          .createdAt
                                                          .toLocal()),
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        151, 0, 0, 0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => PostCommentBloc(
                            postComment: PostComment(
                              postRepository: BlogRepositoryImpl(
                                dataSources: BlogRemoteDataSources(),
                              ),
                            ),
                          ),
                          child: AddCommentScreen(blogPostId: widget.id),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors
                    //     .transparent, // Transparent background
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20), // Button padding
                    elevation: 0, // No shadow to maintain transparency
                    side: BorderSide(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 2), // Border color and width
                  ),
                  child: Text(
                    'Add Comments',
                    style: TextStyle(
                        fontSize: 13, // Text size
                        fontWeight: FontWeight.bold,
                        color: Colors.black // Text weight
                        ),
                  ),
                )
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
