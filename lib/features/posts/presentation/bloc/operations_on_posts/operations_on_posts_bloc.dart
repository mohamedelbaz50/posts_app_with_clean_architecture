
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/constans/success_messages.dart';
import 'package:posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:posts_app/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post_usecase.dart';

import '../../../../../core/constans/failure_messages.dart';
import '../../../../../core/errors/failures.dart';

part 'operations_on_posts_event.dart';
part 'operations_on_posts_state.dart';

class OperationsOnPostsBloc
    extends Bloc<OperationsOnPostsEvent, OperationsOnPostsState> {
  final AddPostUsecase addPost;
  final UpdatePostUsecase updatePost;
  final DeletePostUsecase deletePost;
  OperationsOnPostsBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(OperationsOnPostsInitial()) {
    on<OperationsOnPostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingOnPostOperationState());
        final faliureOrDoneMessage = await addPost(event.post);
        emit(eitherDoneOrErrorState(faliureOrDoneMessage, addSuccessMessage));
      } else if (event is UpdatePostEvent) {
        emit(LoadingOnPostOperationState());
        final faliureOrDoneMessage = await updatePost(event.post);
        emit(
            eitherDoneOrErrorState(faliureOrDoneMessage, updateSuccessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingOnPostOperationState());
        final faliureOrDoneMessage = await deletePost(event.postId);
        emit(
            eitherDoneOrErrorState(faliureOrDoneMessage, deleteSuccessMessage));
      }
    });
  }
  OperationsOnPostsState eitherDoneOrErrorState(
      Either<Failures, Unit> either, String message) {
    return either.fold((failure) {
      return (ErrorOnPostOperationState(message: faluireMessage(failure)));
    }, (_) {
      return (SuccessOnPostOperationState(message: message));
    });
  }

  String faluireMessage(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;

      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return "Unexcepected Error ,Please Try Again Later";
    }
  }
}
