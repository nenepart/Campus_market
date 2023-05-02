import 'package:campus_market/models/chat_model.dart';
import 'package:campus_market/models/chat_session.dart';
import 'package:campus_market/repositories/database.dart';
import 'package:campus_market/repositories/products_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class ChatSessionsRepo {
  static const String kCollectionPath = 'chat_sessions';
  DatabaseService db = DatabaseService();

  Future<void> uploadChatSession(ChatSession session) {
    return db.createDocument(_getChatSessionCollectionPath(session.productId), session.toJson());
  }

  Future<bool> updateChatSession(ChatSession session) {
    return db.updateDocument(_getChatSessionCollectionPath(session.productId) + "/" + session.id!, session.toJson());
  }

  Future<void> addChatMessage(ChatModel message, String sessionId) {
    return db
        .getCollectionReference(_getChatSessionCollectionPath(message.productId))
        .doc(sessionId)
        .update({"messages": FieldValue.arrayUnion(message.toJson())});
  }

  Future<Stream<ChatSession>> streamChat(Product product, String buyerId) async {
    return db
        .getCollectionReference(_getChatSessionCollectionPath(product.id!))
        .where("senderId", isEqualTo: buyerId)
        .limit(1)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        //create new session
        return await db
            .createDocument(_getChatSessionCollectionPath(product.id!), ChatSession.newSession(buyerId, "Ameteku", product).toJson())
            .then((value) {
          return db
              .getCollectionReference(_getChatSessionCollectionPath(product.id!))
              .doc(value)
              .snapshots()
              .map((event) => ChatSession.fromJson(event.data()!, id: event.id));
        });
      }
      return value.docs.first.reference.snapshots().map((event) => ChatSession.fromJson(event.data()!, id: event.id));
    });
  }

  String _getChatSessionCollectionPath(String productId) => '${ProductsRepo.kCollectionPath}/$productId/$kCollectionPath';
}
