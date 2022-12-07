import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/common/utils/routes.dart';
import 'package:tengkulak_sayur/data/common/styles/text_style.dart';
import 'package:tengkulak_sayur/presentation/bloc/cart/cart_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/product/product_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/components/components_helpers.dart';

import '../widgets/product_card.dart';

class DetailCategory extends StatefulWidget {
  final String category;
  const DetailCategory({super.key, required this.category});

  @override
  State<DetailCategory> createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  @override
  void initState() {
    Future.microtask(() => [
          Provider.of<CartBloc>(context, listen: false).add(const GetAllCart()),
          Provider.of<CategoryProductBloc>(context, listen: false).add(
            FetchCategoryProduct(widget.category),
          ),
        ]);
    super.initState();
  }

  static int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.toUpperCase()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Stack(
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
                        mySnackbar(context: context, message: state.message);
                      } else if (state is CartErrorState) {
                        mySnackbar(context: context, message: state.message);
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
                color: Colors.white,
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, cartPageRoute);
                },
              ),
            ],
          ),
          IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.notifications_none,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<CategoryProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductHasDataState) {
            final product = state.result;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: product.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: ProductCard(
                          products: product[index],
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<CartBloc>()
                              ..add(InsertToCart(product: product[index]))
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
                  ),
                );
              },
            );
          } else {
            return const Text(
              key: Key('error_message'),
              'Failed',
            );
          }
        },
      ),
    );
  }
}
