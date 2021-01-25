import 'package:meta/meta.dart';

class AppUser {
  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;

  const AppUser(
      {@required this.uid, this.email, this.photoUrl, this.displayName});
}
