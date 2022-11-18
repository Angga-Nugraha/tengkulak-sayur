import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/utils/text_style.dart';
import 'package:tengkulak_sayur/presentation/bloc/get_all_product_bloc.dart';
import 'package:tengkulak_sayur/presentation/widgets/list_product.dart';

import '../../data/utils/color.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Future.microtask(
      () => Provider.of<GetAllProductBloc>(context, listen: false)
          .add(FetchAllProduct()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              size: 20,
            ),
          ),
        ],
        elevation: 2,
        title: Container(
          height: 30,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(1, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            style: const TextStyle(fontSize: 10),
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: 'Search product',
              hintStyle: kBodyText,
              prefixIcon: const Icon(
                Icons.search,
                size: 15,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/banner.png"),
                    fit: BoxFit.fill),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildSubHeading(
                    title: 'Rekomendasi',
                    subtitle: 'Suplier petani dari hasil bumi pilihan',
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
                          height: 190,
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
                    subtitle: 'Produk bebas pestisida dan bahan kimia',
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
                            .where(
                                (element) => element.category == 'smartphones')
                            .toList();
                        return Container(
                          height: 190,
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
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading(
      {required String title,
      required String subtitle,
      required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kHeading5,
            ),
            Text(
              subtitle,
              style: kSubtitle,
            ),
          ],
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            'Lihat semua >',
            style: kBodyText,
          ),
        ),
      ],
    );
  }
}
