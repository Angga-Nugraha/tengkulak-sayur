import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/bloc/authentication/auth_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/components/helpers.dart';
import 'package:tengkulak_sayur/presentation/widgets/my_textfield.dart';

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
      backgroundColor: foregroundColor,
      body: BlocListener<LoginBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is LoadingState) {
            myLoading(context, 'Checking...');
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
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      MyTextField(
                        controller: _emailControler,
                        hintText: 'Email',
                        icon: Icons.email,
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 30),
                      MyTextField(
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                      // message,
                      const SizedBox(height: 30),
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
                          backgroundColor: Colors.white,
                          minimumSize: const Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style:
                              TextStyle(fontSize: 20, color: foregroundColor),
                        ),
                      ),
                      const SizedBox(height: 50),
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
