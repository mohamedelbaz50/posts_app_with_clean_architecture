import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int? postId;
  final String postTitle;
  final String postBody;
  const Post({this.postId, required this.postTitle, required this.postBody});

  @override
  List<Object?> get props => [postId, postTitle, postBody];
}
