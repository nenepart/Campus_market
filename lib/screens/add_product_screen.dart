import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product.dart';
import '../reusable_widgets/image_selector.dart';

class ProductForm extends StatefulWidget {
  final Product? product;

  const ProductForm({Key? key, this.product}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  late TextEditingController _nameController;
  late TextEditingController _ownerIdController;
  late TextEditingController _productStatusController;
  late List<XFile> images = [];

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.product?.name ?? "");
    _ownerIdController = TextEditingController(text: widget.product?.ownerId ?? "");
    _productStatusController = TextEditingController(text: widget.product?.productStatus.toString() ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ownerIdController.dispose();
    _productStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? "Add Product" : "Edit Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(
              onImagesSelected: (List<XFile> files) {
                images = files;
              },
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: _ownerIdController,
              decoration: InputDecoration(labelText: "Owner Id"),
            ),
            TextFormField(
              controller: _productStatusController,
              decoration: InputDecoration(labelText: "Product Status"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final product = Product(
                  name: _nameController.text,
                  ownerId: _ownerIdController.text,
                  productStatus: ProductSaleStatus.values.firstWhere(
                    (status) => status.toString() == _productStatusController.text,
                    orElse: () => ProductSaleStatus.inactive,
                  ),
                  dateCreated: DateTime.now(),
                  imagePaths: [],
                );

                if (widget.product == null) {
                  // Add product
                  // Call your ProductsRepository's addProduct method here
                } else {
                  // Update product
                  // Call your ProductsRepository's updateProduct method here
                }

                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
