import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tengkulak_sayur/data/common/utils/constant.dart';
import 'package:tengkulak_sayur/data/common/styles/text_style.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';
import 'package:tengkulak_sayur/presentation/bloc/cart/cart_bloc.dart';
import 'package:tengkulak_sayur/presentation/pages/components/components_helpers.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<CartBloc>(context, listen: false).add(const GetAllCart()));
    super.initState();
  }

  double totalAmount = 0;
  void calculateItem(List<Product> product) {
    double total = 0;

    for (var element in product) {
      total = total + element.price * element.quantity;
    }
    totalAmount = total;
  }

  List<Product> listProduct = [];
  List<Product> selectedProduct = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartHasData) {
          calculateItem(selectedProduct);
        }
        if (state is CartAddedState) {
          calculateItem(selectedProduct);
        }
        if (state is CartRemoveState) {
          calculateItem(selectedProduct);
        }
      },
      builder: (context, state) {
        if (state is CartHasData) {
          listProduct = state.product;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Shopping Cart'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: listProduct.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your cart is empty :(',
                        style: kSubtitle,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Lets buy some item'),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final product = listProduct[index];
                      return Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ListTile(
                                isThreeLine: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide.none),
                                leading: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl:
                                        '$baseUrl/images/${product.image}',
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                title: Text(
                                  product.title,
                                  style: kSubtitle,
                                ),
                                subtitle: Text(
                                  'Rp.${product.price.toString()}',
                                  style: kBodyText,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 35,
                                child: Checkbox(
                                  value: selectedProduct.contains(product),
                                  onChanged: (val) {
                                    setState(() {
                                      if (val!) {
                                        selectedProduct.add(product);
                                        calculateItem(selectedProduct);
                                      } else {
                                        selectedProduct.remove(product);
                                        calculateItem(selectedProduct);
                                      }
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (product.quantity > 0) {
                                        setState(() {
                                          product.quantity--;
                                          calculateItem(selectedProduct);
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.remove_circle),
                                  ),
                                  Text(product.quantity.toString()),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        context.read<CartBloc>().add(
                                            AddedItemcart(product: product));
                                        product.quantity++;
                                        calculateItem(selectedProduct);
                                      });
                                    },
                                    icon: const Icon(Icons.add_circle),
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 0,
                                top: -10,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedProduct.remove(product);
                                        context.read<CartBloc>().add(
                                            RemoveItemCart(product: product));
                                        listProduct.removeAt(index);
                                        calculateItem(listProduct);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.black,
                                    )),
                              )
                            ],
                          ),
                          const Divider(thickness: 1),
                        ],
                      );
                    },
                    itemCount: listProduct.length,
                  ),
                ),
          bottomNavigationBar: Container(
            height: 68,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 8,
                    color: const Color(0xFF000000).withOpacity(0.20),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                )),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        'Total Amount',
                        style: kHeading6,
                      )),
                      Expanded(
                          child: Text(
                        'Rp.${totalAmount.toStringAsFixed(2)}',
                        style: kHeading6,
                      )),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedProduct.isEmpty) {
                        myDialog(
                          context: context,
                          title:
                              'Please select a product if you want to checkout',
                          textButton1: '',
                          textButton2: 'OK',
                          onPressed1: () {},
                          onPressed2: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
