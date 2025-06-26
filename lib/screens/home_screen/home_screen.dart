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
    productQtyController.text = qty != null ? qty.toString() : '0';
    productUnitPriceController.text = unitPrice != null ? qty.toString() : '0';
    productTotalPriceController.text =
        totalPrice != null ? qty.toString() : '0';

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add product'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldButton(
                    buttonText: 'Enter Product Name',
                    controller: productNameController,
                  ),
                  TextFieldButton(
                    buttonText: 'Enter Product Img URL',
                    controller: productImgController,
                  ),
                  TextFieldButton(
                    buttonText: 'Enter Product Quantity',
                    controller: productQtyController,
                  ),
                  TextFieldButton(
                    buttonText: 'Enter Product Unit Price',
                    controller: productUnitPriceController,
                  ),
                  TextFieldButton(
                    buttonText: 'Enter Product Total Price',
                    controller: productTotalPriceController,
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
                          await productController.createProduct(
                            productNameController.text,
                            productImgController.text,
                            int.tryParse(productQtyController.text.trim()) ?? 0,
                            int.tryParse(
                                  productUnitPriceController.text.trim(),
                                ) ??
                                0,
                            int.tryParse(
                                  productTotalPriceController.text.trim(),
                                ) ??
                                0,
                          );
                          Navigator.pop(context);
                          await productController.fetchProduct();
                          setState(() {});
                        },
                        child: const Text("Confirm"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = productController.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product CRUD",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body:
          products.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return ProductCardWidgets(
                      product: product,
                      onEdit: () {
                        productDialog();
                      },
                      onDelete: () async {
                        bool success = await productController.DeleteProduct(
                          product.sId.toString(),
                        );
                        if (success) {
                          await productController.fetchProduct();
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Product Deleted")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Something went wrong"),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: productDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
