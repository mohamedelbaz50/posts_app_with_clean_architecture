part of 'operations_on_posts_bloc.dart';

abstract class OperationsOnPostsState extends Equatable {
  const OperationsOnPostsState();

  @override
  List<Object> get props => [];
}

class OperationsOnPostsInitial extends OperationsOnPostsState {}

class LoadingOnPostOperationState extends OperationsOnPostsState {}

class SuccessOnPostOperationState extends OperationsOnPostsState {
  final String message;

  const SuccessOnPostOperationState({required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorOnPostOperationState extends OperationsOnPostsState {
  final String message;

  const ErrorOnPostOperationState({required this.message});
  @override
  List<Object> get props => [message];
}
