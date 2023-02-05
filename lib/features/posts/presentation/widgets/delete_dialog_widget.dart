import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/operations_on_posts/operations_on_posts_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are You Sure"),
      actions: [
        TextButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            child: const Text("No")),
        TextButton(
            onPressed: (() {
              BlocProvider.of<OperationsOnPostsBloc>(context)
                  .add(DeletePostEvent(postId: postId));
            }),
            child: const Text("Yes"))
      ],
    );
  }
}
