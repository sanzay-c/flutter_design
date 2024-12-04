import 'package:api_view_project/models/blog_post_model.dart';
import 'package:api_view_project/services/api_services.dart';
import 'package:flutter/material.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final ApiServices apiServices = ApiServices();
  late Future<BlogPostModel> blogPostData;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void addBlogPost() async {
    // Show the input text in a SnackBar or use it however you want
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      // create the blog post
      BlogPostModel newBlogPost = BlogPostModel(
        id: 0,
        title: titleController.text,
        content: contentController.text,
        createdAt: DateTime.now(),
      );

      try {
        // Call postBlog with the BlogPostModel instance
        setState(() {
          // Pass the newBlogPost
          blogPostData = apiServices.postBlog(newBlogPost);
        });

        // show the snackbar
        blogPostData.then((createPost) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Blog post created: ${createPost.title}'),
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
          content: Text('Please fill in both the title and content'),
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
        title: Text("Add Blog"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter a title',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                hintText: 'Enter a content',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              // This sets the maximum height of the TextField to 5 lines
              maxLines: 7,
              // This sets the minimum height of the TextField to 3 lines
              // minLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addBlogPost,
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
                'Add Blog',
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
