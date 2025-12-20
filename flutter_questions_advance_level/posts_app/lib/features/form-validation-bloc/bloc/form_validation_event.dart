part of 'form_validation_bloc.dart';

@immutable
sealed class FormValidationEvent extends Equatable{}

final class FormFieldChangeEvenet extends FormValidationEvent{
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  FormFieldChangeEvenet({required this.name, required this.email, required this.password, required this.confirmPassword});

  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}

class FormSubmittedEvent extends FormValidationEvent {
  @override
  List<Object?> get props => [];
}

class RetrySubmitEvent extends FormValidationEvent {
  @override
  List<Object?> get props => [];
}