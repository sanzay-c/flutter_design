part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent extends Equatable {}

final class AddTodo extends TodoEvent {
  @override
  List<Object?> get props => [];
}

final class ToggleCompleteIncomplete extends TodoEvent {
  @override
  List<Object?> get props => [];
}

