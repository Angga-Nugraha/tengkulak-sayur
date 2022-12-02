import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';
import 'package:tengkulak_sayur/presentation/bloc/product/product_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<CategoryPage> {
  @override
  void initState() {
    Future.microtask(
      () => Provider.of<ProductBloc>(context, listen: false)
          .add(FetchAllProduct()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('KATEGORI PRODUK'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductHasDataState) {
            final categories =
                state.result.map((element) => element.category).toSet();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: AssetImage("assets/category_img/$index.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Center(
                        child: Text(
                          categories.elementAt(index),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, detailCategoryPageRoute,
                          arguments: categories.elementAt(index));
                    },
                  );
                },
                itemCount: categories.length,
              ),
            );
          } else {
            return const Text('Failed');
          }
        },
      ),
    );
  }
}
