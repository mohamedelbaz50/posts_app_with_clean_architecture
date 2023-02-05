part of 'operations_on_posts_bloc.dart';

abstract class OperationsOnPostsEvent extends Equatable {
  const OperationsOnPostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends OperationsOnPostsEvent {
  final Post post;

  const AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends OperationsOnPostsEvent {
  final Post post;

  const UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends OperationsOnPostsEvent {
  final int postId;

  const DeletePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
