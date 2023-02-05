import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/operations_on_posts/operations_on_posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/widgets/text_form_field_widget.dart';

import '../../../../core/widgets/custom_button.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, this.post, required this.isUpdatePage});
  final Post? post;
  final bool isUpdatePage;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdatePage) {
      titleController.text = widget.post!.postTitle;
      bodyController.text = widget.post!.postBody;
    }
    super.initState();
  }

  void updateOrAddPostButtonPressed() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
          postId: widget.isUpdatePage ? widget.post!.postId : null,
          postTitle: titleController.text,
          postBody: bodyController.text);
      if (widget.isUpdatePage) {
        BlocProvider.of<OperationsOnPostsBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<OperationsOnPostsBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            maxLines: 1,
            minLines: 1,
            controller: titleController,
            hintText: 'Title',
          ),
          TextFormFieldWidget(
            maxLines: 6,
            minLines: 6,
            controller: bodyController,
            hintText: 'Body',
          ),
          CustonButton(
            color: Theme.of(context).primaryColor,
            icon: widget.isUpdatePage ? Icons.edit : Icons.add,
            text: widget.isUpdatePage ? "Edit" : "Add",
            onPressed: updateOrAddPostButtonPressed,
          )
        ],
      ),
    );
  }
}
