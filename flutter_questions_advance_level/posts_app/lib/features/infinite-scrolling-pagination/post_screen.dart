import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/infinite-scrolling-pagination/api_services_post.dart';
import 'package:posts_app/features/infinite-scrolling-pagination/bloc/pagination_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        context.read<PaginationBloc>().add(FetchPostEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaginationBloc(apiService: ApiServicesPost())..add(FetchPostEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Infinite Scroll Posts")),
        body: BlocBuilder<PaginationBloc, PaginationState>(
          builder: (context, state) {
            if (state is PaginationInitial || state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PostsError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          context.read<PaginationBloc>().add(RetryFetchEvent());
                        },
                        child: const Text("Retry"))
                  ],
                ),
              );
            }

            if (state is PostsLoaded) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.posts.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.content),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
