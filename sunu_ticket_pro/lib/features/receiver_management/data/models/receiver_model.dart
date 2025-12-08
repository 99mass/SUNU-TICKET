class Receiver {
  final String id;
  final String name;
  final String phoneNumber;
  final String status; // active, inactive

  Receiver({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.status,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'status': status,
    };
  }

  Map<String, dynamic> toMap() => toJson();

  factory Receiver.fromMap(Map<String, dynamic> map) => Receiver.fromJson(map);

  Receiver copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? status,
  }) {
    return Receiver(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }
}
