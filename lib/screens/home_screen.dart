import 'package:campus_market/models/product.dart';
import 'package:campus_market/repositories/products_repo.dart';
import 'package:campus_market/repositories/user_repo.dart';
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
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: StreamBuilder<List<Product>>(
        stream: _productsRepo.streamAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _products = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
            itemCount: _products.length,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              final Product product = _products[index];
              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        product.imagePaths.first,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(product.name),
                    Text(product.ownerId),
                    Text(product.dateCreated.toString()),
                    Text(product.productStatus.toString()),
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
