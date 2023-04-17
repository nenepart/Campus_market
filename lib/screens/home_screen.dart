import 'package:campus_market/models/product.dart';
import 'package:campus_market/repositories/products_repo.dart';
import 'package:campus_market/repositories/user_repo.dart';
import 'package:campus_market/screens/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserRepo _userRepo;
  late ProductsRepo _productsRepo;

  final int _pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    _userRepo = context.watch<UserRepo>();
    _productsRepo = context.watch<ProductsRepo>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductForm(
                        productsRepo: _productsRepo,
                      )));
        },
      ),
      appBar: AppBar(
        title: const Text('Campus Market'),
      ),
      body: StreamBuilder<List<Product>>(
        stream: _productsRepo.streamAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          _products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4),
            itemCount: _products.length,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              final Product product = _products[index];
              return Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                      child: product.imagePaths.isNotEmpty
                          ? Expanded(
                              child: Stack(
                                children: [
                                  Image.network(
                                    product.imagePaths.first,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, _, __) {
                                      return Icon(
                                        Icons.close,
                                        size: 70,
                                      );
                                    },
                                  ),
                                  if (product.productStatus != ProductSaleStatus.sold)
                                    const Expanded(
                                      child: Text(
                                        "SOLD",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Center(child: const Text("No Image")),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
