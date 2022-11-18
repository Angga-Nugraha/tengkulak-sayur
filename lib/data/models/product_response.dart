import 'package:equatable/equatable.dart';
import 'package:tengkulak_sayur/data/models/product_model.dart';

class ProductResponse extends Equatable {
  final List<ProductModel> productList;
  const ProductResponse({required this.productList});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        productList: List<ProductModel>.from((json["products"] as List)
            .map((x) => ProductModel.fromJson(x))
            .where((element) => element.discountPercentage != null)),
      );
  Map<String, dynamic> toJson() => {
        'products': List<dynamic>.from(productList.map((e) => e.toJson())),
      };

  @override
  List<Object?> get props => [productList];
}
