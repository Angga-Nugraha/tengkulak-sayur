// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:tengkulak_sayur/data/utils/common/color.dart';
// import 'package:tengkulak_sayur/presentation/bloc/get_category_product.dart';

// import '../widgets/product_card.dart';

// class DetailCategory extends StatefulWidget {
//   final String category;
//   const DetailCategory({super.key, required this.category});

//   @override
//   State<DetailCategory> createState() => _DetailCategoryState();
// }

// class _DetailCategoryState extends State<DetailCategory> {
//   @override
//   void initState() {
//     Future.microtask(
//         () => Provider.of<CategoryProductBloc>(context, listen: false).add(
//               FetchData(widget.category),
//             ));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.category.toUpperCase()),
//         actions: [
//           IconButton(
//             color: backgroundColor,
//             icon: const Icon(
//               Icons.shopping_cart_outlined,
//             ),
//             onPressed: () {},
//           ),
//           IconButton(
//             color: backgroundColor,
//             icon: const Icon(
//               Icons.notifications_none,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: BlocBuilder<CategoryProductBloc, CategoryState>(
//         builder: (context, state) {
//           if (state is CategoryLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is CategoryHasData) {
//             final product = state.result;
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 childAspectRatio: 0.7,
//                 crossAxisSpacing: 5,
//                 mainAxisSpacing: 10,
//               ),
//               physics: const BouncingScrollPhysics(),
//               itemCount: product.length,
//               itemBuilder: (context, index) {
//                 return ProductCard(products: product[index]);
//               },
//             );
//           } else {
//             return const Text(
//               key: Key('error_message'),
//               'Failed',
//             );
//           }
//         },
//       ),
//     );
//   }
// }
