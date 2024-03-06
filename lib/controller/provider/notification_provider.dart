import 'dart:convert';

import 'dart:developer';

import 'package:http/http.dart' as http;

class NotificationProvider {
  static const String _key =
      "key=AAAA3dOFTHo:APA91bHFz9eO_ceuIIbfxl3HMW_qTdQoicvLj-kx0lJPZFpZZzYog1EhBwCCwlanhyr5McmMyH1PiZRLui0AdqCQ81piap3A_fdhLiARI4UDP5O6pcKkZQfqBwXyj_MPjY97PO3krPJ9";
  static Future<void> sendNotification(
      {required String token, required String message}) async {
    if (token.isEmpty) {
      return log('Unable to send FCM message, no token exists.');
    }

    try {
      //Send  Message
      http.Response response =
          await http.post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            // Uri.parse('https://api.rnfirebase.io/messaging/send'),

              headers: {
                'Content-Type': 'application/json',
                'Authorization': _key,
              },
              body: _constructFCMPayload(token, message));

      log("status: ${response.body}");
    } catch (e) {
      log("error push notification $e");
    }
  }

  static String _constructFCMPayload(token, message) {
    return jsonEncode(
      {
        "to": token,
        'priority': 'high',
        'notification': {"body": message},
        'data': {
          //  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'body': '$message',
          'title': 'New Request'
        },
      },
    );
  }
 static Future<void> sendPushMessage(_token) async {
  _token='dyOye8eFRN-jw8YMTLr_LG:APA91bEKwtOPiwqcimjXgV8ABnfiYfxDv2pdxxboC_NhLOxPG7Y12tqzXb6SZZR6Hd_WitEx9VUwpdaZwNkB7-Upji0O7SAVd1AMXYlvTpOAm2nRFckU6vDJDPxB6UO_up88yWU_AM6b';
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
 var response=     await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
            // Uri.parse('https://fcm.googleapis.com/fcm/send'),

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "key=AAAA3dOFTHo:APA91bHFz9eO_ceuIIbfxl3HMW_qTdQoicvLj-kx0lJPZFpZZzYog1EhBwCCwlanhyr5McmMyH1PiZRLui0AdqCQ81piap3A_fdhLiARI4UDP5O6pcKkZQfqBwXyj_MPjY97PO3krPJ9",
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
      log("response is ${response.body}");
    } catch (e) {
      print(e);
    }
  }
   static String constructFCMPayload(String token) {
  // _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      // 'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification  was created via FCM!',
    },
  });
}



}
