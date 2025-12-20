import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/advanced_pagination/bloc/adv_pagination_bloc.dart';

class AdvPaginationScreen extends StatefulWidget {
  const AdvPaginationScreen({super.key});

  @override
  State<AdvPaginationScreen> createState() => _AdvPaginationScreenState();
}

class _AdvPaginationScreenState extends State<AdvPaginationScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initial fetch
    context.read<AdvPaginationBloc>().add(FetchNewsEvent());

    // Lazy loading listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        context.read<AdvPaginationBloc>().add(FetchNewsEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Feed")),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search news...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context
                    .read<AdvPaginationBloc>()
                    .add(SearchNewsChanged(value));
              },
            ),
          ),

          // 📰 Content
          Expanded(
            child: BlocBuilder<AdvPaginationBloc, AdvPaginationState>(
              builder: (context, state) {
                // 🔄 Initial / Loading
                if (state is AdvPaginationInitial ||
                    state is AdvPaginationLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 💾 Cached (Offline)
                if (state is AdvPaginationCached) {
                  return _buildList(state.news, hasReachedMax: true);
                }

                // ❌ Error
                if (state is AdvPaginationError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.errorMessage),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<AdvPaginationBloc>()
                                .add(RetryFetchNewsEvent());
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }

                // ✅ Loaded
                if (state is AdvPaginationLoaded) {
                  return _buildList(
                    state.news,
                    hasReachedMax: state.hasReachedMax,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🧩 Reusable List Builder
  Widget _buildList(List news, {required bool hasReachedMax}) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: hasReachedMax ? news.length : news.length + 1,
      itemBuilder: (context, index) {
        // ⏳ Bottom Loader
        if (index >= news.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final item = news[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(item.title),
            subtitle: Text(item.content),
          ),
        );
      },
    );
  }
}
