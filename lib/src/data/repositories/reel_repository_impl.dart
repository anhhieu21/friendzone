import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendzone/src/domain/models/reel.dart';
import 'package:friendzone/src/domain/repositories/reel_repository.dart';

class ReelRepositoryImpl implements ReelRepository{
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<Reel>> getReels() async {
    final querySnapshot = await firestore.collection('reel').get();
    final list = querySnapshot.docs.map((e) => Reel.fromMap(e.data())).toList();
    return list;
  }
}
