class RegisteredModel {
  final String data;

  RegisteredModel._(this.data);

  factory RegisteredModel.data(String data) => RegisteredModel._(data);

  factory RegisteredModel.fromJson(Map<String, dynamic> json) {
    return RegisteredModel._(json['data']);
  }

  Map<String, dynamic> toJson() => {'data': data};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisteredModel &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}
