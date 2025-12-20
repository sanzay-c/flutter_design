import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/form-validation-bloc/bloc/form_validation_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  void _onChanged() {
    context.read<FormValidationBloc>().add(
          FormFieldChangeEvenet(
            name: nameCtrl.text,
            email: emailCtrl.text,
            password: passCtrl.text,
            confirmPassword: confirmCtrl.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: BlocBuilder<FormValidationBloc, FormValidationState>(
        builder: (context, state) {
          final errors =
              state is FormInvalid ? state.fieldErrors : {};

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _field("Name", nameCtrl, errors['name'], _onChanged),
                _field("Email", emailCtrl, errors['email'], _onChanged),
                _field("Password", passCtrl, errors['password'], _onChanged,
                    obscure: true),
                _field("Confirm Password", confirmCtrl,
                    errors['confirm'], _onChanged,
                    obscure: true),

                const SizedBox(height: 20),

                if (state is FormSubmittion)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: state is FormValid
                        ? () {
                            context
                                .read<FormValidationBloc>()
                                .add(FormSubmittedEvent());
                          }
                        : null,
                    child: const Text("Submit"),
                  ),

                if (state is FormFailures)
                  Column(
                    children: [
                      Text(state.errorMessage,
                          style: const TextStyle(color: Colors.red)),
                      TextButton(
                        onPressed: () {
                          context
                              .read<FormValidationBloc>()
                              .add(RetrySubmitEvent());
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),

                if (state is FormSuccess)
                  const Text(
                    "🎉 Registration Successful!",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, String? error,
      VoidCallback onChanged,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        obscureText: obscure,
        onChanged: (_) => onChanged(),
        decoration: InputDecoration(
          labelText: label,
          errorText: error,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
