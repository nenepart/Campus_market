import 'package:campus_market/repositories/user_repo.dart';
import 'package:campus_market/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  late UserRepo _userRepo;
  @override
  Widget build(BuildContext context) {
    Product product = widget.product;
    _userRepo = UserRepo();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .95,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.product.imagePaths.isNotEmpty)
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.product.imagePaths.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(child: Image.network(product.imagePaths[index]));
                    },
                  ),
                ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: SizedBox(width: 40, child: const Text("Product Type"))),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      initialValue: product.type.name,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text("DESCRIPTION"),
              TextFormField(
                readOnly: true,
                maxLines: 10,
                decoration: InputDecoration(border: OutlineInputBorder()),
                initialValue: product.description,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 40, child: const Text("Price")),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(border: OutlineInputBorder(), prefixText: "\$"),
                      initialValue: product.price.toString(),
                    ),
                  ),
                ],
              ),
              OutlinedButton(onPressed: () {}, child: Text("CHAT WITH SELLER")),
              ValueListenableBuilder(
                valueListenable: _userRepo.firestoreUserStream,
                builder: (context, user, child) {
                  return _userRepo.firestoreUserStream.value?.uid == product.ownerId ? child! : SizedBox.shrink();
                },
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductForm(
                                    product: widget.product,
                                  )));
                    },
                    child: const Text("EDIT PRODUCT")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
