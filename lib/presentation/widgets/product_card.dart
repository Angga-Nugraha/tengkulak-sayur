import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/data/common/utils/constant.dart';
import 'package:tengkulak_sayur/data/common/styles/color.dart';
import 'package:tengkulak_sayur/data/common/styles/text_style.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.products,
  }) : super(key: key);

  final Product products;

  @override
  Widget build(BuildContext context) {
    var disc = products.discount ?? 0;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: CachedNetworkImage(
              height: 70,
              width: 100,
              fit: BoxFit.contain,
              imageUrl: '$baseUrl/images/${products.image}',
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(
            child: Text(
              products.title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Card(
              color: processColor,
              child: Center(
                child: Text(
                  'Discount ${(disc * 100).toString()} %',
                  style: kButtonText,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Rp.${products.price}',
              style: kHeading6,
            ),
          ),
        ],
      ),
    );
  }
}
