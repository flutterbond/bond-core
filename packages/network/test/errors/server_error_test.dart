import 'package:bond_network/bond_network.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ServerError.fromJson', () {
    test('reads message and code', () {
      final error = ServerError.fromJson({
        'message': 'Not found',
        'code': '404',
      });

      expect(error.message, 'Not found');
      expect(error.code, '404');
    });

    test('tolerates a body without message and code', () {
      // AWS Lambda function URLs answer 403 with {"Message": null}.
      final error = ServerError.fromJson({'Message': null});

      expect(error.message, 'Unexpected server error');
      expect(error.code, 'unknown');
    });
  });
}
