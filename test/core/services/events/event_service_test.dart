import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/services/events/event_service.dart';

class EventA {
  String text;

  EventA(this.text);
}

class EventB {
  String text;

  EventB(this.text);
}

class EventWithMap {
  Map myMap;

  EventWithMap(this.myMap);
}

void main() {
  test('core/services - Fire one event', () {
    final eventBus = EventService();
    final f = eventBus.on<EventA>().toList();

    eventBus.fire(EventA('a1'));
    eventBus.destroy();

    return f.then((events) {
      expect(events.length, 1);
    });
  });

  test('core/services - Fire two events of same type', () {
    final eventBus = EventService();
    final f = eventBus.on<EventA>().toList();

    eventBus.fire(EventA('a1'));
    eventBus.fire(EventA('a2'));
    eventBus.destroy();

    return f.then((events) {
      expect(events.length, 2);
    });
  });

  test('core/services - Fire events of different type', () {
    final eventBus = EventService();
    final f1 = eventBus.on<EventA>().toList();
    final f2 = eventBus.on<EventB>().toList();

    eventBus.fire(EventA('a1'));
    eventBus.fire(EventB('b1'));
    eventBus.destroy();

    return Future.wait(
      [
        f1.then((events) {
          expect(events.length, 1);
        }),
        f2.then((events) {
          expect(events.length, 1);
        }),
      ],
    );
  });

  test('core/services - Fire events of different type, receive all types', () {
    final eventBus = EventService();
    final f = eventBus.on().toList();

    eventBus.fire(EventA('a1'));
    eventBus.fire(EventB('b1'));
    eventBus.fire(EventB('b2'));
    eventBus.destroy();

    return f.then((events) {
      expect(events.length, 3);
    });
  });

  test('core/services - Fire event with a map type', () {
    final eventBus = EventService();
    final f = eventBus.on<EventWithMap>().toList();

    eventBus.fire(EventWithMap({'a': 'test'}));
    eventBus.destroy();

    return f.then((events) {
      expect(events.length, 1);
    });
  });
}
