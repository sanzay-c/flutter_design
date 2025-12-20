part of 'increment_decrement_bloc.dart';

@immutable
sealed class IncrementDecrementEvent extends Equatable{}

final class IncrementEvent extends IncrementDecrementEvent {

  @override
  List<Object?> get props => [];
}

final class DecrementEvent extends IncrementDecrementEvent {
  
  @override
  List<Object?> get props => [];
}