import 'dart:io';

import 'package:campus_market/repositories/database.dart';
import 'package:campus_market/repositories/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product.dart';

class ProductsRepo {
  static const String kCollectionPath = "products";

  Stream<List<Product>> streamAllProducts() {
    return _databaseService.getCollectionReference(kCollectionPath).snapshots().map((event) {
      return event.docs.map((e) => Product.fromJson(e.data(), e.id)).toList();
    });
  }

  final DatabaseService _databaseService = DatabaseService();
  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService();

  // Get a single product from the Firestore database using its ID
  Future<Product?> getProduct(String productId) async {
    final DocumentSnapshot<Map<String, dynamic>>? snapshot = await _databaseService.getDocument('products/$productId');
    return snapshot != null ? Product.fromJson(snapshot.data()!, snapshot.id) : null;
  }

  Future<String?> addProduct(Product product, List<XFile> media) async {
    String? productId = await _databaseService.createDocument('products', product.toJson(), docId: product.id);

    if (productId == null) {
      return null;
    }

    // Upload media files to Firebase Storage
    final List<String?> mediaUrls = await Future.wait(media.map((XFile file) async {
      final String fileName = '${DateTime.now().microsecondsSinceEpoch}.png';
      final String path = 'products/${product.ownerId}/$productId-$fileName';
      return _firebaseStorageService.uploadFile(path, File(file.path));
    }));

    // Add product to Firestore with media URLs
    product.imagePaths = mediaUrls.cast<String>();
    await _databaseService.updateDocument('products/$productId', product.toJson());
  }

  Future<File> renameFileExtension(File file, String newExtension) async {
    final String newPath = '${file.path.substring(0, file.path.lastIndexOf('.'))}$newExtension';
    return file.rename(newPath);
  }

  // Update an existing product in the Firestore database
  Future<bool> updateProduct(Product product) async {
    final bool success = await _databaseService.updateDocument('products/${product.id}', product.toJson());
    return success;
  }

  // Delete a product from the Firestore database using its ID
  Future<bool> deleteProduct(String productId) async {
    final bool success = await _databaseService.deleteDocument('products/$productId');
    return success;
  }
}
