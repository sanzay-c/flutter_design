import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_app/domian/entities/blog_entity.dart';
import 'package:new_app/presentation/blocs/blog_post/blog_post_bloc.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void addBlogPost(BuildContext context) async {
    // Get the title and content from the text fields
    final title = titleController.text.trim();
    final content = contentController.text.trim();
    final formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Validate the input
    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Create a new BlogEntity object
    final newBlogPost = BlogEntity(
      id: 0, // The ID will be generated by the server
      title: title,
      content: content,
      createdAt: DateTime.parse(formattedDate),
    );

    // Dispatch the PostBlogEvent to the Bloc
    context.read<BlogPostBloc>().add(PostEvent(blogPost: newBlogPost));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlogPostBloc, BlogPostState>(
      listener: (context, state) {
        if (state is BlogPostSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Blog posted successfully!"),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context); // Navigate back after success
        } else if (state is BlogPostError) {
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  hintText: 'Enter a content',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                // This sets the maximum height of the TextField to 5 lines
                maxLines: 7,
                // This sets the minimum height of the TextField to 3 lines
                // minLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addBlogPost(context);
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
      ),
    );
  }
}
