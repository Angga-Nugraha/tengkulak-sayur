import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tengkulak_sayur/data/utils/styles/color.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/bloc/authentication/auth_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/components/components_helpers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocListener<LoginBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is LoadingState) {
            myLoading(context, 'Signing in...');
          } else if (state is AuthenticationErrorState) {
            Navigator.pop(context);
            myDialog(
                context: context,
                title: state.message,
                textButton1: 'OK',
                textButton2: 'Cancel',
                onPressed1: () {
                  Navigator.pop(context);
                },
                onPressed2: () {
                  Navigator.pop(context);
                });
          } else if (state is LoginSuccessState) {
            final user = state.user;
            Navigator.pushReplacementNamed(context, rootScreenRoute,
                arguments: user.uuid);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Lottie.asset(
                    'assets/img/login.json',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Welcome to Tengkulak Sayur',
                        style: TextStyle(
                            fontFamily: 'Firasans',
                            fontSize: 25,
                            color: foregroundColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text('Sign in to your account'),
                      const SizedBox(height: 30),
                      myTextfield(
                        controller: _emailControler,
                        hintText: 'Email',
                        icon: Icons.email,
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 30),
                      myTextfield(
                        controller: _passwordControler,
                        hintText: 'Password',
                        icon: Icons.lock,
                        type: TextInputType.visiblePassword,
                        obscure: true,
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Need an account?',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                            ),
                          ),
                          const WidgetSpan(
                            child: SizedBox(
                              width: 5,
                            ),
                          ),
                          TextSpan(
                            text: 'Register here !',
                            style: const TextStyle(
                              fontSize: 12,
                              color: foregroundColor,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, signUpPageRoute);
                              },
                          ),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_emailControler.text == '') {
                            myDialog(
                              context: context,
                              title: 'Field tidak boleh kosong',
                              textButton1: 'OK',
                              textButton2: 'Cancel',
                              onPressed1: () {
                                Navigator.pop(context);
                              },
                              onPressed2: () {
                                Navigator.pop(context);
                              },
                            );
                          } else {
                            context.read<LoginBloc>().add(
                                  LoginButtonSubmitted(
                                    email: _emailControler.text,
                                    password: _passwordControler.text,
                                  ),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: foregroundColor,
                          foregroundColor: backgroundColor,
                          minimumSize: const Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style:
                              TextStyle(fontSize: 20, color: backgroundColor),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }
}
