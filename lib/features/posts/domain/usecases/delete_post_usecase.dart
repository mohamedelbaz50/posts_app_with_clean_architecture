import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repo.dart';

class DeletePostUsecase {
  late final PostsRepo repo;
  DeletePostUsecase(this.repo);
  Future<Either<Failures, Unit>> call(int postId) async {
    return repo.deletePost(postId);
  }
}
