import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunu_ticket_pro/core/constants/app_colors.dart';
import 'package:sunu_ticket_pro/features/bus_management/presentation/controllers/bus_controller.dart';
import 'package:sunu_ticket_pro/features/session_management/presentation/screens/generate_code_screen.dart';
import 'package:sunu_ticket_pro/features/driver_management/presentation/controllers/driver_controller.dart';
import 'package:sunu_ticket_pro/features/driver_management/data/models/driver_model.dart';

class BusManagementScreen extends StatefulWidget {
  const BusManagementScreen({super.key});

  @override
  State<BusManagementScreen> createState() => _BusManagementScreenState();
}

class _BusManagementScreenState extends State<BusManagementScreen> {
  final BusController busController = Get.put(BusController());
  final Set<String> selectedBuses = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Gestion des Bus"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: selectedBuses.isNotEmpty
            ? [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    if (selectedBuses.length == 1) {
                      final busId = selectedBuses.first;
                      final bus = busController.buses.firstWhere(
                        (b) => b['id'] == busId,
                      );
                      Get.back();
                      _showEditBusSheet(context, bus);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteConfirmDialog(),
                ),
              ]
            : null,
      ),
      body: Obx(
        () => busController.buses.isEmpty
            ? _buildEmptyState(context)
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildStatsBar(),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: busController.buses.length,
                      itemBuilder: (context, index) {
                        final bus = busController.buses[index];
                        return _buildBusCard(bus, context);
                      },
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBusSheet(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_bus_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            "Aucun bus enregistré",
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Text(
              "Qu'attendez-vous pour enregistrer votre premier bus, appuyez sur le bouton +",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Total", busController.buses.length.toString()),
          _buildStatItem(
            "En service",
            busController.buses
                .where((bus) => bus['status'] == 'En service')
                .length
                .toString(),
          ),
          _buildStatItem(
            "En garage",
            busController.buses
                .where((bus) => bus['status'] == 'Garage')
                .length
                .toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildBusCard(Map<String, dynamic> bus, BuildContext context) {
    final statusColor = bus['status'] == 'En service'
        ? Colors.green
        : Colors.orange;
    final isSelected = selectedBuses.contains(bus['id']);

    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (isSelected) {
            selectedBuses.remove(bus['id']);
          } else {
            selectedBuses.add(bus['id']);
          }
        });
      },
      onTap: () {
        if (selectedBuses.isNotEmpty) {
          // Mode suppression: toggle selection
          setState(() {
            if (isSelected) {
              selectedBuses.remove(bus['id']);
            } else {
              selectedBuses.add(bus['id']);
            }
          });
        } else {
          // Mode normal: show details
          _showBusDetailSheet(context, bus);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withAlpha((0.1 * 255).toInt())
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).toInt()),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.directions_bus,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            bus['plateNumber'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.route, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            'Ligne: ${bus['line']}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    bus['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      "Chauffeur: ${bus['driver']}",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                Text(
                  "${bus['seats']} places",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.category, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  "${(bus['sections'] as List?)?.length ?? 0} sections",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBusDetailSheet(BuildContext context, Map<String, dynamic> bus) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 60 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Détails du Bus",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow("Immatriculation", bus['plateNumber']),
              const SizedBox(height: 12),
              _buildDetailRow("Ligne", bus['line']),
              const SizedBox(height: 12),
              _buildDetailRow("Chauffeur", bus['driver']),
              const SizedBox(height: 12),
              _buildDetailRow("Statut", bus['status']),
              const SizedBox(height: 12),
              _buildDetailRow("Capacité", "${bus['seats']} places"),
              const SizedBox(height: 20),
              if (bus['sections'] != null &&
                  (bus['sections'] as List).isNotEmpty) ...[
                Text(
                  "Tarifs par section",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),
                ...(bus['sections'] as List<dynamic>).map(
                  (section) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Section ${section['sectionNumber']}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          "${section['price']} F CFA",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 30),
              // Bouton Générer Code d'Accès
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.back(); // Fermer le detail sheet
                    _showGenerateCodeScreen(context, bus);
                  },
                  icon: const Icon(Icons.vpn_key),
                  label: const Text('Générer Code d\'Accès'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _showAddBusSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _AddBusSheet(busController: busController),
    );
  }

  void _showEditBusSheet(BuildContext context, Map<String, dynamic> bus) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          _EditBusSheet(busController: busController, bus: bus),
    );
  }

  void _showGenerateCodeScreen(BuildContext context, Map<String, dynamic> bus) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GenerateCodeScreen(
          busId: bus['id'],
          busMatricule: bus['plateNumber'],
        ),
      ),
    );
  }

  void _showDeleteConfirmDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  "Attention",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Êtes-vous sûr de vouloir supprimer ${selectedBuses.length} bus sélectionné(s) ? Cette action est irréversible.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Annuler",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    for (final busId in selectedBuses) {
                      busController.deleteBus(busId);
                    }
                    setState(() {
                      selectedBuses.clear();
                    });
                    Get.back();
                  },
                  child: const Text(
                    "Supprimer",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddBusSheet extends StatefulWidget {
  final BusController busController;

  const _AddBusSheet({required this.busController});

  @override
  State<_AddBusSheet> createState() => _AddBusSheetState();
}

class _AddBusSheetState extends State<_AddBusSheet> {
  late TextEditingController plateNumberController;
  late TextEditingController lineController;
  late TextEditingController seatsController;
  late TextEditingController numberOfSectionsController;
  final sectionPriceControllers = <TextEditingController>[];
  int numberOfSections = 0;

  // Driver management
  final DriverController driverController = Get.put(DriverController());
  Driver? selectedDriver;

  @override
  void initState() {
    super.initState();
    plateNumberController = TextEditingController();
    lineController = TextEditingController();
    seatsController = TextEditingController();
    numberOfSectionsController = TextEditingController();
  }

  @override
  void dispose() {
    plateNumberController.dispose();
    lineController.dispose();
    driverController.dispose();
    seatsController.dispose();
    numberOfSectionsController.dispose();
    for (var controller in sectionPriceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 60 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ajouter un bus",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: plateNumberController,
              decoration: InputDecoration(
                labelText: "Numéro d'immatriculation",
                prefixIcon: const Icon(
                  Icons.directions_bus,
                  size: 18,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: lineController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ligne",
                prefixIcon: const Icon(
                  Icons.route,
                  size: 18,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            // Driver Dropdown - Add Bus Sheet
            Obx(
              () => DropdownButton<Driver>(
                isExpanded: true,
                value: selectedDriver,
                hint: const Text('Sélectionner un chauffeur'),
                items: [
                  ...driverController.activeDrivers.map((driver) {
                    return DropdownMenuItem(
                      value: driver,
                      child: Text(driver.name),
                    );
                  }),
                  DropdownMenuItem(
                    value: null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add, size: 18),
                          SizedBox(width: 8),
                          Text('Ajouter nouveau chauffeur'),
                        ],
                      ),
                    ),
                  ),
                ],
                onChanged: (selected) {
                  if (selected == null) {
                    _showAddDriverDialog();
                  } else {
                    setState(() {
                      selectedDriver = selected;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: seatsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nombre de places",
                prefixIcon: const Icon(
                  Icons.event_seat,
                  size: 18,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: numberOfSectionsController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfSections = int.tryParse(value) ?? 0;
                  for (var controller in sectionPriceControllers) {
                    controller.dispose();
                  }
                  sectionPriceControllers.clear();
                  for (int i = 0; i < numberOfSections; i++) {
                    sectionPriceControllers.add(TextEditingController());
                  }
                });
              },
              decoration: InputDecoration(
                labelText: "Nombre de sections",
                prefixIcon: const Icon(
                  Icons.category,
                  size: 18,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            if (numberOfSections > 0) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                "Prix par section (F CFA)",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 4,
                ),
                itemCount: numberOfSections,
                itemBuilder: (context, index) => TextField(
                  controller: sectionPriceControllers[index],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Section ${index + 1}",
                    hintText: "ex: 150",
                    prefixIcon: const Icon(
                      Icons.money,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDriver == null) {
                    Get.snackbar(
                      'Erreur',
                      'Veuillez sélectionner un chauffeur',
                    );
                    return;
                  }
                  final sections = <Map<String, dynamic>>[];
                  for (int i = 0; i < numberOfSections; i++) {
                    sections.add({
                      'sectionNumber': i + 1,
                      'price':
                          int.tryParse(sectionPriceControllers[i].text) ?? 0,
                    });
                  }
                  widget.busController.addBus({
                    'id': DateTime.now().toString(),
                    'plateNumber': plateNumberController.text,
                    'line': lineController.text,
                    'driver': selectedDriver!.name,
                    'status': 'En service',
                    'seats': int.tryParse(seatsController.text) ?? 45,
                    'sections': sections,
                  });
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  "Ajouter",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDriverDialog() {
    final nameController = TextEditingController();
    final licenseController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un Chauffeur'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  hintText: 'Ex: Ousmane Ba',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: licenseController,
                decoration: const InputDecoration(
                  labelText: 'Numéro de Permis',
                  hintText: 'Ex: SN-2021-0001',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  hintText: 'Ex: +221 77 111 22 33',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () async {
              final result = await driverController.createDriver(
                name: nameController.text,
                licenseNumber: licenseController.text,
                phoneNumber: phoneController.text,
              );
              if (result != null) {
                setState(() {
                  selectedDriver = result;
                });
                Get.back();
                Get.snackbar('Succès', 'Chauffeur ajouté');
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}

class _EditBusSheet extends StatefulWidget {
  final BusController busController;
  final Map<String, dynamic> bus;

  const _EditBusSheet({required this.busController, required this.bus});

  @override
  State<_EditBusSheet> createState() => _EditBusSheetState();
}

class _EditBusSheetState extends State<_EditBusSheet> {
  late TextEditingController plateNumberController;
  late TextEditingController lineController;
  late TextEditingController seatsController;
  late TextEditingController numberOfSectionsController;
  final sectionPriceControllers = <TextEditingController>[];
  late List<Map<String, dynamic>> sections;
  late String currentStatus;

  // Driver management
  final DriverController driverController = Get.put(DriverController());
  Driver? selectedDriver;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.bus['status'] ?? 'En service';
    sections = List<Map<String, dynamic>>.from(widget.bus['sections'] ?? []);
    plateNumberController = TextEditingController(
      text: widget.bus['plateNumber'],
    );
    lineController = TextEditingController(text: widget.bus['line']);
    seatsController = TextEditingController(
      text: widget.bus['seats'].toString(),
    );
    numberOfSectionsController = TextEditingController(
      text: sections.length.toString(),
    );

    // Initialize selected driver from bus data
    final driverName = widget.bus['driver'] as String?;
    if (driverName != null) {
      selectedDriver = driverController.activeDrivers.firstWhereOrNull(
        (driver) => driver.name == driverName,
      );
    }

    for (var section in sections) {
      sectionPriceControllers.add(
        TextEditingController(text: section['price'].toString()),
      );
    }
  }

  @override
  void dispose() {
    plateNumberController.dispose();
    lineController.dispose();
    driverController.dispose();
    seatsController.dispose();
    numberOfSectionsController.dispose();
    for (var controller in sectionPriceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 60 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Modifier le bus",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: plateNumberController,
              decoration: InputDecoration(
                labelText: "Numéro d'immatriculation",
                prefixIcon: const Icon(
                  Icons.directions_bus,
                  size: 18,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: lineController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Ligne",
                prefixIcon: const Icon(
                  Icons.route,
                  size: 18,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            // Driver Dropdown - Edit Bus Sheet
            Obx(
              () => DropdownButton<Driver>(
                isExpanded: true,
                value: selectedDriver,
                hint: const Text('Sélectionner un chauffeur'),
                items: [
                  ...driverController.activeDrivers.map((driver) {
                    return DropdownMenuItem(
                      value: driver,
                      child: Text(driver.name),
                    );
                  }),
                  DropdownMenuItem(
                    value: null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add, size: 18),
                          SizedBox(width: 8),
                          Text('Ajouter nouveau chauffeur'),
                        ],
                      ),
                    ),
                  ),
                ],
                onChanged: (selected) {
                  if (selected == null) {
                    _showAddDriverDialog();
                  } else {
                    setState(() {
                      selectedDriver = selected;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: seatsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nombre de places",
                prefixIcon: const Icon(
                  Icons.event_seat,
                  size: 18,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: numberOfSectionsController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  int newCount = int.tryParse(value) ?? 0;
                  int oldCount = sections.length;

                  if (newCount > oldCount) {
                    // Ajouter de nouvelles sections
                    for (int i = oldCount; i < newCount; i++) {
                      sections.add({'sectionNumber': i + 1, 'price': 0});
                      sectionPriceControllers.add(
                        TextEditingController(text: '0'),
                      );
                    }
                  } else if (newCount < oldCount) {
                    // Supprimer les sections à la fin
                    for (int i = newCount; i < oldCount; i++) {
                      sectionPriceControllers[i].dispose();
                    }
                    sections.removeRange(newCount, oldCount);
                    sectionPriceControllers.removeRange(newCount, oldCount);

                    // Mettre à jour les numéros de section pour les sections restantes
                    for (int i = 0; i < sections.length; i++) {
                      sections[i]['sectionNumber'] = i + 1;
                    }
                  }
                });
              },
              decoration: InputDecoration(
                labelText: "Nombre de sections",
                prefixIcon: const Icon(
                  Icons.category,
                  size: 18,
                  color: AppColors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentStatus,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      value: 'En service',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text('En service'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Garage',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warehouse,
                            color: Colors.orange,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text('En garage'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      currentStatus = value ?? 'En service';
                    });
                  },
                ),
              ),
            ),
            if (sections.isNotEmpty) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                "Prix par section (F CFA)",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 4,
                ),
                itemCount: sections.length,
                itemBuilder: (context, index) => TextField(
                  controller: sectionPriceControllers[index],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Section ${sections[index]['sectionNumber']}",
                    prefixIcon: const Icon(
                      Icons.money,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  for (int i = 0; i < sections.length; i++) {
                    sections[i]['price'] =
                        int.tryParse(sectionPriceControllers[i].text) ?? 0;
                  }
                  widget.busController.updateBus(widget.bus['id'], {
                    ...widget.bus,
                    'plateNumber': plateNumberController.text,
                    'line': lineController.text,
                    'driver': selectedDriver?.name ?? widget.bus['driver'],
                    'seats': int.tryParse(seatsController.text) ?? 45,
                    'status': currentStatus,
                    'sections': sections,
                  });
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  "Enregistrer",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDriverDialog() {
    final nameController = TextEditingController();
    final licenseController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un Chauffeur'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  hintText: 'Ex: Ousmane Ba',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: licenseController,
                decoration: const InputDecoration(
                  labelText: 'Numéro de Permis',
                  hintText: 'Ex: SN-2021-0001',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  hintText: 'Ex: +221 77 111 22 33',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () async {
              final result = await driverController.createDriver(
                name: nameController.text,
                licenseNumber: licenseController.text,
                phoneNumber: phoneController.text,
              );
              if (result != null) {
                setState(() {
                  selectedDriver = result;
                });
                Get.back();
                Get.snackbar('Succès', 'Chauffeur ajouté');
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}
