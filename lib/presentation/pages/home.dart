import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/data/utils/common/text_style.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_all_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/widgets/list_product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Future.microtask(() => [
          Provider.of<GetAllProductBloc>(context, listen: false).add(
            FetchAllProduct(),
          ),
        ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, searchPageRoute);
                    },
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.7,
                      // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(1, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Expanded(
                              child: Icon(Icons.search),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text('Search product'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/img/banner.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          children: [
                            _buildSubHeading(
                              title: 'Rekomendasi',
                              subtitle:
                                  'Suplier petani dari hasil bumi pilihan',
                              onTap: () {},
                            ),
                            BlocBuilder<GetAllProductBloc, GetAllProductState>(
                              builder: (context, state) {
                                if (state is GetAllProductLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GetAllProductHasData) {
                                  return Container(
                                    height: 200,
                                    padding: const EdgeInsets.all(8.0),
                                    child: ProductList(product: state.result),
                                  );
                                } else {
                                  return const Text('Failed');
                                }
                              },
                            ),
                            _buildSubHeading(
                              title: 'Sayur Organik',
                              subtitle:
                                  'Produk bebas pestisida dan bahan kimia',
                              onTap: () {},
                            ),
                            BlocBuilder<GetAllProductBloc, GetAllProductState>(
                              builder: (context, state) {
                                if (state is GetAllProductLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GetAllProductHasData) {
                                  final products = state.result
                                      .where((element) =>
                                          element.category == 'smartphones')
                                      .toList();
                                  return Container(
                                    height: 200,
                                    padding: const EdgeInsets.all(8.0),
                                    child: ProductList(product: products),
                                  );
                                } else {
                                  return const Text('Failed');
                                }
                              },
                            ),
                            _buildSubHeading(
                              title: 'Sayur Non-Organik',
                              subtitle:
                                  'Produk bebas pestisida dan bahan kimia',
                              onTap: () {},
                            ),
                            BlocBuilder<GetAllProductBloc, GetAllProductState>(
                              builder: (context, state) {
                                if (state is GetAllProductLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GetAllProductHasData) {
                                  final products = state.result
                                      .where((element) =>
                                          element.category == 'skincare')
                                      .toList();
                                  return Container(
                                    height: 200,
                                    padding: const EdgeInsets.all(8.0),
                                    child: ProductList(product: products),
                                  );
                                } else {
                                  return const Text('Failed');
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildSubHeading(
      {required String title,
      required String subtitle,
      required Function() onTap}) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: Text(
        subtitle,
        style: kSubtitle,
      ),
      trailing: InkWell(
        onTap: onTap,
        child: Text(
          'Lihat semua >',
          style: kButtonText,
        ),
      ),
    );
  }
}
