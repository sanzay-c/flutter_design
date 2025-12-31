import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/presentation/components/my_button.dart';
import 'package:social_media_app/features/auth/presentation/components/textfield.dart';
import 'package:social_media_app/features/auth/presentation/cubits/cubit/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.togglePages});

  final void Function()? togglePages;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
// controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwController = TextEditingController();

  // register button pressed
  void register() {
    // prepare info
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPw = confirmPwController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    // ensure fields aren't empty
    if (email.isNotEmpty &&
        name.isNotEmpty &&
        password.isNotEmpty &&
        confirmPw.isNotEmpty) {
      // ensure password match 'password == confirmPw'
      if (password == confirmPw) {
        // Calls the register method on the authCubit to initiate user registration.
        authCubit.register(name, email, password);
      } else {
        //password don't match then error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("passwword dont match"),
          ),
        );
      }
    } else {
      // fields are empty then display the error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("Please complete all fields"),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  Icon(
                    Icons.lock_open_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 50),
                  // create account message
                  Text(
                    "let's crate an account",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // name textfield
                  MyTextField(
                    controller: nameController,
                    hintText: "Name",
                    obscureText: false,
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 25),
                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                  // password textfield
                  const SizedBox(height: 25),
                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 25),
                  // confirm password textfield
                  MyTextField(
                    controller: confirmPwController,
                    hintText: "Confirm Password",
                    obscureText: true,
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 25),
                  // register button
                  MyButton(
                    text: "Register",
                    onTap: register,
                  ),
                  const SizedBox(height: 25),
                  // already a member? Loginnow
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 17),
                      ),
                      GestureDetector(
                        onTap: widget.togglePages,
                        child: Text(
                          " Login Now?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
