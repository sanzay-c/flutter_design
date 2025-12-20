import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'form_validation_event.dart';
part 'form_validation_state.dart';

class FormValidationBloc extends Bloc<FormValidationEvent, FormValidationState> {
   String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  FormValidationBloc() : super(FormValidationInitial()) {
    on<FormFieldChangeEvenet>(_onFormFieldChangeEvenet);
    on<FormSubmittedEvent>(_onFormSubmittedEvent);
    on<RetrySubmitEvent>(_onRetrySubmitEvent);
  }

  FutureOr<void> _onFormFieldChangeEvenet(FormFieldChangeEvenet event, Emitter<FormValidationState> emit) {
    name = event.name;
    email = event.email;
    password = event.password;
    confirmPassword = event.confirmPassword;

    final error = _validate();

    if (error.isEmpty) {
      emit(FormValid());
    } else {
      emit(FormInvalid(fieldErrors: error));
    }
  }

  FutureOr<void> _onFormSubmittedEvent(FormSubmittedEvent event, Emitter<FormValidationState> emit) async {
    final errors = _validate();
    if (errors.isNotEmpty) {
      emit(FormInvalid(fieldErrors: errors));
      return;
  
    }

        emit(FormSubmittion());

    await Future.delayed(const Duration(seconds: 2));

    // simulate random failure
    final success = DateTime.now().second % 2 == 0;

    if (success) {
      emit(FormSuccess());
    } else {
      emit(FormFailures(errorMessage:  "Registration failed. Try again."));
    }
  }

  FutureOr<void> _onRetrySubmitEvent(RetrySubmitEvent event, Emitter<FormValidationState> emit) {
    emit(FormValidationInitial());
  }


  Map<String, String> _validate() {
    final errors = <String, String>{};

    if (name.trim().length < 3) {
      errors['name'] = "Name must be at least 3 characters";
    }

    if (!email.contains('@')) {
      errors['email'] = "Invalid email";
    }

    if (password.length < 8) {
      errors['password'] = "Password must be 8 characters";
    }

    if (password != confirmPassword) {
      errors['confirm'] = "Passwords do not match";
    }

    return errors;
  }
}


