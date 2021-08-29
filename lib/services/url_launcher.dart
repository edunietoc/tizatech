import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String _url) async {
  try {
    if (await canLaunch(_url)) {
      print('launching');
      await launch(_url);
    } else {
      throw Exception('Could not launch $_url');
    }
  } on Exception catch (_) {
    print('cant launch');
  }
}
