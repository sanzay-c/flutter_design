import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/socket/domain/entities/message_entity.dart';
import 'package:posts_app/features/socket/presentation/bloc/socket_event.dart';
import '../bloc/socket_bloc.dart';

class ChatScreen extends StatelessWidget {
  final controller = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<SocketBloc>().add(DisconnectSocket());
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SocketBloc, SocketState>(
              builder: (context, state) {
                if (state is SocketConnecting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SocketConnected) {
                  return ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (_, i) {
                      final msg = state.messages[i];
                      return Align(
                        alignment: msg.isMine
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(10),
                          color: Colors.blueAccent,
                          child: Text(msg.text),
                        ),
                      );
                    },
                  );
                }

                return const Center(child: Text('Disconnected'));
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(controller: controller),
              ),
              // IconButton(
              //   icon: const Icon(Icons.send),
              //   onPressed: () {
              //     context
              //         .read<SocketBloc>()
              //         .add(SendMessage());
              //     controller.clear();
              //   },
              // )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SocketBloc>().add(ConnectSocket());
        },
        child: const Icon(Icons.wifi),
      ),
    );
  }
}
