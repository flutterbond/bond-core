import 'package:bond_network/bond_network.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Meta JSON', () {
    final json = <String, dynamic>{
      'current_page': 2,
      'from': 16,
      'last_page': 7,
      'path': 'https://api.example.com/posts',
      'per_page': 15,
      'to': 30,
      'total': 100,
      'message': 'ok',
    };

    test('fromJson reads `from` and `last_page` from their own keys', () {
      final meta = Meta.fromJson(json);

      expect(meta.currentPage, 2);
      expect(meta.from, 16);
      expect(meta.lastPage, 7);
      expect(meta.perPage, 15);
      expect(meta.to, 30);
      expect(meta.total, 100);
    });

    test('toJson round-trips every field', () {
      expect(Meta.fromJson(json).toJson(), json);
    });
  });
}
