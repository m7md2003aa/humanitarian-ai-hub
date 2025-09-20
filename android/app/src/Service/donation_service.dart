import 'package:cloud_firestore/cloud_firestore.dart';

class DonationService {
  final _db = FirebaseFirestore.instance;

  Future<void> createDonation({
    required String ownerId,
    required String title,
    required String photoUrl,
    required int cost,
    required String type, // "donor" or "business"
  }) async {
    final doc = _db.collection('donations').doc();
    await doc.set({
      'id': doc.id,
      'ownerId': ownerId,
      'title': title,
      'photoUrl': photoUrl,
      'category': 'unknown',
      'cost': cost,
      'type': type,
      'status': 'available',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
