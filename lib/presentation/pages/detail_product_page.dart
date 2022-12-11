import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/styles/color.dart';
import 'package:tengkulak_sayur/data/styles/text_style.dart';
import 'package:tengkulak_sayur/data/utils/constant.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/bloc/cart/cart_bloc.dart';
import 'package:tengkulak_sayur/presentation/bloc/product/product_bloc.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({required this.id, super.key});

  final int id;

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          Provider.of<CartBloc>(context, listen: false).add(const GetAllCart()),
          Provider.of<GetProductIdBloc>(context, listen: false)
              .add(FetchIdProduct(widget.id))
        ]);
  }

  var count = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductIdBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductErrorState) {
          return Text(state.message);
        } else if (state is ProductIdHasDataState) {
          final product = state.result;
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: '$baseUrl/images/${product.image}',
                          width: MediaQuery.of(context).size.width,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: backgroundColor,
                          foregroundColor: foregroundColor,
                          child: IconButton(
                            splashRadius: 25,
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
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
                                child: BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                    if (state is CartHasData) {
                                      final length = state.product.length;
                                      count = length;
                                      return Text(
                                        length.toString(),
                                        style: const TextStyle(
                                            color: backgroundColor,
                                            fontSize: 10),
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
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: 500,
                      decoration: BoxDecoration(
                        color: foregroundColor.withOpacity(0.2),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 16,
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(5.0),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: kTitle,
                                  ),
                                  Text(
                                    'Rp.${product.price.toString()}',
                                    style: kHeading6,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: processColor,
                                  ),
                                  Text(
                                    product.ratting.toString(),
                                    style: kHeading6,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Description',
                            style: kHeading6,
                          ),
                          Text(
                            '${product.description}',
                            style: kBodyText,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Stock: ${product.stock}',
                            style: kBodyText,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Weight: ${product.weight} kg',
                            style: kBodyText,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: backgroundColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.discount_outlined,
                                  size: 25,
                                ),
                                Text(
                                  'Discount up to ${(product.discount! * 100)} %',
                                  style: kSubtitle,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: foregroundColor,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  context.read<CartBloc>()
                    ..add(InsertToCart(product: product))
                    ..add(const GetAllCart());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                      color: backgroundColor,
                    ),
                    Text(
                      'Add to cart',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Text('');
        }
      },
    );
  }
}
