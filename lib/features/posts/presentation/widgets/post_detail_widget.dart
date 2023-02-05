import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/custom_button.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';

import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/operations_on_posts/operations_on_posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_app/features/posts/presentation/widgets/delete_dialog_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/show_snack_bar_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.postTitle,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            width: MediaQuery.of(context).size.width - 10,
            height: 1,
            color: Colors.grey.withOpacity(0.6),
          ),
          Text(
            post.postBody,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustonButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.edit,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostAddUpdatePage(
                            isUpdatePage: true,
                            post: post,
                          ),
                        ));
                  },
                  text: "Edit"),
              CustonButton(
                  color: Colors.red,
                  icon: Icons.delete,
                  onPressed: () {
                    deleteDialog(context);
                  },
                  text: "Delete")
            ],
          )
        ],
      ),
    );
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<OperationsOnPostsBloc, OperationsOnPostsState>(
              listener: (context, state) {
            if (state is SuccessOnPostOperationState) {
              showSnackBar(
                color: Colors.green,
                message: state.message,
                context: context,
              );
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  ((route) => false));
            } else if (state is ErrorOnPostOperationState) {
              Navigator.of(context).pop();
              showSnackBar(
                color: Colors.red,
                message: state.message,
                context: context,
              );
            }
          }, builder: (context, state) {
            if (state is LoadingOnPostOperationState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialogWidget(postId: post.postId!);
          });
        });
  }
}
