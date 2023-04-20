import 'package:campus_market/repositories/products_repo.dart';
import 'package:campus_market/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  late TextEditingController _productPriceController;
  late TextEditingController _descriptionController;
  List<XFile> images = [];
  ProductType productType = ProductType.electronics;
  late ProductsRepo productsRepo;

  late UserRepo _userRepo;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.product?.name ?? "");
    _descriptionController = TextEditingController(text: widget.product?.description ?? "");
    _productPriceController = TextEditingController(text: widget.product?.price.toString() ?? "0.00");
    productType = widget.product?.type ?? ProductType.electronics;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _userRepo = context.watch();
    productsRepo = context.watch<ProductsRepo>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? "Add Product" : "Edit Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "What type of item are you selling??",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              DropdownMenu(
                dropdownMenuEntries: ProductType.values.map((e) => DropdownMenuEntry(value: e, label: e.name.toString())).toList(),
                initialSelection: productType,
                onSelected: (value) {
                  if (value != null) {
                    productType = value;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Add images",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ImageCarousel(
                imagePaths: widget.product?.imagePaths,
                onImagesSelected: (List<XFile> files) {
                  images = files;
                },
              ),
              TextFormField(
                controller: _nameController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: "Item name",
                  alignLabelWithHint: true,
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Item Description"),
              ),
              TextFormField(
                controller: _productPriceController,
                decoration: const InputDecoration(labelText: "Price", prefixText: "\$"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final product = Product(
                      id: widget.product?.id,
                      ownerId: _userRepo.firestoreUserStream.value!.uid!,
                      name: _nameController.text,
                      productStatus: ProductSaleStatus.active,
                      type: productType,
                      dateCreated: DateTime.now(),
                      imagePaths: [],
                      description: _descriptionController.text,
                      price: double.parse(_productPriceController.text));

                  if (widget.product == null) {
                    await productsRepo.addProduct(product, images);
                    // Add product
                    // Call your ProductsRepository's addProduct method here
                  } else {
                    return await productsRepo.updateProduct(product, images).then((value) {
                      Navigator.pop(context, product);
                    });
                  }

                  Navigator.pop(context);
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
