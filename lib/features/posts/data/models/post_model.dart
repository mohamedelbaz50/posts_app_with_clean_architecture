
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';

class PostModel extends Post {
  const PostModel({super.postId, required super.postTitle, required super.postBody});
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        postId: json["id"], postTitle: json["title"], postBody: json["body"]);
  }
  Map<String, dynamic> toJson() {
    return {"id": postId, "title": postTitle, "body": postBody};
  }
}
