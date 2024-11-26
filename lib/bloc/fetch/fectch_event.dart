part of 'fectch_bloc.dart';

sealed class FectchEvent extends Equatable {
  const FectchEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchData extends FectchEvent {
  String url;
  Object object;
  FetchData(this.url, this.object);

  @override
  List<Object> get props => [url, object];
}
