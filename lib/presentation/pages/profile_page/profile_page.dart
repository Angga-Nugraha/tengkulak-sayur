import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/common/utils/constant.dart';
import 'package:tengkulak_sayur/data/common/styles/color.dart';
import 'package:tengkulak_sayur/data/common/styles/text_style.dart';
import 'package:tengkulak_sayur/data/common/utils/routes.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/presentation/bloc/authentication/auth_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/product/product_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/user/user_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/components/components_helpers.dart';
import 'package:tengkulak_sayur/presentation/widgets/product_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.uuid, super.key});
  final String uuid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static bool checkImage = false;
  @override
  void initState() {
    Future.microtask(() => [
          Provider.of<GetUserBloc>(context, listen: false)
              .add(SetUserById(uuid: widget.uuid)),
          Provider.of<ProductBloc>(context, listen: false)
              .add(FetchAllProduct()),
        ]);
    super.initState();
  }

  final menu = [
    {'title': 'Edit Profile', 'icon': const Icon(Icons.people)},
    {'title': 'Delete account', 'icon': const Icon(Icons.delete)},
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
      child: BlocListener<DeleteUserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadingState) {
            myLoading(context, 'Menghapus akun...');
          } else if (state is UserSuccessState) {
            Navigator.pop(context);
            myDialog(
              context: context,
              title: 'Akun di hapus',
              textButton1: '',
              textButton2: 'OK',
              onPressed1: () {},
              onPressed2: () {
                Navigator.pushReplacementNamed(context, loginPageRoute);
              },
            );
          } else if (state is UserErrorState) {
            Text(state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('MY PROFILE'),
            actions: [
              actions(),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
            children: [
              BlocBuilder<GetUserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SetUserState) {
                    var user = state.result;
                    checkImage = user.image?.isEmpty ?? true;

                    return Row(
                      children: [
                        Expanded(
                          child: checkImage
                              ? const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                    'assets/img/person.png',
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    '$baseUrl/user/${user.image}',
                                    scale: 1.0,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: kTitle,
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
                        ),
                      ],
                    );
                  } else if (state is UserErrorState) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Product',
                    style: kSubtitle,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Add Product',
                      style: kButtonText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductHasDataState) {
                    final product = state.result;
                    if (product.isEmpty) {
                      return const Text('You don\'t have an product');
                    } else {
                      return _listProduct(product);
                    }
                  } else if (state is ProductErrorState) {
                    final message = state.message;
                    return Text(message);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton<String> actions() {
    return PopupMenuButton(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onSelected: choiceAction,
        itemBuilder: (context) {
          return menu.map((e) {
            return PopupMenuItem<String>(
              padding: EdgeInsets.zero,
              value: e['title'].toString(),
              child: ListTile(
                leading: e['icon'] as Widget,
                title: Text(e['title'].toString()),
              ),
            );
          }).toList();
        });
  }

  void choiceAction(String value) {
    if (value == 'Logout') {
      myDialog(
          context: context,
          title: 'Anda Yakin Keluar?',
          textButton1: 'Yes',
          textButton2: 'No',
          onPressed1: () {
            context.read<LogoutBloc>().add(LogoutSubmitted());
          },
          onPressed2: () {
            Navigator.pop(context);
          });
    } else if (value == 'Delete account') {
      myDialog(
          context: context,
          title: 'Anda Yakin Hapus Akun?',
          textButton1: 'Hapus',
          textButton2: 'Cancel',
          onPressed1: () {
            context.read<DeleteUserBloc>().add(const DeleteAccount());
          },
          onPressed2: () {
            Navigator.pop(context);
          });
    } else {
      Navigator.pushNamed(context, editProfilePageRoute,
          arguments: widget.uuid);
    }
  }

  Container _listProduct(List<Product> product) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: product.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                flex: 7,
                child: ProductCard(
                  products: product[index],
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 20),
                  ),
                  child: const Text(
                    'Hapus',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Row _buildSubtitle({required String title, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Icon(
          icon,
          size: 15,
        )),
        const SizedBox(width: 5),
        Expanded(
          flex: 10,
          child: Text(
            title,
            style: kBodyText,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        ),
      ],
    );
  }
}
