part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent extends Equatable{
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterIncrement extends CounterEvent{}

class CounterDecrement extends CounterEvent{}