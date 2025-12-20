import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'increment_decrement_event.dart';
part 'increment_decrement_state.dart';

class IncrementDecrementBloc extends Bloc<IncrementDecrementEvent, CounterState> {
  IncrementDecrementBloc() : super(CounterState(count: 0, message: '')) {
    on<IncrementEvent>(_onIncrementEvent);

    on<DecrementEvent>(_onDecrementEvent);
  }


  FutureOr<void> _onIncrementEvent(IncrementEvent event, Emitter<CounterState> emit) {
    try {
      if (state.count >= 10){
        emit(CounterState(count: state.count, message: "Max limit reached"));
      } else {
        emit(CounterState(count: state.count + 1 , message: ''));
      }
    } catch (e) {
      
    }
  }

  FutureOr<void> _onDecrementEvent(DecrementEvent event, Emitter<CounterState> emit) {
    if (state.count < 1){
      emit(CounterState(count: state.count, message: "Min limit reached"));
    } else {
      emit(CounterState(count: state.count -1, message: ''));
    }
  }
}
