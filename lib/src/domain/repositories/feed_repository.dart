import 'package:friendzone/src/domain.dart';
import 'package:image_picker/image_picker.dart';

abstract class FeedRepository {
  Future<List<Feed>> getStories();

  Future<Feed?> createFeed(XFile image, UserModel userModel);
}
