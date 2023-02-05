import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';

class GetAllPostsUsecase {
  late final PostsRepo repo;
  GetAllPostsUsecase(this.repo);
  Future<Either<Failures, List<Post>>> call() async {
    return await repo.getAllPosts();
  }
}
