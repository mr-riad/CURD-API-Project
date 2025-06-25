import 'package:flutter/material.dart';

import '../../widgets/productCardWidgets.dart';
import '../../widgets/text_field_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void productDialog() {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productImgController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

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
                    TextButton(onPressed: () {}, child: Text("Confrom")),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return ProductCardWidgets(
            onEdit: () {
              productDialog();
            },
            onDelete: () {

            },

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
