part of 'increment_decrement_bloc.dart';

@immutable
sealed class IncrementDecrementState {}

final class IncrementDecrementInitial extends IncrementDecrementState {}

final class CounterState  {
  final int count;
  final String message;

  CounterState({required this.count, required this.message});
}