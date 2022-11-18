import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/presentation/widgets/product_card.dart';

import '../bloc/search_product_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: foregroundColor,
              child: ListTile(
                contentPadding: const EdgeInsets.all(2),
                minVerticalPadding: 10,
                leading: IconButton(
                  color: backgroundColor,
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
                  child: TextField(
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Search product',
                      hintStyle: TextStyle(
                        fontSize: 14,
                      ),
                      prefixIconColor: foregroundColor,
                      prefixIcon: Icon(
                        Icons.search,
                        color: secondaryColor,
                        size: 20,
                      ),
                    ),
                    onChanged: (query) {
                      context
                          .read<SearchProductBloc>()
                          .add(OnQueryChanged(query));
                    },
                    textInputAction: TextInputAction.search,
                  ),
                ),
                trailing: IconButton(
                  color: backgroundColor,
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            const Text('Search result'),
            BlocBuilder<SearchProductBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHashData) {
                  final result = state.result;
                  return Expanded(
                    child: ProductCard(result: result),
                  );
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
}
