import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendzone/src/domain.dart';
import 'package:friendzone/src/utils.dart';

class Post extends Feed {
  String content;
  String like;
  bool visible;
  int totalComment = 0;
  Post({
    required super.id,
    required super.idUser,
    required super.imagesUrl,
    required super.author,
    required super.createdAt,
    required super.avartarAuthor,
    required this.content,
    required this.like,
    required this.visible,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map postFromDB = doc.data() as Map;
    return Post(
        id: postFromDB['id'],
        idUser: postFromDB['idUser'],
        content: postFromDB['content'],
        imagesUrl: List<String>.from(postFromDB['imageUrl']),
        author: postFromDB['author'],
        avartarAuthor: postFromDB['avartarAuthor'] ?? '',
        like: postFromDB['like'] ?? '0',
        visible: postFromDB['visible'],
        createdAt: Formatter.dateTime(postFromDB["createdAt"].toDate()));
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'idUser': idUser,
      'avartarAuthor': avartarAuthor,
      'content': content,
      'imageUrl': imagesUrl,
      'author': author,
      'visible': visible,
      'createdAt': DateTime.now()
    };
  }
}

enum OptionPost { private, public }

getOptionPost(Enum value) {
  switch (value) {
    case OptionPost.private:
      return false;
    case OptionPost.public:
      return true;
    default:
  }
}

final iconList = [
  '😀',
  '😃',
  '😄',
  '😁',
  '😆',
  '😅',
  '😂',
  '🤣',
  '🥲',
  '🥹',
  '☺️',
  '😊',
  '😇',
  '🙂',
  '🙃',
  '😉',
  '😌',
  '😍',
  '🥰',
  '😘',
  '😗',
  '😙',
  '😚',
  '😋',
  '😛',
  '😝',
  '😜',
  '🤪',
  '🤨',
  '🧐',
  '🤓',
  '😎',
  '🥸',
  '🤩',
  '🥳',
  '😏',
  '😒',
  '😞',
  '😔',
  '😟',
  '😕',
  '🙁',
  '☹️',
  '😣',
  '😖',
  '😫',
  '😩',
  '🥺',
  '😭',
  '😮‍💨',
  '😤',
  '😠',
  '😡',
  '🤬',
  '🤯',
  '😳',
  '🥵',
  '🥶',
  '😱',
  '😨',
  '😰',
  '😥',
];
