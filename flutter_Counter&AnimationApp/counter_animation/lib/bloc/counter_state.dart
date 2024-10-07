part of 'counter_bloc.dart';

@immutable
abstract class CounterState {
  const CounterState();

  List<Object> get props => [];
}

final class CounterInitial extends CounterState {}

final class CounterLoading extends CounterState {}

final class CounterUpdate extends CounterState {
  final int count;
  
  CounterUpdate(this.count);

  @override
  List<Object> get props => [count];
}
