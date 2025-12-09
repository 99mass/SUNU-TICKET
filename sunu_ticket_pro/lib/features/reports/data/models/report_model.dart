import 'package:intl/intl.dart';

class ReportModel {
  final String id;
  final String busId;
  final String busPlateNumber;
  final String busLine;
  final String driverName;
  final String receiverName;
  final DateTime date;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final String? departureLocation;
  final String? arrivalLocation;
  final Map<int, int> ticketsBySection;
  final double totalRevenue;
  final double fuelCost;
  final double breakdownCost;
  final double towingCost;
  final double policePenaltyCost;
  final double driverBonus;
  final double receiverBonus;
  final double totalExpenses;
  final double netProfit;
  final bool isValidated;
  final DateTime? validatedAt;
  final String? validatedBy;

  ReportModel({
    required this.id,
    required this.busId,
    required this.busPlateNumber,
    required this.busLine,
    required this.driverName,
    required this.receiverName,
    required this.date,
    this.departureTime,
    this.arrivalTime,
    this.departureLocation,
    this.arrivalLocation,
    required this.ticketsBySection,
    required this.totalRevenue,
    required this.fuelCost,
    required this.breakdownCost,
    required this.towingCost,
    required this.policePenaltyCost,
    required this.driverBonus,
    required this.receiverBonus,
    required this.totalExpenses,
    required this.netProfit,
    required this.isValidated,
    this.validatedAt,
    this.validatedBy,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String,
      busId: json['busId'] as String,
      busPlateNumber: json['busPlateNumber'] as String,
      busLine: json['busLine'] as String,
      driverName: json['driverName'] as String,
      receiverName: json['receiverName'] as String,
      date: DateTime.parse(json['date'] as String),
      departureTime: json['departureTime'] != null
          ? DateTime.parse(json['departureTime'] as String)
          : null,
      arrivalTime: json['arrivalTime'] != null
          ? DateTime.parse(json['arrivalTime'] as String)
          : null,
      departureLocation: json['departureLocation'] as String?,
      arrivalLocation: json['arrivalLocation'] as String?,
      ticketsBySection: (json['ticketsBySection'] as Map<String, dynamic>).map(
        (k, v) => MapEntry(int.parse(k), v as int),
      ),
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      fuelCost: (json['fuelCost'] as num).toDouble(),
      breakdownCost: (json['breakdownCost'] as num).toDouble(),
      towingCost: (json['towingCost'] as num).toDouble(),
      policePenaltyCost: (json['policePenaltyCost'] as num).toDouble(),
      driverBonus: (json['driverBonus'] as num).toDouble(),
      receiverBonus: (json['receiverBonus'] as num).toDouble(),
      totalExpenses: (json['totalExpenses'] as num).toDouble(),
      netProfit: (json['netProfit'] as num).toDouble(),
      isValidated: json['isValidated'] as bool,
      validatedAt: json['validatedAt'] != null
          ? DateTime.parse(json['validatedAt'] as String)
          : null,
      validatedBy: json['validatedBy'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'busId': busId,
      'busPlateNumber': busPlateNumber,
      'busLine': busLine,
      'driverName': driverName,
      'receiverName': receiverName,
      'date': date.toIso8601String(),
      'departureTime': departureTime?.toIso8601String(),
      'arrivalTime': arrivalTime?.toIso8601String(),
      'departureLocation': departureLocation,
      'arrivalLocation': arrivalLocation,
      'ticketsBySection': ticketsBySection,
      'totalRevenue': totalRevenue,
      'fuelCost': fuelCost,
      'breakdownCost': breakdownCost,
      'towingCost': towingCost,
      'policePenaltyCost': policePenaltyCost,
      'driverBonus': driverBonus,
      'receiverBonus': receiverBonus,
      'totalExpenses': totalExpenses,
      'netProfit': netProfit,
      'isValidated': isValidated,
      'validatedAt': validatedAt?.toIso8601String(),
      'validatedBy': validatedBy,
    };
  }

  ReportModel copyWith({
    String? id,
    String? busId,
    String? busPlateNumber,
    String? busLine,
    String? driverName,
    String? receiverName,
    DateTime? date,
    DateTime? departureTime,
    DateTime? arrivalTime,
    String? departureLocation,
    String? arrivalLocation,
    Map<int, int>? ticketsBySection,
    double? totalRevenue,
    double? fuelCost,
    double? breakdownCost,
    double? towingCost,
    double? policePenaltyCost,
    double? driverBonus,
    double? receiverBonus,
    double? totalExpenses,
    double? netProfit,
    bool? isValidated,
    DateTime? validatedAt,
    String? validatedBy,
  }) {
    return ReportModel(
      id: id ?? this.id,
      busId: busId ?? this.busId,
      busPlateNumber: busPlateNumber ?? this.busPlateNumber,
      busLine: busLine ?? this.busLine,
      driverName: driverName ?? this.driverName,
      receiverName: receiverName ?? this.receiverName,
      date: date ?? this.date,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      departureLocation: departureLocation ?? this.departureLocation,
      arrivalLocation: arrivalLocation ?? this.arrivalLocation,
      ticketsBySection: ticketsBySection ?? this.ticketsBySection,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      fuelCost: fuelCost ?? this.fuelCost,
      breakdownCost: breakdownCost ?? this.breakdownCost,
      towingCost: towingCost ?? this.towingCost,
      policePenaltyCost: policePenaltyCost ?? this.policePenaltyCost,
      driverBonus: driverBonus ?? this.driverBonus,
      receiverBonus: receiverBonus ?? this.receiverBonus,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      netProfit: netProfit ?? this.netProfit,
      isValidated: isValidated ?? this.isValidated,
      validatedAt: validatedAt ?? this.validatedAt,
      validatedBy: validatedBy ?? this.validatedBy,
    );
  }

  // Computed properties
  int get totalTicketsSold {
    return ticketsBySection.values.fold(0, (sum, tickets) => sum + tickets);
  }

  String get formattedDate {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String get formattedDepartureTime {
    return departureTime != null
        ? DateFormat('HH:mm').format(departureTime!)
        : '';
  }

  String get formattedArrivalTime {
    return arrivalTime != null ? DateFormat('HH:mm').format(arrivalTime!) : '';
  }

  String get statusText {
    return isValidated ? 'Descendu' : 'En cours';
  }
}
