import 'dart:async';

class EventService {
  final StreamController _streamController;

  StreamController get streamController => _streamController;

  EventService({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  void add(dynamic event) {
    streamController.add(event);
  }

  Future<T> addAndWait<T>(dynamic event) async {
    streamController.add(event);
    final result = await streamController.stream.firstWhere(
      (element) => element is T,
    );
    return result;
  }

  void destroy() {
    _streamController.close();
  }
}
