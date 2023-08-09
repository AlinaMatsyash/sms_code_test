part of 'fate_bloc.dart';

@immutable
abstract class FateState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyState extends FateState {}

class LoadingState extends FateState {}

class LoadedState extends FateState {
  final Fate fate;

  LoadedState({required this.fate});

  @override
  List<Object> get props => [fate];
}

class ErrorState extends FateState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
