import 'package:bloc/bloc.dart';
import 'package:chat_test/core/error/failures.dart';
import 'package:chat_test/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/fate.dart';
import '../../domain/usecases/get_fate.dart';

part 'fate_event.dart';

part 'fate_state.dart';

class FateBloc extends Bloc<FateEvent, FateState> {
  final GetFate getFate;

  FateBloc({
    required GetFate fate,
  })  : getFate = fate,
        super(EmptyState()) {
    on<FateEvent>((event, emit) async {
      if (event is GetFateEvent) {
        emit(LoadingState());
        final failureOrTriviaR = await getFate(NoParams());
        failureOrTriviaR.fold(
            (failure) =>
                emit(ErrorState(message: _mapFailureToMessage(failure))),
            (fate) => emit(LoadedState(fate: fate)));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected error';
    }
  }
}
