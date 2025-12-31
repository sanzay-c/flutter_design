import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/chat_app_socket/presentation/bloc/chat_bloc.dart';
import 'package:posts_app/features/chat_app_socket/presentation/bloc/chat_event.dart';

class SocketChatScreen extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebSocket Chat')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoaded) {
                  return ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(state.messages[index].text),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          TextField(
            controller: controller,
            onSubmitted: (value) {
              context
                  .read<ChatBloc>()
                  .add(SendChatMessage(value));
              controller.clear();
            },
          )
        ],
      ),
    );
  }
}