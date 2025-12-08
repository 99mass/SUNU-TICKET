import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sunu_ticket_pro/core/constants/app_colors.dart';
import 'package:sunu_ticket_pro/features/session_management/presentation/controllers/session_controller.dart';
import 'package:sunu_ticket_pro/features/receiver_management/presentation/controllers/receiver_controller.dart';
import 'package:sunu_ticket_pro/features/receiver_management/data/models/receiver_model.dart';

class GenerateCodeScreen extends StatefulWidget {
  final String busId;
  final String busMatricule;
  final String busLine;

  const GenerateCodeScreen({
    required this.busId,
    required this.busMatricule,
    required this.busLine,
    super.key,
  });

  @override
  State<GenerateCodeScreen> createState() => _GenerateCodeScreenState();
}

class _GenerateCodeScreenState extends State<GenerateCodeScreen> {
  final SessionController sessionController = Get.put(SessionController());
  final ReceiverController receiverController = Get.put(ReceiverController());
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    receiverNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Générer Code d\'Accès'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (sessionController.generatedCode.value == null) {
            return _buildGenerationForm();
          } else {
            return _buildCodeDisplay(sessionController.generatedCode.value!);
          }
        }),
      ),
    );
  }

  Widget _buildGenerationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Informations du bus
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informations du Bus',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Matricule', widget.busMatricule),
              _buildInfoRow('Ligne', widget.busLine),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Sélection du receveur
        Text(
          'Sélectionner ou Ajouter un Receveur',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => DropdownButton<Receiver>(
            isExpanded: true,
            dropdownColor: AppColors.white,
            value: receiverController.selectedReceiver.value,
            hint: const Text('Choisir un receveur'),
            items: [
              ...receiverController.activeReceivers.map((receiver) {
                return DropdownMenuItem(
                  value: receiver,
                  child: Text(receiver.name),
                );
              }),
              DropdownMenuItem(
                value: null,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.add, size: 18),
                      SizedBox(width: 8),
                      Text('Ajouter nouveau receveur'),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (selected) {
              if (selected == null) {
                _showAddReceiverDialog();
              } else {
                receiverController.selectReceiver(selected);
              }
            },
          ),
        ),
        const SizedBox(height: 24),
        // Bouton de génération
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton.icon(
              onPressed:
                  (sessionController.isLoading.value ||
                      receiverController.selectedReceiver.value == null)
                  ? null
                  : () => _generateCode(),
              icon: const Icon(Icons.vpn_key),
              label: Text(
                sessionController.isLoading.value
                    ? 'Génération en cours...'
                    : 'Générer le Code',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Informations
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha((0.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary, width: 1),
          ),
          child: const Text(
            'Le code d\'accès sera valide pendant 24 heures. Une plage de 1000 tickets sera attribuée.',
            style: TextStyle(fontSize: 12, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildCodeDisplay(dynamic sessionCode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Succès
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withAlpha((0.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green, width: 1),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Code Généré avec Succès!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Code d'accès
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.1 * 255).toInt()),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Code d\'Accès',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Text(
                sessionCode.code,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 8,
                ),
              ),
              const SizedBox(height: 20),
              Container(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 20),
              // Détails
              _buildDetailRow('Matricule du Bus', sessionCode.busMatricule),
              const SizedBox(height: 12),
              _buildDetailRow('Receveur', sessionCode.receiverName),
              const SizedBox(height: 12),
              _buildDetailRow(
                'Plage de Tickets',
                '${sessionCode.ticketRangeStart} - ${sessionCode.ticketRangeEnd}',
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                'Expire dans',
                '${sessionCode.minutesRemaining} minutes',
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                'Synchronisé',
                sessionCode.isSynced ? '✓ Oui' : '✗ Non',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Boutons d'action
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _copyToClipboard(sessionCode.code),
                icon: const Icon(Icons.copy),
                label: const Text('Copier'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _generateNewCode(),
                icon: const Icon(Icons.refresh),
                label: const Text('Nouveau'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('Fermer'),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Future<void> _generateCode() async {
    final receiver = receiverController.selectedReceiver.value;
    if (receiver == null) {
      Get.snackbar('Erreur', 'Veuillez sélectionner un receveur');
      return;
    }
    await sessionController.generateAccessCode(
      busId: widget.busId,
      busMatricule: widget.busMatricule,
      receiverName: receiver.name,
    );
  }

  void _copyToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code)).then((_) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(
          content: Text('Code copié: $code'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  void _generateNewCode() {
    sessionController.resetGeneratedCode();
  }

  void _showAddReceiverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: const Text(
          'Ajouter un Receveur',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: receiverNameController,
              decoration: const InputDecoration(
                labelText: 'Nom du receveur',
                hintText: 'Ex: Amadou Ndiaye',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Numéro de téléphone',
                hintText: 'Ex: +221 77 123 45 67',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () => _addNewReceiver(),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _addNewReceiver() async {
    final name = receiverNameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      Get.snackbar('Erreur', 'Veuillez remplir tous les champs');
      return;
    }

    final result = await receiverController.createReceiver(
      name: name,
      phoneNumber: phone,
    );

    if (result != null) {
      receiverNameController.clear();
      phoneController.clear();
      Get.back();
      Get.snackbar('Succès', 'Receveur ajouté avec succès');
    }
  }
}
