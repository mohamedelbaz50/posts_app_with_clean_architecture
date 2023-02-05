import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repo.dart';

class AddPostUsecase {
  late final PostsRepo repo;
  AddPostUsecase(this.repo);
  Future<Either<Failures, Unit>> call(Post post) async {
    return repo.addPost(post);
  }
}
