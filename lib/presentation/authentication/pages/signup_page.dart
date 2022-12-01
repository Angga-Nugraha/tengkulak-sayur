import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/data/utils/common/text_style.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/authentication/bloc/signup_bloc.dart';
import 'package:tengkulak_sayur/presentation/authentication/widgets/my_textfield.dart';

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
      backgroundColor: foregroundColor,
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoadingState) {
            const CircularProgressIndicator();
          } else if (state is SignUpErrorState) {
            _myDialog(context, state.message);
          } else if (state is SignUpSuccessState) {
            _myDialog(context, 'Registrasi berhasil');
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
                    MyTextField(
                      controller: _nameControler,
                      hintText: "Name",
                      icon: Icons.person,
                      type: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: _emailControler,
                      hintText: "Email",
                      icon: Icons.email,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                        controller: _passwordControler,
                        hintText: "Password",
                        icon: Icons.lock,
                        type: TextInputType.visiblePassword,
                        obscure: true),
                    const SizedBox(height: 20),
                    MyTextField(
                        controller: _confPasswordControler,
                        hintText: "Confirm password",
                        icon: Icons.lock,
                        type: TextInputType.visiblePassword,
                        obscure: true),
                    const SizedBox(height: 20),
                    MyTextField(
                        controller: _addresControler,
                        hintText: "Address",
                        icon: Icons.location_on,
                        type: TextInputType.text),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () async {
                        if (_nameControler.text == '') {
                          _myDialog(context, 'Field tidak boleh kosong');
                        } else {
                          context.read<SignUpBloc>().add(
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
                        backgroundColor: Colors.white,
                        minimumSize: const Size(120, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'SignUp',
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
              Navigator.pushNamed(context, loginPageRoute);
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              if (state == 'Email sudah terdaftar') {
                _emailControler.clear();
              }
              if (state == 'Password dan ConfPassword tidak cocok') {
                _passwordControler.clear();
                _confPasswordControler.clear();
              }
              if (state == 'Registrasi berhasil') {
                _nameControler.clear();
                _emailControler.clear();
                _passwordControler.clear();
                _confPasswordControler.clear();
                _addresControler.clear();
              }
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
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
