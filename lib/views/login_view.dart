import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exeptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/widgets/buttons/simple_elevated_button.dart';
import 'package:mynotes/widgets/buttons/simple_ouline_button.dart';
import 'package:mynotes/widgets/text_fileds/simple_text_filed.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SimpleTextField(
                labelText: "Email",
                hintText: "Enter your email",
                textEditingController: _email,
                enableSuggestions: false,
                autocorrect: false,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              SimpleTextField(
                labelText: "Password",
                hintText: "Enter your password",
                textEditingController: _password,
                obscureText: true,
                maxLines: 1,
                enableSuggestions: false,
                autocorrect: false,
              ),
              const SizedBox(height: 16),
              SimpleElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase().login(
                      email: email,
                      password: password,
                    );
                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailVerified ?? false) {
                      // user's email is verified
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        notesRoute,
                        (route) => false,
                      );
                    } else {
                      // user's email is NOT verified
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyEmailRoute,
                        (route) => false,
                      );
                    }
                  } on InvalidCredentialAuthExeption {
                    // ignore: use_build_context_synchronously
                    await showErrorDialog(
                      context,
                      "Email or password is wrong",
                    );
                  } on GenericAuthExeption {
                    // ignore: use_build_context_synchronously
                    await showErrorDialog(
                      context,
                      "Authentication error",
                    );
                  }
                },
                padding: const EdgeInsets.all(16),
                child: const Text("Login"),
              ),
              const SizedBox(height: 8),
              SimpleOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => false,
                    );
                  },
                  padding: const EdgeInsets.all(16),
                  child: const Text("Not registered yet? Register here!"))
            ],
          ),
        ));
  }
}
