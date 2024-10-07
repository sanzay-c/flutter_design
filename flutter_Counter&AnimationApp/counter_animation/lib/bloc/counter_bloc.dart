import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int _counter = 0;

  CounterBloc() : super(CounterInitial()) {
    on<CounterIncrement>((event, emit) {
      emit(CounterLoading());
      _counter++;
      emit(CounterUpdate(_counter));
    });

    on<CounterDecrement>((event, emit) {
      emit(CounterLoading());
      _counter--;
      emit(CounterUpdate(_counter));
    });
  }
}

