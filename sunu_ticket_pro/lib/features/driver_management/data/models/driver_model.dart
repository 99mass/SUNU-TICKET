class Driver {
  final String id;
  final String name;
  final String licenseNumber;
  final String phoneNumber;
  final String status; // active, inactive

  Driver({
    required this.id,
    required this.name,
    required this.licenseNumber,
    required this.phoneNumber,
    required this.status,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      licenseNumber: json['license_number'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'license_number': licenseNumber,
      'phone_number': phoneNumber,
      'status': status,
    };
  }

  Map<String, dynamic> toMap() => toJson();

  factory Driver.fromMap(Map<String, dynamic> map) => Driver.fromJson(map);

  Driver copyWith({
    String? id,
    String? name,
    String? licenseNumber,
    String? phoneNumber,
    String? status,
  }) {
    return Driver(
      id: id ?? this.id,
      name: name ?? this.name,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }
}
