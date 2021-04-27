import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  try {
    await canLaunch(url)
        ? await launch(url)
        : throw Exception('Could not launch');
  } on Exception catch (_) {
    rethrow;
  }
}
