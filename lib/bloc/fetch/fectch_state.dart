part of 'fectch_bloc.dart';

sealed class FectchState extends Equatable {
  const FectchState();

  @override
  List<Object> get props => [];
}

final class FectchInitial extends FectchState {}

// ignore: must_be_immutable
final class FetchDataLoaded extends FectchState {
  Object object;
  FetchDataLoaded(this.object);

  @override
  List<Object> get props => [object];
}

final class FetchDataLoading extends FectchState {}

final class FetchDataLoadedBlank extends FectchState {}

// ignore: must_be_immutable
final class FetchDataError extends FectchState {
  String message;
  FetchDataError(this.message);

  @override
  List<Object> get props => [message];
}
