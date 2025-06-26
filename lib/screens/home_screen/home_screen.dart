import 'package:flutter/material.dart';
import '../../widgets/productCardWidgets.dart';
import '../../widgets/text_field_button.dart';
import '../../widgets/productController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    productController.fetchProduct().then((_) {
      setState(() {});
    });
  }

  void productDialog(
      String? id,
      String? name,
      String? img,
      int? qty,
      int? unitPrice,
      int? totalPrice,
      ) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productImgController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    productNameController.text = name ?? '';
    productImgController.text = img ?? '';
    productQtyController.text = qty?.toString() ?? '0';
    productUnitPriceController.text = unitPrice?.toString() ?? '0';
    productTotalPriceController.text = totalPrice?.toString() ?? '0';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Add Product' : 'Update Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldButton(
                buttonText: 'Enter Product Name',
                controller: productNameController,
                labelText: 'Product Name',
              ),
              TextFieldButton(
                buttonText: 'Enter Product Img URL',
                controller: productImgController,
                labelText: 'Product Image URL',
              ),
              TextFieldButton(
                buttonText: 'Enter Product Quantity',
                controller: productQtyController,
                labelText: 'Quantity',
              ),
              TextFieldButton(
                buttonText: 'Enter Product Unit Price',
                controller: productUnitPriceController,
                labelText: 'Unit Price',
              ),
              TextFieldButton(
                buttonText: 'Enter Product Total Price',
                controller: productTotalPriceController,
                labelText: 'Total Price',
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final name = productNameController.text.trim();
                      final img = productImgController.text.trim();
                      final qty = int.tryParse(productQtyController.text.trim()) ?? 0;
                      final unitPrice = int.tryParse(productUnitPriceController.text.trim()) ?? 0;
                      final totalPrice = int.tryParse(productTotalPriceController.text.trim()) ?? 0;

                      if (id == null) {
                        await productController.createProduct(name, img, qty, unitPrice, totalPrice);
                      } else {
                        await productController.updateProduct(id, name, img, qty, unitPrice, totalPrice);
                      }

                      Navigator.pop(context);
                      await productController.fetchProduct();
                      setState(() {});
                    },
                    child: Text(id == null ? "Add" : "Update"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int calculateCrossAxisCount(double width) {
    if (width < 400) return 2;
    if (width < 600) return 2;
    if (width < 900) return 3;
    if (width < 1200) return 4;
    return 5;
  }

  double calculateChildAspectRatio(double width) {
    if (width < 400) return 0.68;
    if (width < 600) return 0.7;
    if (width < 900) return 0.75;
    if (width < 1200) return 0.8;
    return 0.9;
  }

  @override
  Widget build(BuildContext context) {
    final products = productController.products;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product CRUD",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: calculateCrossAxisCount(screenWidth),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: calculateChildAspectRatio(screenWidth),
          ),
          itemBuilder: (context, index) {
            var product = products[index];
            return ProductCardWidgets(
              product: product,
              onEdit: () {
                productDialog(
                  product.sId,
                  product.productName,
                  product.img,
                  product.qty,
                  product.unitPrice,
                  product.totalPrice,
                );
              },
              onDelete: () async {
                bool success = await productController.DeleteProduct(product.sId.toString());
                if (success) {
                  await productController.fetchProduct();
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Product Deleted")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Something went wrong")),
                  );
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(null, null, null, null, null, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
