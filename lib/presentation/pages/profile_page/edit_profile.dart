import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/common/styles/color.dart';
import 'package:tengkulak_sayur/presentation/bloc/user/user_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/components/components_helpers.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({required this.uuid, super.key});

  final String uuid;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _imageFile;
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<GetUserBloc>(context, listen: false)
        .add(SetUserById(uuid: widget.uuid)));
  }

  _getOnGalery() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1500,
      maxWidth: 1000,
    );
    setState(() {
      _imageFile = File(image!.path);
    });
  }

  _getOnCamera() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1500,
      maxWidth: 1000,
    );
    setState(() {
      _imageFile = File(image!.path);
    });
  }

  late TextEditingController _nameControler;
  late TextEditingController _emailControler;
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _confPasswordControler = TextEditingController();
  late TextEditingController _addresControler;

  @override
  void dispose() {
    super.dispose();
    _nameControler.dispose();
    _emailControler.dispose();
    _passwordControler.dispose();
    _confPasswordControler.dispose();
    _addresControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditUserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoadingState) {
          myLoading(context, 'Editing');
        }
        if (state is UserErrorState) {
          Navigator.pop(context);
          myDialog(
              context: context,
              title: state.message,
              textButton1: '',
              textButton2: 'OK',
              onPressed1: () {},
              onPressed2: () {
                Navigator.pop(context);
              });
        }
        if (state is UserSuccessState) {
          Navigator.pop(context);
          myDialog(
              context: context,
              title: 'User Updated',
              textButton1: '',
              textButton2: 'OK',
              onPressed1: () {},
              onPressed2: () {
                Navigator.pop(context);
              });
        }
      },
      child: BlocBuilder<GetUserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SetUserState) {
            var user = state.result;
            _nameControler = TextEditingController(text: user.name);
            _emailControler = TextEditingController(text: user.email);
            _addresControler = TextEditingController(text: user.addres);
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('Edit Profile'),
              ),
              body: ListView(
                padding: const EdgeInsets.all(15.0),
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _imageFile == null
                            ? const CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage(
                                  'assets/img/person.png',
                                ),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(
                                  File(_imageFile!.path),
                                ),
                              ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 120,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _getOnGalery();
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.photo,
                                              size: 50,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Galery',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _getOnCamera();
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.camera_alt,
                                              size: 50,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Camera',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white60,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  myTextfield(
                      controller: _nameControler,
                      hintText: 'Name',
                      icon: Icons.person,
                      type: TextInputType.name),
                  const SizedBox(height: 20),
                  myTextfield(
                      controller: _emailControler,
                      hintText: 'Email',
                      icon: Icons.email,
                      type: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  myTextfield(
                      controller: _passwordControler,
                      hintText: 'Password',
                      icon: Icons.lock,
                      obscure: true,
                      type: TextInputType.visiblePassword),
                  const SizedBox(height: 20),
                  myTextfield(
                      controller: _confPasswordControler,
                      hintText: 'Confim Password',
                      icon: Icons.lock,
                      obscure: true,
                      type: TextInputType.visiblePassword),
                  const SizedBox(height: 20),
                  myTextfield(
                      controller: _addresControler,
                      hintText: 'Address',
                      icon: Icons.location_on_outlined,
                      type: TextInputType.multiline),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          myDialog(
                              context: context,
                              title: 'Upadate Profile?',
                              textButton1: 'Update',
                              textButton2: 'Cancel',
                              onPressed1: () {
                                context.read<EditUserBloc>().add(
                                      EditUserSubmit(
                                        name: _nameControler.text,
                                        email: _emailControler.text,
                                        password: _passwordControler.text,
                                        confPassword:
                                            _confPasswordControler.text,
                                        addres: _addresControler.text,
                                        image: _imageFile,
                                      ),
                                    );
                                Navigator.pop(context);
                              },
                              onPressed2: () {
                                Navigator.pop(context);
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: foregroundColor,
                          foregroundColor: backgroundColor,
                          minimumSize: const Size(100, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Edit',
                          style:
                              TextStyle(fontSize: 20, color: backgroundColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 40),
                          backgroundColor: foregroundColor,
                          foregroundColor: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style:
                              TextStyle(fontSize: 20, color: backgroundColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
