import 'package:flutter/material.dart';

class ProductCardWidgets extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const ProductCardWidgets({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          "https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630",
        ),
        
        Row(
          children: [
            IconButton(onPressed: onEdit, icon: Icon(Icons.edit))
          ],
        )
      ],
    );
  }
}
