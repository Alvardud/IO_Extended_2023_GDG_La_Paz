import 'package:flutter/material.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';

import '../../../config/string_validator.dart';

/// In this screen the user will write down his email he will be able to reset his password if his email exists
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const String route = '/forgot_password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Text(
              'Introduce la dirección de correo electrónico que utilizaste al registrarte y te enviaremos instrucciones para restablecer tu contraseña.',
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              controller: _emailController,
              validator: (email) => validatorEmail(email!),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 32,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () => _onContinue(context),
                      child: const Text(
                        'Continue',
                      )),
            ),
          ]),
        ),
      )),
    );
  }

  /// Method that sends an email to reset the password
  void _onContinue(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.toString().trim();
      setState(() {
        _loading = true;
      });

      try {
        await Auth().sendPasswordResetEmail(email);
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          false;
        });
        AlertDialog(
          title: const Text('Upsss'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      }
    }
  }

  Future<void> verifyEmailBusiness() async {}
}
