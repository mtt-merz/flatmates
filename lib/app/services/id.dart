import 'package:uuid/uuid.dart';

class ID {
  /// Generate an unique ID
  static String generate() => const Uuid().v4();
}
