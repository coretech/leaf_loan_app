abstract class EventBusAbstraction {
  void destroy();

  void fire(dynamic event);

  Stream<T> on<T>();
}
