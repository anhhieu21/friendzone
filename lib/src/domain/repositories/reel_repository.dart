import '../models/reel.dart';

abstract class ReelRepository {
  Future<List<Reel>> getReels();
}
