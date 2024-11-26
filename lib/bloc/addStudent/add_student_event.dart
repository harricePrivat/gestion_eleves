part of 'add_student_bloc.dart';

sealed class AddStudentEvent extends Equatable {
  const AddStudentEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SendDataStudent extends AddStudentEvent {
  FormData object;
  SendDataStudent(this.object);
}
