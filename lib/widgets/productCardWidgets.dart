import 'package:curd_api_project/models/productModel.dart';
import 'package:flutter/material.dart';

class ProductCardWidgets extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Data product;
  const ProductCardWidgets({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
         product.img.toString()
        ),

        Text(product.productName.toString()),
        Text('Price: ${product.totalPrice} | QTY: ${product.qty}'),


        Row(
            children: [
              IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
              IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
            ]
        ),
      ],
    );
  }
}
