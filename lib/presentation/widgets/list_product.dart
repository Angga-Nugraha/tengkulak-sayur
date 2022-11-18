import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/data/utils/color.dart';
import 'package:tengkulak_sayur/data/utils/text_style.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> product;

  const ProductList({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: product.length,
        itemBuilder: (context, index) {
          final products = product[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          child: CachedNetworkImage(
                            height: 70,
                            width: 100,
                            fit: BoxFit.fill,
                            imageUrl: products.thumbnail,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            textDirection: TextDirection.ltr,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  products.title,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Card(
                                color: processColor,
                                child: Text(
                                  'Discount ${products.discountPercentage.toString()}%',
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '\$${products.price}',
                                  style: kHeading6,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: foregroundColor,
                      minimumSize: const Size(100.0, 20.0),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Tambah',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
