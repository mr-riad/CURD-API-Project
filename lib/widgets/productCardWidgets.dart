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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.img ?? '',
                    height: constraints.maxHeight * 0.55,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 100),
                  ),
                ),

                const SizedBox(height: 8),

                // Product Name
                Text(
                  product.productName ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),

                // Price & Qty
                Text(
                  '৳${product.unitPrice} | Qty: ${product.qty}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),

                const Spacer(),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
