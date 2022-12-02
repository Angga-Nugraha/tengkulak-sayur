import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/utils/common/text_style.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/bloc/authentication/auth_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/user/user_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.uuid, super.key});
  final String uuid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const baseUrl = "http://10.0.2.2:5000/user";
  @override
  void initState() {
    Future.microtask(
      () => Provider.of<GetUserBloc>(context, listen: false)
          .add(SetUserById(uuid: widget.uuid)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoadingState) {
          const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LogoutSuccessState) {
          Navigator.pushReplacementNamed(context, loginPageRoute);
        } else if (state is AuthenticationErrorState) {
          Text(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Profile'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.read<LogoutBloc>().add(LogoutSubmitted());
              },
              icon: const Icon(Icons.logout),
            ),
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
                final user = state.result;
                return SizedBox(
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
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
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildSubtitle(title: user.email, icon: Icons.email),
                          const SizedBox(height: 10),
                          _buildSubtitle(
                              title: user.addres,
                              icon: Icons.location_on_outlined),
                          const SizedBox(height: 30),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Edit',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Row _buildSubtitle({required String title, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        Text(
          '  $title',
          style: kHeading6,
        ),
      ],
    );
  }
}
