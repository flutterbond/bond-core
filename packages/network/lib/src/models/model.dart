import 'package:equatable/equatable.dart';

import 'package:bond_core/bond_core.dart';

abstract class Model extends Equatable with Jsonable {
  const Model({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
