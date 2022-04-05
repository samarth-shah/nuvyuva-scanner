import 'dart:convert';

class Details {
  String name;
  String namespace;
  String type;
  bool repeat;
  Details({
    required this.name,
    required this.namespace,
    required this.type,
    required this.repeat,
  });

  Details copyWith({
    String? name,
    String? namespace,
    String? type,
    bool? repeat,
  }) {
    return Details(
      name: name ?? this.name,
      namespace: namespace ?? this.namespace,
      type: type ?? this.type,
      repeat: repeat ?? this.repeat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'namespace': namespace,
      'type': type,
      'repeat': repeat,
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      name: map['name'] ?? '',
      namespace: map['namespace'] ?? '',
      type: map['type'] ?? '',
      repeat: map['repeat'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Details.fromJson(String source) => Details.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Details(name: $name, namespace: $namespace, type: $type, repeat: $repeat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Details &&
      other.name == name &&
      other.namespace == namespace &&
      other.type == type &&
      other.repeat == repeat;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      namespace.hashCode ^
      type.hashCode ^
      repeat.hashCode;
  }
}
