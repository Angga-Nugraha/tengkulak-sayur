import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/data/utils/common/color.dart';
import 'package:tengkulak_sayur/data/utils/common/text_style.dart';
import 'package:tengkulak_sayur/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.result,
  }) : super(key: key);

  final List<Product> result;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final product = result[index];
          return InkWell(
            onTap: () {},
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                side: BorderSide(
                  width: 1,
                  color: Colors.white10,
                ),
              ),
              child: ListTile(
                iconColor: processColor,
                textColor: primaryColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    height: 100,
                    width: 80,
                    fit: BoxFit.fill,
                    imageUrl: product.thumbnail,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                title: Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star),
                        Text('${product.rating}'),
                      ],
                    ),
                    Text(
                      '\$${product.price}',
                      style: kHeading6,
                    ),
                  ],
                ),
                trailing: Card(
                  color: processColor,
                  child: Text(
                    'Discount ${product.discountPercentage.toString()}%',
                    style: kBodyText,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: result.length,
      ),
    );
  }
}
