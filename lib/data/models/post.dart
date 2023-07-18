import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:friendzone/presentation/utils/formatter.dart';

class Post {
  String id;
  String idUser;
  String content;
  List<String> imagesUrl;
  String author;
  String like;
  String createdAt;
  String? avartarAuthor;
  bool visible;
  int totalComment = 0;
  Post(
      {required this.id,
      required this.idUser,
      required this.content,
      required this.imagesUrl,
      required this.author,
      required this.like,
      this.avartarAuthor,
      required this.visible,
      required this.createdAt});

  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map postFromDB = doc.data() as Map;
    return Post(
        id: postFromDB['id'],
        idUser: postFromDB['idUser'],
        content: postFromDB['content'],
        imagesUrl: List<String>.from(postFromDB['imageUrl']),
        author: postFromDB['author'],
        avartarAuthor: postFromDB['avartarAuthor'],
        like: postFromDB['like'] ?? '0',
        visible: postFromDB['visible'],
        createdAt: Formatter.dateTime(postFromDB["createdAt"].toDate()));
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'idUser': idUser,
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
