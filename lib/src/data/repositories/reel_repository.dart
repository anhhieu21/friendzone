import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendzone/src/domain/models/reel.dart';

class ReelRepository {
  final firestore = FirebaseFirestore.instance;

  Future<List<Reel>> getReels() async {
    final querySnapshot = await firestore.collection('reel').get();
    final list = querySnapshot.docs.map((e) => Reel.fromMap(e.data())).toList();
    return list;
  }
}
