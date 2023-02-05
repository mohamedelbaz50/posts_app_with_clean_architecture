import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';

abstract class PostsRepo {
  Future<Either<Failures, List<Post>>> getAllPosts();
  Future<Either<Failures, Unit>> deletePost(int postId);
  Future<Either<Failures, Unit>> updatePost(Post post);
  Future<Either<Failures, Unit>> addPost(Post post);
}
