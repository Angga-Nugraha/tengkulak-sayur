import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/data/common/utils/constant.dart';
import 'package:tengkulak_sayur/presentation/bloc/cart/cart_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('STORY TRANSACTION'),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartHasData) {
              final product = state.product;
              return SizedBox(
                height: double.infinity,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Material(
                      child: Column(
                        children: [
                          ListTile(
                            isThreeLine: true,
                            contentPadding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide.none),
                            leading: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: CachedNetworkImage(
                                height: 70,
                                width: 100,
                                fit: BoxFit.contain,
                                imageUrl:
                                    '$baseUrl/images/${product[index].image}',
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            title: Text(product[index].title),
                            subtitle:
                                Text('Rp.${product[index].price.toString()}'),
                          ),
                          const Divider(thickness: 1),
                        ],
                      ),
                    );
                  },
                  itemCount: product.length,
                ),
              );
            } else if (state is CartErrorState) {
              return Text(state.message);
            } else {
              return const Text('Failed');
            }
          },
        ));
  }
}
