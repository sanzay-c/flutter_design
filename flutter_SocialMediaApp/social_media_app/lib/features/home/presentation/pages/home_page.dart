// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/features/auth/presentation/cubits/cubit/auth_cubit.dart';
import 'package:social_media_app/features/home/components/my_drawer.dart';
import 'package:social_media_app/features/post/presentation/components/post_tile.dart';
import 'package:social_media_app/features/post/presentation/cubit/post_cubit.dart';
import 'package:social_media_app/features/post/presentation/pages/upload_post_page.dart';
// import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // postCubit
  late final postCubit = context.read<PostCubit>();

  // onstartup
  @override
  void initState() {
    // fetch all posts
    fetchAllPost();
    super.initState();
  }

  void fetchAllPost() {
    postCubit.fetchAllPost();
  }

  void deletePost(String postId) {
    postCubit.deletePost(postId);
    fetchAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        centerTitle: true,
        title: const Text('Homepage'),
        actions: [
          // logout Button
          // IconButton( // moved the logout button in the drawer
          //   onPressed: () {
          //     context.read<AuthCubit>().logout();
          //   },
          //   icon: const Icon(
          //     Icons.logout_rounded,
          //   ),
          // ),

          // upload new post button
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadPostPage(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      // drawer
      drawer: MyDrawer(),

      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          // Loading ..
          if (state is PostsLoading || state is PostsUploading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Loaded
          else if (state is PostsLoaded) {
            final allPosts = state.posts;

            if (allPosts.isEmpty) {
              return const Center(
                child: Text("No posts available"),
              );
            }
            return ListView.builder(
              itemCount: allPosts.length,
              itemBuilder: (context, index) {
                // Get individual post
                final post = allPosts[index];

                // Image
                return PostTile(
                  post: post,
                  onDeletePressed: () => deletePost(post.id),
                );

                // // Image
                // return CachedNetworkImage(
                //   imageUrl: post.imageUrl,
                //   height: 430,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                //   placeholder: (context, url) => const SizedBox(height: 430),
                //   errorWidget: (context, url, error) => const Icon(Icons.error),
                // );
              },
            );
          }
          // Error
          else if (state is PostsError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
