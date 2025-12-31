import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/presentation/components/user_tile.dart';
import 'package:social_media_app/features/profile/presentation/cubit/cubit/profile_cubit.dart';
import 'package:social_media_app/features/search/presentation/cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPage> {
  // search controller
  final searchController = TextEditingController();

  // search cubit
  late final searchCubit = context.read<SearchCubit>();

  // method for search
  void onSearchChange() {
    final query = searchController.text;
    searchCubit.searchUser(query);
  }

  // init state
  @override
  void initState() {
    searchController.addListener(onSearchChange);
    super.initState();
  }

  // dispose search controller
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search users...",
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),

      // search results in body
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          // loaded
          if (state is SearchLoaded) {
            // no users..
            if (state.users.isEmpty) {
              return const Center(
                child: Text("No user found"),
              );
            }
            // users..
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return UserTile(user: user!);
              },
            );
          }

          // loading..
          else if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // error..
          else if (state is SearchError) {
            return Center(
              child: Text(state.message),
            );
          }

          // default
          return Center(
            child: Text("Start searching for users.."),
          );
        },
      ),
    );
  }
}
