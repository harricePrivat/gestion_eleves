part of 'add_student_bloc.dart';

sealed class AddStudentState extends Equatable {
  const AddStudentState();

  @override
  List<Object> get props => [];
}

final class AddStudentInitial extends AddStudentState {}

final class AddStudentDone extends AddStudentState {}

final class AddStudentLoading extends AddStudentState {}

final class AddStudentError extends AddStudentState {}
