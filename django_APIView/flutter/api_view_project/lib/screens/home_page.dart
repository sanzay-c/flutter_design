import 'package:api_view_project/models/blog_post_model.dart';
import 'package:api_view_project/screens/add_blog_page.dart';
import 'package:api_view_project/screens/user_comments.dart';
import 'package:api_view_project/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiServices apiServices = ApiServices();
  late Future<List<BlogPostModel>> blogPostData = apiServices.fetchBlogPost();

  void _showComments(int postId) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => UserComments(postId: postId,)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Post & Comment'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: blogPostData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final List<BlogPostModel> blogData = snapshot.data!;
            return ListView.builder(
              itemCount: blogData.length,
              itemBuilder: (context, index) {
                BlogPostModel blogPost = blogData[index];
                return Padding(
                  padding: EdgeInsets.all(6),
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blogPost.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(blogPost.content,
                              style: TextStyle(fontSize: 14)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Created at: ${DateFormat('yyyy-MM-dd HH:mm').format(blogPost.createdAt)}",
                              ),
                              ElevatedButton(
                                onPressed:
                                //  _showComments,
                                (){
                                  _showComments(blogPost.id);
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
                                      horizontal: 20), // Button padding
                                  elevation:
                                      0, // No shadow to maintain transparency
                                  side: BorderSide(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      width: 2), // Border color and width
                                ),
                                child: Text(
                                  'View Comments',
                                  style: TextStyle(
                                      fontSize: 13, // Text size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black // Text weight
                                      ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBlogPage(),
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
