import 'package:campus_market/models/chat_model.dart';
import 'package:campus_market/models/chat_session.dart';
import 'package:campus_market/repositories/database.dart';
import 'package:campus_market/repositories/products_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatSessionsRepo {
  static const String kCollectionPath = 'chat_sessions';
  DatabaseService db = DatabaseService();

  Future<void> uploadChatSession(ChatSession session) {
    return db.createDocument(_getChatSessionCollectionPath(session.productId), session.toJson());
  }

  Future<bool> updateChatSession(ChatSession session) {
    return db.updateDocument(_getChatSessionCollectionPath(session.productId) + session.id!, session.toJson());
  }

  Future<void> addChatMessage(ChatModel message, String sessionId) {
    return db
        .getCollectionReference(_getChatSessionCollectionPath(message.productId))
        .doc(sessionId)
        .update({"messages": FieldValue.arrayUnion(message.toJson())});
  }

  String _getChatSessionCollectionPath(String productId) => '${ProductsRepo.kCollectionPath}/$productId/$kCollectionPath';
}
