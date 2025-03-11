import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_app/data/datasources/blog_remote_data_sources.dart';
import 'package:new_app/data/repositories/blog_repository_impl.dart';
import 'package:new_app/domian/usecases/delete_blog_comment.dart';
import 'package:new_app/domian/usecases/get_comment.dart';
import 'package:new_app/domian/usecases/post_blog.dart';
import 'package:new_app/presentation/blocs/blog/blog_bloc.dart';
import 'package:new_app/presentation/blocs/blog_comments/blog_comment_bloc.dart';
import 'package:new_app/presentation/blocs/blog_post/blog_post_bloc.dart';
import 'package:new_app/presentation/screens/add_blog_screen.dart';
import 'package:new_app/presentation/screens/edit_blog_screen.dart';
import 'package:new_app/presentation/widgets/user_comments.dart';

class BlogList extends StatefulWidget {
  const BlogList({super.key});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  void _showComments(int postId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => BlogCommentBloc(
              blogComment: GetComment(
                commentrepository: BlogRepositoryImpl(
                  dataSources: BlogRemoteDataSources(),
                ),
              ),
              deleteBlogComment: DeleteBlogComment(
                blogRepositoryDeleteComment: BlogRepositoryImpl(
                  dataSources: BlogRemoteDataSources(),
                ),
              ),
            ),
        child: UserComments(
          id: postId,
        ),
      ),
    );
  }

  // Add the refresh logic
  Future<void> _refresh() async {
    context.read<BlogBloc>().add(FetchBlogEvent());
  }

  void _showDeleteDialog(BuildContext context, int blogPostId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // here context is changed into dialogContext because is used everywhere so it was no executing properly
        return AlertDialog(
          title: Text("Are you sure you want to delete this ?."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(119, 0, 0, 0),
              ),
              child: Text(
                'No',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<BlogBloc>()
                    .add(DeleteBlogPostEvent(id: blogPostId));
                Navigator.of(dialogContext).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Blog Deleted Successfully"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(119, 0, 0, 0),

              ),
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogInitial) {
            context.read<BlogBloc>().add(FetchBlogEvent());
          } else if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is BlogLoaded) {
            final blogs = state.blogs;

            return RefreshIndicator(
              //The RefreshIndicator in Flutter is a widget that provides a "pull to refresh"
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  final blog = blogs[index];

                  return Padding(
                    padding: EdgeInsets.all(6),
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.black)),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    blog.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // context.read<BlogBloc>().add(
                                        //     DeleteBlogPostEvent(id: blog.id));
                                        _showDeleteDialog(context, blog.id);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color:
                                            const Color.fromARGB(119, 0, 0, 0),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        final parentContext = context;

                                        // Navigate to the edit screen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider.value(
                                              value: parentContext
                                                  .read<BlogBloc>(),
                                              child: EditBlogScreen(blog: blog),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color:
                                            const Color.fromARGB(119, 0, 0, 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(blog.content, style: TextStyle(fontSize: 14)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Created at:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      DateFormat('yyyy-MM-dd hh:mm:ss a')
                                          .format(
                                        blog.createdAt.toLocal(),
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed:
                                      //  _showComments,
                                      () {
                                    _showComments(blog.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // backgroundColor: Colors
                                    //     .transparent, // Transparent background
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // Rounded corners
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 12), // Button padding
                                    elevation:
                                        0, // No shadow to maintain transparency
                                    side: BorderSide(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        width: 2), // Border color and width
                                  ),
                                  child: Text(
                                    'View Comments',
                                    style: TextStyle(
                                        fontSize: 14, // Text size
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black // Text weight
                                        ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BlogPostBloc(
                  postBlog: PostBlog(
                    postRepository: BlogRepositoryImpl(
                      dataSources: BlogRemoteDataSources(),
                    ),
                  ),
                ),
                child: AddBlogScreen(),
              ),
            ),
          );
        },
        elevation: 0,
        backgroundColor: const Color.fromARGB(167, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
          side: BorderSide(
            color: const Color.fromARGB(255, 0, 0, 0),
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
