import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/data/utils/common/text_style.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/authentication/bloc/login_bloc.dart';
import 'package:tengkulak_sayur/presentation/authentication/widgets/my_textfield.dart';

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
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoginErrorState) {
            _myDialog(context, state.message);
          } else if (state is LoginSuccessState) {
            final user = state.result;
            Navigator.pushReplacementNamed(context, rootScreenRoute,
                arguments: user);
          }
        },
        child: SafeArea(
          child: ListView(
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
                          _myDialog(context, 'Field tidak boleh kosong');
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
                        style: TextStyle(fontSize: 20, color: foregroundColor),
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
    );
  }

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  Future<dynamic> _myDialog(BuildContext context, state) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          state,
          style: kHeading6,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
