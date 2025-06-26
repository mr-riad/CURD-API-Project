import 'package:curd_api_project/widgets/productController.dart';
import 'package:flutter/material.dart';

import '../../widgets/productCardWidgets.dart';
import '../../widgets/text_field_button.dart';

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
    setState(() {
      productController.fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    void productDialog() {
      TextEditingController productNameController = TextEditingController();
      TextEditingController productQtyController = TextEditingController();
      TextEditingController productImgController = TextEditingController();
      TextEditingController productUnitPriceController =
          TextEditingController();
      TextEditingController productTotalPriceController =
          TextEditingController();

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Add product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldButton(buttonText: 'Enter Product Name'),
                  TextFieldButton(buttonText: 'Enter Product Img Urls'),
                  TextFieldButton(buttonText: 'Enter Product Quantity'),
                  TextFieldButton(buttonText: 'Enter Product Unit Price'),
                  TextFieldButton(buttonText: 'Enter Product Total Price'),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(onPressed: () {
                        productController.createProduct(
                            productNameController.text,
                            productImgController.text,
                            int.parse(productQtyController.text.trim()) ,
                            int.parse(productUnitPriceController.text.trim()),
                            int.parse(productTotalPriceController.text.trim()));
                      }, child: Text("Confrom")),
                    ],
                  ),
                ],
              ),
            ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product CURD",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          var product = productController.products[index];
          return ProductCardWidgets(
            onEdit: () {
              productDialog();
            },
            onDelete: () {
              productController.DeleteProduct(product.sId.toString()).then((value)async{
                if(value){
                  await productController.fetchProduct();
                  setState(() {

                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Product Deleted"),
                    duration: Duration(seconds: 2),)
                  );
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something wrong"),
                        duration: Duration(seconds: 2),)
                  );
                }

              });
            },
            product: product,
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
