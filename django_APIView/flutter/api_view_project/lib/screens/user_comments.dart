import 'package:api_view_project/models/blog_comment_model.dart';
import 'package:api_view_project/screens/add_comments.dart';
import 'package:api_view_project/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class UserComments extends StatefulWidget {
  const UserComments({
    super.key,
    required this.postId,
  });

  final int postId;

  @override
  State<UserComments> createState() => _UserCommentsState();
}

class _UserCommentsState extends State<UserComments> {
  final ApiServices apiServices = ApiServices();
  late Future<List<BlogCommentModel>> blogCommentsData =
      apiServices.getComments(widget.postId);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.infinity,
      child: Column(
        children: [
            Text(
              'COMMENTS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          SizedBox(height: 20),
          FutureBuilder(
            future: blogCommentsData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                final List<BlogCommentModel> userComment = snapshot.data!;
                return userComment.isEmpty
                    ? Text(
                        "Be the first to comment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: const Color.fromARGB(157, 0, 0, 0)),
                      )
                    : ListView.builder(
                        itemCount: userComment.length,
                        // This ensures that the ListView doesn't take up infinite space
                        shrinkWrap: true,
                        // Disable ListView's scroll
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final comments = userComment[index];
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
                                        Text(
                                          comments.text,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "By ${comments.name}",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    151, 0, 0, 0),
                                              ),
                                            ),
                                            Text(
                                              "Created at: ${DateFormat('yyyy-MM-dd HH:mm').format(comments.createdAt)}",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    151, 0, 0, 0),
                                              ),
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
                      );
              } else {
                return SizedBox();
              }
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddComments(blogPostId: widget.postId,),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              // backgroundColor: Colors
              //     .transparent, // Transparent background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
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
}
