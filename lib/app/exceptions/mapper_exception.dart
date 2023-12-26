final class MapperException implements Exception {
  final String message;

  const MapperException({required this.message});

  @override
  String toString() => message;
}
