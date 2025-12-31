import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/presentation/cubits/cubit/auth_cubit.dart';
import 'package:social_media_app/features/post/presentation/components/post_tile.dart';
import 'package:social_media_app/features/post/presentation/cubit/post_cubit.dart';
import 'package:social_media_app/features/profile/presentation/components/bio_box.dart';
import 'package:social_media_app/features/profile/presentation/components/follow_button.dart';
import 'package:social_media_app/features/profile/presentation/components/profile_stats.dart';
import 'package:social_media_app/features/profile/presentation/cubit/cubit/profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/follower_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.uid});

  final String uid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // cubits
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  // current user
  late AppUser? currentUser = authCubit.currentUser;

  // post count
  int postCount = 0;

  // on startup
  @override
  void initState() {
    super.initState();

    // load user profile date
    profileCubit..fetchUserProfile(widget.uid);
  }

  // FOLLOW / UNFOLLOW
  void followButtonPressed() {
    final profileState = profileCubit.state;
    if (profileState is! ProfileLoaded) {
      return; // return if profile is not loaded
    }

    final profileUser = profileState.profileUser;
    final isFollowing = profileUser.followers.contains(currentUser!.uid);

    // optimistically update the UI
    setState(() {
      // unfollow
      if (isFollowing) {
        profileUser.followers.remove(currentUser!.uid);
      }
      //follow
      else {
        profileUser.followers.add(currentUser!.uid);
      }
    });

    // perform actual toggle in cubit
    profileCubit.toggleFollow(currentUser!.uid, widget.uid).catchError((error) {
      // revert update if there's an error
      // optimistically update the UI
      setState(() {
        // unfollow
        if (isFollowing) {
          profileUser.followers.add(currentUser!.uid);
        }
        //follow
        else {
          profileUser.followers.remove(currentUser!.uid);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // is own post
    bool isOwnPost = widget.uid == (currentUser!.uid);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // loaded
        if (state is ProfileLoaded) {
          // get the loaded user
          final user = state.profileUser;

          return Scaffold(
            appBar: AppBar(
              // foregroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              title: Text(user.name),
              centerTitle: true,
              // leading helps to change the default appbar Icon
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              actions: [
                // edit profile button
                if (isOwnPost)
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(user: user),
                      ),
                    ),
                    icon: Icon(
                      Icons.settings,
                    ),
                  ),
              ],
            ),
            body: ListView(
              children: [
                // email
                Center(
                  child: Text(
                    user.email.isNotEmpty ? user.email : 'Email not available',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                const SizedBox(height: 25),

                // profile Picture
                CachedNetworkImage(
                  imageUrl: user.profileImageUrl,
                  // loading
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),

                  // error -> failed to load
                  errorWidget: (context, url, error) => Icon(
                    Icons.person,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  // loaded ..
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 120,
                    width: 120,
                    // child: Image(
                    //   image: imageProvider,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                // Container( // i have replaced this container with the cachedNetworkImage
                //   decoration: BoxDecoration(
                //       color: Theme.of(context).colorScheme.secondary,
                //       borderRadius: BorderRadius.circular(12)),
                //   height: 120,
                //   width: 120,
                //   padding: EdgeInsets.all(25),
                //   child: Center(
                //     child: Icon(
                //       Icons.person,
                //       size: 72,
                //       color: Theme.of(context).colorScheme.primary,
                //     ),
                //   ),
                // ),

                const SizedBox(height: 25),

                // profile stats
                ProfileStats(
                  postCount: postCount,
                  followersCount: user.followers.length,
                  followingCount: user.following.length,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FollowerPage(
                        followers: user.followers,
                        following: user.following,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // follow button
                if (!isOwnPost)
                  FollowButton(
                    onPressed: followButtonPressed,
                    isFollowing: user.followers.contains(currentUser!.uid),
                  ),

                const SizedBox(height: 25),

                // bio box
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: [
                      Text("Bio"),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                BioBox(text: user.bio),

                // posts
                Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 25),
                  child: Row(
                    children: [
                      Text("Posts"),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // list of posts from this user
                BlocBuilder<PostCubit, PostState>(
                  builder: (context, state) {
                    // post loaded
                    if (state is PostsLoaded) {
                      // filter post by userid
                      final userPosts = state.posts
                          .where((post) => post.userId == widget.uid)
                          .toList();
                      postCount = userPosts.length;

                      return ListView.builder(
                        itemCount: postCount,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // get indivisual post
                          final post = userPosts[index];

                          // return as post tile UI
                          return PostTile(
                            post: post,
                            onDeletePressed: () =>
                                context.read<PostCubit>().deletePost(post.id),
                          );
                        },
                      );
                    }

                    // post loading
                    else if (state is PostsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(
                        child: Text("No Posts.."),
                      );
                    }
                  },
                )
              ],
            ),
          );
        }
        // loading...
        else if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Center(
            child: Text("No profile found."),
          );
        }
      },
    );
  }
}
