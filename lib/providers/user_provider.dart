import 'package:animo/constants/box_constants.dart';
import 'package:animo/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final userProvider = StateProvider<User?>(
  (ref) => Hive.box(BoxConstants.main).get(BoxConstants.userKey),
);
