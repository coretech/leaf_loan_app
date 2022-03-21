import 'package:flutter/widgets.dart';

abstract class MessagingService {
   Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {}
}
