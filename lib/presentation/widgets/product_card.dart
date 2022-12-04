import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/data/utils/common/text_style.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.products,
    required this.textButton,
  }) : super(key: key);

  final Product products;
  final String textButton;
  static const _baseUrl = "http://10.0.2.2:5000/images";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
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
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: CachedNetworkImage(
                        height: 70,
                        width: 100,
                        fit: BoxFit.contain,
                        imageUrl: '$_baseUrl/${products.image}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
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
                          Expanded(
                            child: Card(
                              color: processColor,
                              child: Text(
                                'Discount ${(products.discount * 100).toString()} %',
                                style: kButtonText,
                              ),
                            ),
                          ),
                          Text(
                            'Rp.${products.price}',
                            style: kHeading6,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // const SizedBox(height: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                textButton,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
