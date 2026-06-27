import '../constants/netvetta_web_constants.dart';
import '../models/user_model.dart';

extension StringUriExtension on String {
  Uri get uri => Uri.parse(this);
}

extension UserUrlExtension on User {
  String get accountUrl => '${NetvettaWebConstants.account}/$id';

  String get basketUrl => '${NetvettaWebConstants.basket}/$id';
}
