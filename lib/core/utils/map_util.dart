abstract class MapUtil {
  static bool containsValues<T>(List<T> items, Map<dynamic, T> map) {
    final values = map.values.toSet();
    return values.containsAll(items);
  }

  static bool valuesMatch<T>(
    List<T> keys,
    Map<dynamic, T> map,
    Set<dynamic> values,
  ) {
    for (final key in keys) {
      if (!values.contains(map[key])) {
        return false;
      }
    }
    return true;
  }

  static List<R> getMatching<R, T>(Map<R, T> map, Set<T> values) {
    final matchingValues = <R>[];
    for (final entry in map.entries) {
      if (values.contains(entry.value)) {
        matchingValues.add(entry.key);
      }
    }
    return matchingValues;
  }
}
