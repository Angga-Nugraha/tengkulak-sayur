import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/presentation/bloc/product/product_bloc.dart';

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
    Future.microtask(
      () => Provider.of<CategoryProductBloc>(context, listen: false).add(
        FetchCategoryProduct(widget.category),
      ),
    );
    super.initState();
  }

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
          IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
            onPressed: () {},
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
                return ProductCard(
                  products: product[index],
                  textButton: 'Tambah',
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
