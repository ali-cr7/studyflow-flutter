import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  Future<bool> sendMessage({
    required String phoneNumber,
    required String message,
  }) async {
    final uri = Uri.parse(
      'https://wa.me/$phoneNumber'
      '?text=${Uri.encodeComponent(message)}',
    );

    return launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}