part of 'fate_bloc.dart';

@immutable
abstract class FateEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class GetFateEvent extends FateEvent {}
