import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tengkulak_sayur/data/utils/styles/color.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/bloc/user/user_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/components/components_helpers.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameControler = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _confPasswordControler = TextEditingController();
  final TextEditingController _addresControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocListener<AddUserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadingState) {
            myLoading(context, 'Register...');
          } else if (state is UserErrorState) {
            Navigator.pop(context);
            myDialog(
                context: context,
                title: state.message,
                textButton1: '',
                textButton2: 'OK',
                onPressed1: () {},
                onPressed2: () {
                  if (state.message == 'Email sudah terdaftar') {
                    _emailControler.clear();
                  }
                  if (state.message ==
                      'Password dan ConfPassword tidak cocok') {
                    _passwordControler.clear();
                    _confPasswordControler.clear();
                  }
                  if (state.message == 'Registrasi berhasil') {
                    _nameControler.clear();
                    _emailControler.clear();
                    _passwordControler.clear();
                    _confPasswordControler.clear();
                    _addresControler.clear();
                  }
                  Navigator.pop(context);
                });
          } else if (state is UserSuccessState) {
            Navigator.pop(context);
            myDialog(
                context: context,
                title: "Registrasi Berhasil",
                textButton1: 'OK',
                textButton2: 'Login',
                onPressed1: () {
                  Navigator.pop(context);
                },
                onPressed2: () {
                  Navigator.pushNamed(context, loginPageRoute);
                });
          }
        },
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                width: 150,
                child: Lottie.asset(
                  'assets/img/login.json',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const Text(
                      'Let\'s Join with us...',
                      style: TextStyle(
                          fontFamily: 'Firasans',
                          fontSize: 25,
                          color: foregroundColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text('Create your account'),
                    const SizedBox(height: 20),
                    myTextfield(
                      controller: _nameControler,
                      hintText: "Name",
                      icon: Icons.person,
                      type: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    myTextfield(
                      controller: _emailControler,
                      hintText: "Email",
                      icon: Icons.email,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    myTextfield(
                        controller: _passwordControler,
                        hintText: "Password",
                        icon: Icons.lock,
                        type: TextInputType.visiblePassword,
                        obscure: true),
                    const SizedBox(height: 20),
                    myTextfield(
                        controller: _confPasswordControler,
                        hintText: "Confirm password",
                        icon: Icons.lock,
                        type: TextInputType.visiblePassword,
                        obscure: true),
                    const SizedBox(height: 20),
                    myTextfield(
                        controller: _addresControler,
                        hintText: "Address",
                        icon: Icons.location_on,
                        type: TextInputType.text),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_nameControler.text == '' ||
                            _emailControler.text == '' ||
                            _passwordControler.text == '' ||
                            _confPasswordControler.text == '' ||
                            _addresControler.text == '') {
                          myDialog(
                            context: context,
                            title: 'Field tidak boleh kosong',
                            textButton1: 'OK',
                            textButton2: 'Cancel',
                            onPressed1: () {
                              Navigator.pop(context);
                            },
                            onPressed2: () {
                              _nameControler.clear();
                              _emailControler.clear();
                              _passwordControler.clear();
                              _confPasswordControler.clear();
                              _addresControler.clear();
                              Navigator.pop(context);
                            },
                          );
                        } else {
                          context.read<AddUserBloc>().add(
                                SignUpButtonSubmitted(
                                  name: _nameControler.text,
                                  email: _emailControler.text,
                                  password: _passwordControler.text,
                                  confPassword: _confPasswordControler.text,
                                  addres: _addresControler.text,
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: foregroundColor,
                        minimumSize: const Size(120, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'SignUp',
                        style: TextStyle(fontSize: 20, color: backgroundColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'Have an account?',
                          style: TextStyle(color: primaryColor, fontSize: 12),
                        ),
                        const WidgetSpan(
                          child: SizedBox(
                            width: 5,
                          ),
                        ),
                        TextSpan(
                          text: 'Login here !',
                          style: const TextStyle(
                            color: foregroundColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, loginPageRoute);
                            },
                        ),
                      ]),
                    ),
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
    _nameControler.dispose();
    _emailControler.dispose();
    _passwordControler.dispose();
    _confPasswordControler.dispose();
    _addresControler.dispose();
    super.dispose();
  }
}
