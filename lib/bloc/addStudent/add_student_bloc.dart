import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
part 'add_student_event.dart';
part 'add_student_state.dart';

class AddStudentBloc extends Bloc<AddStudentEvent, AddStudentState> {
  AddStudentBloc() : super(AddStudentInitial()) {
    on<SendDataStudent>((event, emit) async {
      emit(AddStudentLoading());
      try {
        final response = await Dio()
            .post("${dotenv.env['URL']}/create-user", data: event.object);
        if (response.statusCode == 200) {
          emit(AddStudentInitial());
        } else {
          emit(AddStudentError());
        }
      } catch (e) {
        emit(AddStudentError());
      }
    });
  }
}
