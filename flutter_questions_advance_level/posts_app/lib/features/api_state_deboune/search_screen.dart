import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/api_state_deboune/bloc/api_handler_bloc.dart';
import 'package:posts_app/features/api_state_handler/bloc/api_handler_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  TextFormField(
        controller: searchController,
        onChanged: (value) {
          context.read<ApiHandlerBlocDebounce>().add(SearchTextChanged(query: value));
        },
      ),
    );
  }
}