import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/data/utils/common/text_style.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/bloc/authentication/auth_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/user/user_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/components/helpers.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.uuid, super.key});
  final String uuid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const baseUrl = "http://10.0.2.2:5000/user";
  static bool checkImage = false;
  @override
  void initState() {
    Future.microtask(
      () => Provider.of<GetUserBloc>(context, listen: false)
          .add(SetUserById(uuid: widget.uuid)),
    );
    super.initState();
  }

  final menu = [
    {'title': 'Edit Profile', 'icon': const Icon(Icons.people)},
    {'title': 'Logout', 'icon': const Icon(Icons.logout)}
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoadingState) {
          myLoading(context, 'Logout...');
        } else if (state is LogoutSuccessState) {
          Navigator.pushReplacementNamed(context, loginPageRoute);
        } else if (state is AuthenticationErrorState) {
          Text(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // title: const Text('PROFIL'),
          actions: [
            actions(),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<GetUserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SetUserState) {
                var user = state.result;
                checkImage = user.image?.isEmpty ?? true;

                return SizedBox(
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                checkImage
                                    ? const CircleAvatar(
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                          'assets/img/person.png',
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                          '$baseUrl/${user.image}',
                                        ),
                                      ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white60,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildSubtitle(
                                    title: user.email, icon: Icons.email),
                                const SizedBox(height: 10),
                                _buildSubtitle(
                                    title: user.addres,
                                    icon: Icons.location_on_outlined),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is UserErrorState) {
                return Text(state.message);
              } else {
                return const Text('Failed');
              }
            },
          ),
        ),
      ),
    );
  }

  PopupMenuButton<String> actions() {
    return PopupMenuButton(
        color: backgroundColor,
        onSelected: choiceAction,
        itemBuilder: (context) {
          return menu.map((e) {
            return PopupMenuItem<String>(
                value: e['title'].toString(),
                child: ListTile(
                    leading: e['icon'] as Widget,
                    title: Text(e['title'].toString())));
          }).toList();
        });
  }

  void choiceAction(String value) {
    if (value == 'Logout') {
      myDialog(
          context: context,
          title: 'Anda Yakin Keluar',
          textButton1: 'Yes',
          textButton2: 'No',
          onPressed1: () {
            context.read<LogoutBloc>().add(LogoutSubmitted());
          },
          onPressed2: () {
            Navigator.pop(context);
          });
    } else if (value == 'Edit Profile') {
      print('context');
    }
  }

  Row _buildSubtitle({required String title, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        Text(
          '  $title',
          style: kHeading6,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
