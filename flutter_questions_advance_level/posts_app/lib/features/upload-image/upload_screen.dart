import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/upload-image/prsentation/bloc/upload_bloc.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Upload")),
      body: BlocBuilder<UploadBloc, UploadState>(
        builder: (context, state) {
          if (state is UploadInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<UploadBloc>().add(PickImageEvent());
                },
                child: const Text("Pick Image"),
              ),
            );
          }

          if (state is ImagePicked) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.image, size: 100),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<UploadBloc>()
                          .add(UploadImageEvent(state.image));
                    },
                    child: const Text("Upload"),
                  ),
                ],
              ),
            );
          }

          if (state is UploadInProgress) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(value: state.progress),
                  const SizedBox(height: 12),
                  Text("${(state.progress * 100).toInt()}%"),
                ],
              ),
            );
          }

          if (state is UploadSuccess) {
            return const Center(
              child: Text(
                "✅ Upload Successful!",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            );
          }

          if (state is UploadFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.error),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<UploadBloc>()
                          .add(RetryUploadEvent());
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
