part of 'form_validation_bloc.dart';

@immutable
sealed class FormValidationState {}

final class FormValidationInitial extends FormValidationState {}

final class FormValid extends FormValidationState{}

final class FormInvalid extends FormValidationState{
  final Map<String, dynamic> fieldErrors;

  FormInvalid({required this.fieldErrors});
}

final class FormSubmittion extends FormValidationState {}

final class FormSuccess extends FormValidationState {}

final class FormFailures extends FormValidationState {
  final String errorMessage;

  FormFailures({required this.errorMessage});
}