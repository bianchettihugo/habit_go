import 'dart:async';

typedef EventMapper<Event> = Stream<Event> Function(Event event);

typedef EventTransformer<Event> = Stream<Event> Function(
  Stream<Event> events,
  EventMapper<Event> mapper,
);

EventTransformer<Event> sequential<Event>() {
  return (events, mapper) => events.asyncExpand(mapper);
}

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

  void destroy() {
    _streamController.close();
  }
}
