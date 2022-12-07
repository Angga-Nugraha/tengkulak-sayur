import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/data/utils/styles/color.dart';
import 'package:tengkulak_sayur/presentation/bloc/product/product_bloc.dart';
import 'package:tengkulak_sayur/presentation/widgets/product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          color: foregroundColor,
          child: ListTile(
            contentPadding: const EdgeInsets.all(2),
            minVerticalPadding: 10,
            leading: IconButton(
              color: Colors.white,
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            title: Container(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: 'Search product',
                  hintStyle: TextStyle(fontSize: 14, height: 1.2),
                  prefixIconColor: foregroundColor,
                  prefixIcon: Icon(
                    Icons.search,
                    color: secondaryColor,
                    size: 20,
                  ),
                ),
                onChanged: (query) {
                  context.read<SearchProductBloc>().add(OnQueryChanged(query));
                },
                textInputAction: TextInputAction.search,
              ),
            ),
            trailing: IconButton(
              color: Colors.white,
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const Center(child: Text('Search result')),
            BlocBuilder<SearchProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProductHasDataState) {
                  final result = state.result;
                  if (result.isEmpty) {
                    return const Text('Product not found');
                  } else {
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            products: result[index],
                          );
                        },
                      ),
                    );
                  }
                } else if (state is ProductErrorState) {
                  return Text(state.message);
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
