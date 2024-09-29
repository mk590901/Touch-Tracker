class Pair<F, S> {
  late F _first;
  late S _second;

  Pair(this._first, this._second);

  Pair.copy(Pair other) {
    _first = other._first;
    _second = other._second;
  }

  Pair.fromMap_(Map<String, dynamic> map)
      : _first = map['f'] as F,
        _second = map['s'] as S;

  @override
  String toString() {
    return '$_first,$_second';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Pair && runtimeType == other.runtimeType && _first == other._first && _second == other._second;

  @override
  int get hashCode => _first.hashCode ^ _second.hashCode;

  F first () => _first;
  S second() => _second;

  /// Convert a Pair<F, S> to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'f': _first,
      's': _second,
    };
  }

  /// Convert a Map<String, dynamic> to a Pair<int, int>
  static Pair<int, int> fromMap(Map<String, dynamic> map) {
    return Pair(
      map['f'] as int,
      map['s'] as int,
    );
  }

}
