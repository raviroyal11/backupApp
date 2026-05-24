import 'package:share/share.dart';

class ShareWidget {
  share({required String shareText}) {
    Share.share(shareText);
  }
}
