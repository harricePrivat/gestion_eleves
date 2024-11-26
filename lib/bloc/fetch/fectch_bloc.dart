import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gestion_etudiant/services/send_data.dart';

part 'fectch_event.dart';
part 'fectch_state.dart';

class FectchBloc extends Bloc<FectchEvent, FectchState> {
  FectchBloc() : super(FectchInitial()) {
    on<FetchData>((event, emit) async {
      emit(FetchDataLoading());
      try {
        final response = await SendData().goPost(event.url, event.object);
        if (response.statusCode == 200) {
          final object = jsonDecode(response.body);
          if (object is List && object.isNotEmpty) {
            emit(FetchDataLoaded(object));
          } else {
            emit(FetchDataLoadedBlank());
          }
        }
      } catch (e) {
        emit(FetchDataError("Impossible"));
      }
    });
  }
}
