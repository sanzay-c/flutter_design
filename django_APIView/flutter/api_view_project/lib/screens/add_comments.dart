import 'package:api_view_project/models/blog_comment_model.dart';
import 'package:api_view_project/services/api_services.dart';
import 'package:flutter/material.dart';

class AddComments extends StatefulWidget {
  const AddComments({super.key, required this.blogPostId});

  final int blogPostId;

  @override
  State<AddComments> createState() => _AddCommentsState();
}

class _AddCommentsState extends State<AddComments> {
  final _nameController = TextEditingController();
  final _textController = TextEditingController();

  final ApiServices apiServices = ApiServices();
  late Future<BlogCommentModel> blogComments;

  void addSomeComment() {
    // Show the input text in a SnackBar or use it however you want
    if (_nameController.text.isNotEmpty && _textController.text.isNotEmpty) {
      // create comment
      BlogCommentModel newCommentPost = BlogCommentModel(
        id: 0,
        name: _nameController.text,
        text: _textController.text,
        createdAt: DateTime.now(),
        blogPost: widget.blogPostId,
      );

      try {
        // Call postBlog with the BlogPostModel instance
        setState(() {
          // Pass the newBlogPost
          blogComments = apiServices.postComment(newCommentPost);
        });

        // show the snackbar
        blogComments.then((createPost) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('comment created by: ${createPost.name}'),
              behavior: SnackBarBehavior.floating, // Make the SnackBar floating
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.pop(context);
        }).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
            ),
          );
        });
      } catch (e) {
        throw Exception("Error: $e");
      }
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in both the name and comment'),
          behavior: SnackBarBehavior.floating, // Make the SnackBar floating
          // Optional: Sets duration before disappearing
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Comment',
                hintText: 'Enter a comment',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              // This sets the maximum height of the TextField to 5 lines
              maxLines: 2,
              // This sets the minimum height of the TextField to 3 lines
              // minLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addSomeComment,
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
    );
  }
}
