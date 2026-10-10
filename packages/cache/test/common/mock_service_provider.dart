import 'package:bond_core/bond_core.dart';
import 'package:mockito/mockito.dart';

import 'registered_model.dart';

class MockServiceProvider extends Mock
    with ResponseDecoding
    implements ServiceProvider {
  @override
  Map<Type, JsonFactory> get factories => {
    RegisteredModel: RegisteredModel.fromJson,
  };
}
