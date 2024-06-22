import 'package:bloc/bloc.dart';

abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}

// States

abstract class CounterState {
  final int counter;

  const CounterState({
    required this.counter,
  });
}

class CounterSuccessState extends CounterState {
  CounterSuccessState({required super.counter});
}

class CounterErrorState extends CounterState {
  final String errorMessage;

  CounterErrorState({required super.counter, required this.errorMessage});
}

class CounterInitialState extends CounterState {
  CounterInitialState() : super(counter: 0);
}
// Bloc

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitialState()) {
    on((IncrementCounterEvent event, emit) {
      if (state.counter < 10) {
        int counterValue = state.counter + 1;
        emit(CounterSuccessState(counter: counterValue));
      } else {
        emit(CounterErrorState(
            counter: state.counter,
            errorMessage: "Counter value cannot exceed 10"));
      }
    });
    on((DecrementCounterEvent event, emit) {
      if (state.counter > 0) {
        int counterValue = state.counter - 1;
        emit(CounterSuccessState(counter: counterValue));
      } else {
        emit(CounterErrorState(
            counter: state.counter,
            errorMessage: "Counter value cannot be less than 0"));
      }
    });
  }
}
