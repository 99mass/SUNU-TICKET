import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunu_ticket_pro/core/constants/app_colors.dart';
import 'package:sunu_ticket_pro/features/driver_management/presentation/controllers/driver_controller.dart';
import 'package:sunu_ticket_pro/features/driver_management/data/models/driver_model.dart';
import 'package:sunu_ticket_pro/features/receiver_management/presentation/controllers/receiver_controller.dart';
import 'package:sunu_ticket_pro/features/receiver_management/data/models/receiver_model.dart';

class PersonnelManagementScreen extends StatefulWidget {
  const PersonnelManagementScreen({super.key});

  @override
  State<PersonnelManagementScreen> createState() =>
      _PersonnelManagementScreenState();
}

class _PersonnelManagementScreenState extends State<PersonnelManagementScreen>
    with TickerProviderStateMixin {
  final DriverController driverController = Get.put(DriverController());
  final ReceiverController receiverController = Get.put(ReceiverController());
  late TabController _tabController;
  final Set<String> selectedDrivers = {};
  final Set<String> selectedReceivers = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Gestion du Personnel'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: _buildAppBarActions(),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          onTap: (_) {
            setState(() {
              selectedDrivers.clear();
              selectedReceivers.clear();
            });
          },
          tabs: const [
            Tab(text: 'Chauffeurs', icon: Icon(Icons.directions_car)),
            Tab(text: 'Receveurs', icon: Icon(Icons.people)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildDriversTab(), _buildReceiversTab()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_tabController.index == 0) {
            _showAddDriverDialog();
          } else {
            _showAddReceiverDialog();
          }
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget>? _buildAppBarActions() {
    if (_tabController.index == 0 && selectedDrivers.isNotEmpty) {
      return [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            if (selectedDrivers.length == 1) {
              final driverId = selectedDrivers.first;
              final driver = driverController.activeDrivers.firstWhere(
                (d) => d.id == driverId,
              );
              _showEditDriverDialog(driver);
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _showDeleteConfirmDialog(
            'Supprimer ${selectedDrivers.length} chauffeur(s)?',
            () async {
              for (final id in selectedDrivers) {
                await driverController.deleteDriver(id);
              }
              setState(() => selectedDrivers.clear());
              if (mounted) {
                Get.snackbar('Succès', 'Chauffeur(s) supprimé(s)');
              }
            },
          ),
        ),
      ];
    } else if (_tabController.index == 1 && selectedReceivers.isNotEmpty) {
      return [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            if (selectedReceivers.length == 1) {
              final receiverId = selectedReceivers.first;
              final receiver = receiverController.activeReceivers.firstWhere(
                (r) => r.id == receiverId,
              );
              _showEditReceiverDialog(receiver);
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _showDeleteConfirmDialog(
            'Supprimer ${selectedReceivers.length} receveur(s)?',
            () async {
              for (final id in selectedReceivers) {
                await receiverController.deleteReceiver(id);
              }
              setState(() => selectedReceivers.clear());
              if (mounted) {
                Get.snackbar('Succès', 'Receveur(s) supprimé(s)');
              }
            },
          ),
        ),
      ];
    }
    return null;
  }

  Widget _buildDriversTab() {
    return Obx(() {
      if (driverController.activeDrivers.isEmpty) {
        return _buildEmptyState(
          icon: Icons.directions_car,
          title: 'Aucun chauffeur',
          message: 'Appuyez sur + pour ajouter un chauffeur',
        );
      }
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatsBar(
              total: driverController.activeDrivers.length,
              label1: 'Total',
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: driverController.activeDrivers.length,
              itemBuilder: (context, index) {
                final driver = driverController.activeDrivers[index];
                final isSelected = selectedDrivers.contains(driver.id);
                return _buildDriverCard(driver, context, isSelected);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildReceiversTab() {
    return Obx(() {
      if (receiverController.activeReceivers.isEmpty) {
        return _buildEmptyState(
          icon: Icons.people,
          title: 'Aucun receveur',
          message: 'Appuyez sur + pour ajouter un receveur',
        );
      }
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatsBar(
              total: receiverController.activeReceivers.length,
              label1: 'Total',
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: receiverController.activeReceivers.length,
              itemBuilder: (context, index) {
                final receiver = receiverController.activeReceivers[index];
                final isSelected = selectedReceivers.contains(receiver.id);
                return _buildReceiverCard(receiver, context, isSelected);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBar({required int total, required String label1}) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildStatItem(label1, total.toString())],
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

  Widget _buildDriverCard(
    Driver driver,
    BuildContext context,
    bool isSelected,
  ) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (isSelected) {
            selectedDrivers.remove(driver.id);
          } else {
            selectedDrivers.add(driver.id);
          }
        });
      },
      onTap: () {
        if (selectedDrivers.isNotEmpty) {
          setState(() {
            if (isSelected) {
              selectedDrivers.remove(driver.id);
            } else {
              selectedDrivers.add(driver.id);
            }
          });
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
                            Icons.directions_car,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            driver.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.card_membership,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Permis: ${driver.licenseNumber}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            driver.phoneNumber,
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
                    color: Colors.green.withAlpha((0.2 * 255).toInt()),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    driver.status,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
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

  Widget _buildReceiverCard(
    Receiver receiver,
    BuildContext context,
    bool isSelected,
  ) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (isSelected) {
            selectedReceivers.remove(receiver.id);
          } else {
            selectedReceivers.add(receiver.id);
          }
        });
      },
      onTap: () {
        if (selectedReceivers.isNotEmpty) {
          setState(() {
            if (isSelected) {
              selectedReceivers.remove(receiver.id);
            } else {
              selectedReceivers.add(receiver.id);
            }
          });
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
                            Icons.people,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            receiver.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            receiver.phoneNumber,
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
                    color: Colors.green.withAlpha((0.2 * 255).toInt()),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    receiver.status,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
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

  void _showEditDriverDialog(dynamic driver) {
    final nameController = TextEditingController(text: driver.name);
    final licenseController = TextEditingController(text: driver.licenseNumber);
    final phoneController = TextEditingController(text: driver.phoneNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le Chauffeur'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: licenseController,
                decoration: const InputDecoration(
                  labelText: 'Numéro de Permis',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Téléphone'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Info', 'Modification en cours de développement');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Modifier'),
          ),
        ],
      ),
    );
  }

  void _showAddReceiverDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un Receveur'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  hintText: 'Ex: Amadou Ndiaye',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  hintText: 'Ex: +221 77 123 45 67',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () async {
              final result = await receiverController.createReceiver(
                name: nameController.text,
                phoneNumber: phoneController.text,
              );
              if (result != null) {
                Get.back();
                Get.snackbar('Succès', 'Receveur ajouté');
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _showEditReceiverDialog(dynamic receiver) {
    final nameController = TextEditingController(text: receiver.name);
    final phoneController = TextEditingController(text: receiver.phoneNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le Receveur'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Téléphone'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Info', 'Modification en cours de développement');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Modifier'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(String message, VoidCallback onConfirm) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirmation'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () {
              onConfirm();
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
