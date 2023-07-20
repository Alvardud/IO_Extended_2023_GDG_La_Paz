import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:io_extended_2023_gdg_la_paz/src/models/user_auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/ui/pages/auth/login_service.dart';

import '../../../config/string_validator.dart';
import '../../shared/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const route = 'login_page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginService = LoginService('usuarios');

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool watch = false;
  bool isLoading = false;

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    child: Text(
                      'Log In your account',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildTitle('User'),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (email) => validatorEmail(email!),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: 'Email', filled: true),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildTitle('Password'),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) => validator(value!, 'Password'),
                    autocorrect: false,
                    obscureText: !watch,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 40, maxWidth: 40),
                        suffixIcon: IconButton(
                          iconSize: 20,
                          icon: SvgPicture.asset(
                            'assets/icons/eye.svg',
                            height: 16,
                            width: 26,
                            colorFilter: ColorFilter.mode(
                                watch
                                    ? AppColors.primary
                                    : AppColors.googleGrey900,
                                BlendMode.srcIn),
                          ),
                          onPressed: () {
                            setState(() {
                              watch = !watch;
                            });
                          },
                        )),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: _onTapLogin,
                            child: const Text('Log In',
                                style: TextStyle(
                                  fontSize: 20,
                                ))),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // TextButton(
                  //     onPressed: _forgotPassword,
                  //     child: const Text(
                  //       'Forgot your password?',
                  //       style: TextStyle(
                  //         color: AppColors.black,
                  //       ),
                  //     ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapLogin() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final userAuth = UserAuth(email: email, password: password);
      isLoading = true;
      setState(() {});
      try {
        await loginService.signInWithEmailAndPassword(userAuth);

      } catch (e) {
        print(e);
        isLoading = false;
        setState(() {});
        // show  dialog
      }
    } else {}
  }
}
