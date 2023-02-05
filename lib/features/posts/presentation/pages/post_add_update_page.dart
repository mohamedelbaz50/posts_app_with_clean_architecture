import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/operations_on_posts/operations_on_posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_app/features/posts/presentation/widgets/form_widget.dart';
import 'package:posts_app/features/posts/presentation/widgets/show_snack_bar_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePage;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePage ? "Edit Post" : "Add Post"),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<OperationsOnPostsBloc, OperationsOnPostsState>(
            listener: (context, state) {
              if (state is SuccessOnPostOperationState) {
                showSnackBar(
                    context: context,
                    message: state.message,
                    color: Colors.green);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const PostsPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorOnPostOperationState) {
                showSnackBar(
                    context: context,
                    message: state.message,
                    color: Colors.red);
              }
            },
            builder: (context, state) {
              if (state is LoadingOnPostOperationState) {
                return const LoadingWidget();
              }

              return FormWidget(
                  isUpdatePage: isUpdatePage, post: isUpdatePage ? post : null);
            },
          )),
    );
  }
}
