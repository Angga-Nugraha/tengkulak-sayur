import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tengkulak_sayur/data/utils/styles/text_style.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/presentation/bloc/cart/cart_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/product/product_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/components/components_helpers.dart';
import 'package:tengkulak_sayur/presentation/widgets/search_bar.dart';
import 'package:tengkulak_sayur/presentation/widgets/product_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Future.microtask(() => [
          Provider.of<CartBloc>(context, listen: false).add(const GetAllCart()),
          Provider.of<ProductBloc>(context, listen: false)
              .add(FetchAllProduct()),
        ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var count = 0;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(
                flex: 7,
                child: Searchbar(),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red,
                      ),
                      child: Center(
                        child: BlocConsumer<CartBloc, CartState>(
                          listener: (context, state) {
                            if (state is CartSuccessState) {
                              mySnackbar(
                                  context: context, message: state.message);
                            } else if (state is CartErrorState) {
                              mySnackbar(
                                  context: context, message: state.message);
                            }
                          },
                          builder: (context, state) {
                            if (state is CartHasData) {
                              final length = state.product.length;
                              count = length;
                              return Text(
                                length.toString(),
                                style: kButtonText,
                              );
                            } else {
                              return Text(
                                count.toString(),
                                style: kButtonText,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, cartPageRoute);
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                      ),
                    ),
                  ],
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
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                children: [
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                              image: AssetImage("assets/img/banner.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ProductHasDataState) {
                            final recomendationProduct = state.result
                                .where((element) => element.ratting! > 4.0)
                                .toList();

                            final organik = state.result
                                .where(
                                    (element) => element.category == 'Organik')
                                .toList();

                            final nonorganik = state.result
                                .where((element) =>
                                    element.category == 'Non-Organik')
                                .toList();

                            return Column(
                              children: [
                                _buildSubHeading(
                                  title: 'Rekomendasi',
                                  subtitle:
                                      'Kami rekomendasikan produk yang cukup popular saat ini',
                                  trailing: 'Lihat semua >',
                                  onTap: () {},
                                ),
                                _listProduct(recomendationProduct),
                                _buildSubHeading(
                                  title: 'Sayur Organik',
                                  subtitle:
                                      'Produk bebas pestisida dan bahan kimia',
                                  trailing: 'Lihat semua >',
                                  onTap: () {
                                    final category = organik[0].category;
                                    Navigator.pushNamed(
                                        context, detailCategoryPageRoute,
                                        arguments: category);
                                  },
                                ),
                                _listProduct(organik),
                                _buildSubHeading(
                                  title: 'Sayur Non-Organik',
                                  subtitle: 'Produk dengan kualitas terbaik',
                                  trailing: 'Lihat semua >',
                                  onTap: () {
                                    final category = nonorganik[0].category;
                                    Navigator.pushNamed(
                                        context, detailCategoryPageRoute,
                                        arguments: category);
                                  },
                                ),
                                _listProduct(nonorganik),
                              ],
                            );
                          } else if (state is ProductErrorState) {
                            final message = state.message;
                            return Text(message);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _listProduct(List<Product> product) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: product.length,
        itemBuilder: (context, index) {
          final products = product[index];
          return Column(
            children: [
              Expanded(
                flex: 7,
                child: ProductCard(
                  products: products,
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>()
                      ..add(InsertToCart(product: products))
                      ..add(const GetAllCart());
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 20),
                  ),
                  child: const Text(
                    'Tambah',
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

  ListTile _buildSubHeading(
      {required String title,
      required String subtitle,
      required trailing,
      required Function() onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: kTitle,
      ),
      subtitle: Text(
        subtitle,
        style: kBodyText,
      ),
      trailing: TextButton(
        onPressed: onTap,
        child: const Text('See all...'),
      ),
    );
  }
}
