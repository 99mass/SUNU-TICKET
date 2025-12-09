class BusSection {
  final int sectionNumber;
  final int price;

  BusSection({required this.sectionNumber, required this.price});

  factory BusSection.fromJson(Map<String, dynamic> json) {
    return BusSection(
      sectionNumber: json['sectionNumber'] as int? ?? 0,
      price: json['price'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'sectionNumber': sectionNumber, 'price': price};
  }
}

class Bus {
  final String id;
  final String plateNumber;
  final String line;
  final String driver;
  final String status;
  final int seats;
  final List<BusSection> sections;
  final String? gie; // GIE to which the bus belongs
  final String? departureDate; // Format: YYYY-MM-DD
  final String? departureTime; // Format: HH:mm

  Bus({
    required this.id,
    required this.plateNumber,
    required this.line,
    required this.driver,
    required this.status,
    required this.seats,
    required this.sections,
    this.gie,
    this.departureDate,
    this.departureTime,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'] as String? ?? '',
      plateNumber: json['plateNumber'] as String? ?? '',
      line: json['line'] as String? ?? '',
      driver: json['driver'] as String? ?? '',
      status: json['status'] as String? ?? 'En service',
      seats: json['seats'] as int? ?? 45,
      sections:
          (json['sections'] as List?)
              ?.map((e) => BusSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      gie: json['gie'] as String?,
      departureDate: json['departureDate'] as String?,
      departureTime: json['departureTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plateNumber': plateNumber,
      'line': line,
      'driver': driver,
      'status': status,
      'seats': seats,
      'sections': sections.map((e) => e.toJson()).toList(),
      'gie': gie,
      'departureDate': departureDate,
      'departureTime': departureTime,
    };
  }

  // Conversion to/from Map for compatibility with existing code
  Map<String, dynamic> toMap() => toJson();

  factory Bus.fromMap(Map<String, dynamic> map) => Bus.fromJson(map);
}
