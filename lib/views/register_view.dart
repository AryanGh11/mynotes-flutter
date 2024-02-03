import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exeptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/widgets/buttons/simple_elevated_button.dart';
import 'package:mynotes/widgets/buttons/simple_ouline_button.dart';
import 'package:mynotes/widgets/text_fileds/simple_text_filed.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SimpleTextField(
                hintText: "Enter your email",
                textEditingController: _email,
                enableSuggestions: false,
                autocorrect: false,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              SimpleTextField(
                hintText: "Enter your password",
                textEditingController: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              const SizedBox(height: 16),
              SimpleElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase().createUser(
                      email: email,
                      password: password,
                    );
                    await AuthService.firebase().sendEmailVerification();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed(
                      verifyEmailRoute,
                    );
                  } on WeakPasswordAuthExeption {
                    // ignore: use_build_context_synchronously
                    await showErrorDialog(
                      context,
                      "Your password is weak",
                    );
                  } on EmailAlreadyInUseAuthExeption {
                    // ignore: use_build_context_synchronously
                    await showErrorDialog(
                      context,
                      "Email is already in use",
                    );
                  } on InvalidEmailAuthExeption {
                    // ignore: use_build_context_synchronously
                    await showErrorDialog(
                      context,
                      "This email is invalid",
                    );
                  } on GenericAuthExeption {
                    // ignore: use_build_context_synchronously
                    await showErrorDialog(
                      context,
                      "Failed to register",
                    );
                  }
                },
                child: const Text("Register"),
              ),
              const SizedBox(height: 8),
              SimpleOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  },
                  child: const Text("Do you have an account? Login here!"))
            ],
          ),
        ));
  }
}
