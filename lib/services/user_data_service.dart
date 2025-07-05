import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all users from Firestore
  Stream<List<UserModel>> getAllUsers() {
    return _firestore
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Get user count
  Future<int> getUserCount() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      return snapshot.docs.length;
    } catch (e) {
      throw 'Error getting user count: $e';
    }
  }

  // Get users by date range
  Future<List<UserModel>> getUsersByDateRange(DateTime startDate, DateTime endDate) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('createdAt', isGreaterThanOrEqualTo: startDate)
          .where('createdAt', isLessThanOrEqualTo: endDate)
          .get();
      
      return snapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw 'Error getting users by date range: $e';
    }
  }

  // Search users by name or email
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      // Search by name (case-insensitive)
      QuerySnapshot nameSnapshot = await _firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + '\uf8ff')
          .get();

      // Search by email (case-insensitive)
      QuerySnapshot emailSnapshot = await _firestore
          .collection('users')
          .where('email', isGreaterThanOrEqualTo: query)
          .where('email', isLessThan: query + '\uf8ff')
          .get();

      // Combine and remove duplicates
      Set<String> seenIds = {};
      List<UserModel> results = [];

      for (var doc in nameSnapshot.docs) {
        if (!seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add(UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
        }
      }

      for (var doc in emailSnapshot.docs) {
        if (!seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add(UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
        }
      }

      return results;
    } catch (e) {
      throw 'Error searching users: $e';
    }
  }

  // Get user statistics
  Future<Map<String, dynamic>> getUserStatistics() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      List<UserModel> users = snapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      int totalUsers = users.length;
      int activeUsers = users.where((user) {
        if (user.lastLoginAt == null) return false;
        return DateTime.now().difference(user.lastLoginAt!).inDays <= 30;
      }).length;

      // Group by creation month
      Map<String, int> usersByMonth = {};
      for (var user in users) {
        if (user.createdAt != null) {
          String monthKey = '${user.createdAt!.year}-${user.createdAt!.month.toString().padLeft(2, '0')}';
          usersByMonth[monthKey] = (usersByMonth[monthKey] ?? 0) + 1;
        }
      }

      return {
        'totalUsers': totalUsers,
        'activeUsers': activeUsers,
        'usersByMonth': usersByMonth,
        'averageUsersPerMonth': totalUsers > 0 ? (totalUsers / usersByMonth.length).round() : 0,
      };
    } catch (e) {
      throw 'Error getting user statistics: $e';
    }
  }

  // Export user data as JSON
  Future<List<Map<String, dynamic>>> exportUserData() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['uid'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw 'Error exporting user data: $e';
    }
  }
} 