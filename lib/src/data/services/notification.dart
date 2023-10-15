import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:friendzone/src/data/services/fcm.dart';
import 'package:friendzone/src/domain/models/conversation.dart';
import 'package:friendzone/src/domain/models/user_model.dart';

class AppNotification {
  AppNotification._();
  static final AppNotification instance = AppNotification._();
  Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  listenMessage() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('conversations')
        .snapshots()
        .listen((event) async {
      if (event.docChanges.isEmpty) return;
      final doc = event.docChanges.first.doc;
      if (!doc.exists) return;
      final idMe = FirebaseAuth.instance.currentUser!.uid;
      final conversation = Conversation.fromMap(doc);
      if (conversation.message.sender == idMe) return;
      final idUser = conversation.participants.firstWhere((e) => e != idMe);
      final docUser = await FirebaseFirestore.instance
          .collection("users")
          .doc(idUser)
          .get();
      // final res = UserModel.fromMap(docUser.data()as Map);
      // await showBigTextNotification(
      //     title: res.name,
      //     body: conversation.message.message,
      //     fln: flutterLocalNotificationsPlugin);
    });
  }

  Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'chat_notification_fr', 'channel_chat',
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());
    await fln.show(0, title, body, not);
  }
}
