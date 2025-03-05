import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_app/domian/entities/blog_comment_entity.dart';
import 'package:new_app/presentation/blocs/post_comment/post_comment_bloc.dart';

class AddCommentScreen extends StatefulWidget {
  const AddCommentScreen({super.key, required this.blogPostId});

  final int blogPostId;

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final _nameController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void postComment(BuildContext context) async {
    // Get the title and content from the text fields
    final name = _nameController.text.trim();
    final comment = _textController.text.trim();
    final formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Validate the input
    if (name.isEmpty || comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Create a new BlogEntity object
    final newBlogComment = BlogCommentEntity(
      id: 0,
      name: name,
      text: comment,
      createdAt: DateTime.parse(formattedDate),
      blogPost: widget.blogPostId,
    );

    // Dispatch the PostBlogEvent to the Bloc
    context.read<PostCommentBloc>().add(
          BlogPostCommentEvent(
            postComment: newBlogComment,
          ),
        );

    // Show success message and pop back
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Posted comment successfully!"),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostCommentBloc, PostCommentState>(
      listener: (context, state) {
        if (state is PostCommentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Posted comment successfully!"),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context); // Navigate back after success
        } else 
        if (state is PostCommentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Comment"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Comment',
                  hintText: 'Enter a comment',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                // This sets the maximum height of the TextField to 5 lines
                maxLines: 2,
                // This sets the minimum height of the TextField to 3 lines
                // minLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  postComment(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 13, horizontal: 32), // Button padding
                  elevation: 15, // No shadow to maintain transparency
                  side: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2), // Border color and width
                ),
                child: Text(
                  'Add Comment',
                  style: TextStyle(
                      fontSize: 15, // Text size
                      fontWeight: FontWeight.bold,
                      color: Colors.black // Text weight
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
