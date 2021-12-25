import 'package:event_bus/event_bus.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';

class EvenBusIntegration implements EventBusAbstraction {
  final EventBus _eventBus = EventBus();
  @override
  void destroy() {
    _eventBus.destroy();
  }

  @override
  void fire(dynamic event) {
    _eventBus.fire(event);
  }

  @override
  Stream<T> on<T>() {
    return _eventBus.on<T>();
  }
}
