import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../constants/constants/string_constants.dart';

class ProductListTilesWidget extends StatelessWidget {
  const ProductListTilesWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(StringConstants.barcodeText + product.barcode),
        ),
        ListTile(
          title: Text(StringConstants.categoryText + product.category),
        ),
        ListTile(
          title: Text(StringConstants.brandText + product.brand),
        ),
        ListTile(
          title: Text(StringConstants.typeText + product.type),
        ),
        ListTile(
          title:
              Text(StringConstants.quantityText + product.quantity.toString()),
        ),
      ],
    );
  }
}
