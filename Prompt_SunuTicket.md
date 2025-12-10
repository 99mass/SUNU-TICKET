# 🎫 PROMPT COMPLET : DÉVELOPPEMENT SUNU TICKET (Application Receveur)

## 📱 CONTEXTE DU PROJET

**Nom de l'Application :** SUNU TICKET  
**Plateforme :** Android (Flutter)  
**Public Cible :** Receveurs/Contrôleurs dans les bus urbains au Sénégal  
**Objectif :** Application de vente de tickets simple, rapide, fonctionnant 100% HORS LIGNE avec synchronisation périodique

---

## 🎯 PHILOSOPHIE DE CONCEPTION

### Les Principes Directeurs

1. **SIMPLICITÉ ABSOLUE** : Le receveur doit pouvoir vendre un ticket en 2 secondes maximum
2. **HORS LIGNE D'ABORD** : L'app fonctionne TOUJOURS, même sans réseau
3. **FIABILITÉ MAXIMALE** : Zéro bug toléré - c'est l'outil de travail quotidien
4. **RAPIDITÉ** : Chaque action doit être instantanée
5. **VISIBILITÉ** : Gros boutons, gros textes - lisible en plein soleil

---

## 🎨 CHARTE GRAPHIQUE OFFICIELLE

### Palette de Couleurs (Identique à Pro)

| Usage | Couleur | Code Hex | Description |
|-------|---------|----------|-------------|
| **Primaire** | Bleu Ceruléen | `#0854A2` | Couleur principale |
| **Secondaire** | Orange Vif | `#FF8C00` | Boutons d'action, alertes |
| **Dégradé Start** | Cyan Clair | `#4DD0E1` | Début des dégradés |
| **Dégradé End** | Vert Menthe | `#C8E6C9` | Fin des dégradés |
| **Background** | Bleu Pâle | `#E0F7FA` | Fond général |
| **Success** | Vert | `#27AE60` | Succès, synchronisation OK |
| **Warning** | Orange | `#FF8C00` | Avertissements |
| **Error** | Rouge | `#E74C3C` | Erreurs critiques |
| **Blanc** | Blanc Pur | `#FFFFFF` | Fond des cards |

### Spécificités SUNU TICKET (Receveur)

- **BOUTONS ÉNORMES** : Minimum 80dp de hauteur
- **TEXTE GÉANT** : Montants en 64sp, titres en 32sp
- **CONTRASTE MAXIMUM** : Lisible en plein soleil
- **PAS DE FIORITURES** : Interface fonctionnelle avant tout

---

## 🏗️ ARCHITECTURE DU PROJET

### Structure des Dossiers

```
lib/
├── main.dart
├── app.dart
│
├── features/                    # Fonctionnalités principales
│   ├── session/                # Connexion de session
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── session_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── session_repository.dart
│   │   │   └── datasources/
│   │   │       ├── local/
│   │   │       │   └── session_local_datasource.dart
│   │   │       └── remote/
│   │   │           └── session_remote_datasource.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── session_controller.dart
│   │       ├── screens/
│   │       │   ├── splash_screen.dart
│   │       │   └── login_screen.dart
│   │       └── widgets/
│   │           ├── bus_selector_widget.dart
│   │           └── code_input_widget.dart
│   │
│   ├── selling/                # Vente de tickets
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── ticket_model.dart
│   │   │   │   └── sale_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── sales_repository.dart
│   │   │   └── datasources/
│   │   │       └── local/
│   │   │           ├── sales_local_datasource.dart
│   │   │           └── database/
│   │   │               └── sales_database.dart (SQLite)
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── selling_controller.dart
│   │       ├── screens/
│   │       │   └── selling_screen.dart
│   │       └── widgets/
│   │           ├── price_button.dart
│   │           ├── sale_counter.dart
│   │           └── last_ticket_display.dart
│   │
│   ├── sync/                   # Synchronisation
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── sync_status_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── sync_repository.dart
│   │   │   └── datasources/
│   │   │       └── remote/
│   │   │           └── sync_remote_datasource.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── sync_controller.dart
│   │       └── widgets/
│   │           ├── sync_button.dart
│   │           ├── sync_status_indicator.dart
│   │           └── pending_sales_badge.dart
│   │
│   ├── history/                # Historique des ventes
│   │   ├── data/
│   │   │   ├── repositories/
│   │   │   │   └── history_repository.dart
│   │   │   └── datasources/
│   │   │       └── local/
│   │   │           └── history_local_datasource.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── history_controller.dart
│   │       ├── screens/
│   │       │   └── history_screen.dart
│   │       └── widgets/
│   │           └── sale_item.dart
│   │
│   └── printing/               # Impression Bluetooth
│       ├── data/
│       │   ├── models/
│       │   │   └── printer_model.dart
│       │   └── repositories/
│       │       └── printer_repository.dart
│       └── presentation/
│           ├── controllers/
│           │   └── printer_controller.dart
│           ├── screens/
│           │   └── printer_setup_screen.dart
│           └── widgets/
│               └── printer_status.dart
│
└── shared/                     # Éléments partagés
    ├── constants/
    │   ├── app_colors.dart
    │   ├── app_text_styles.dart
    │   ├── app_dimensions.dart
    │   ├── ticket_prices.dart
    │   └── api_endpoints.dart
    │
    ├── widgets/
    │   ├── big_button.dart
    │   ├── status_banner.dart
    │   ├── loading_overlay.dart
    │   └── network_indicator.dart
    │
    ├── utils/
    │   ├── ticket_formatter.dart
    │   ├── date_helpers.dart
    │   └── currency_helpers.dart
    │
    ├── services/
    │   ├── database_service.dart (SQLite)
    │   ├── storage_service.dart (GetStorage)
    │   ├── api_service.dart (Dio)
    │   ├── printer_service.dart (Bluetooth)
    │   └── network_service.dart
    │
    └── theme/
        └── app_theme.dart
```

---

## 📦 PACKAGES FLUTTER À UTILISER

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  get: ^4.6.6
  
  # API & Networking
  dio: ^5.4.0
  connectivity_plus: ^5.0.2          # Détection réseau
  
  # Database Local (SQLite)
  sqflite: ^2.3.0
  path: ^1.8.3
  
  # Local Storage
  get_storage: ^2.1.1
  
  # Bluetooth Printing
  flutter_bluetooth_serial: ^0.4.0
  esc_pos_utils: ^1.1.0              # Formatage tickets thermiques
  
  # Utils
  intl: ^0.19.0
  logger: ^2.0.2
  uuid: ^4.3.3
  
  # Permission
  permission_handler: ^11.0.1
```

---

## 🎯 MÉTHODOLOGIE DE DÉVELOPPEMENT (ÉTAPE PAR ÉTAPE)

### ⚠️ RÈGLE ABSOLUE : VALIDATION OBLIGATOIRE ENTRE CHAQUE ÉTAPE

Même processus que SUNU TICKET Pro :
1. Développement d'UNE étape
2. Livraison du code complet
3. **TU TESTES et VALIDES**
4. Corrections si nécessaire
5. Passage à l'étape suivante SEULEMENT après validation

---

## 📋 LISTE DES ÉTAPES DE DÉVELOPPEMENT

### 🔷 PHASE 1 : CONFIGURATION & BASE DE DONNÉES

**ÉTAPE 1.1 : Setup Projet & Configuration**
- Structure complète des dossiers
- Configuration `pubspec.yaml`
- Setup des constantes (couleurs, styles, dimensions)
- Thème de l'app optimisé pour receveur
- Configuration GetX

**Livrables :**
- Tous les fichiers de constants
- `lib/main.dart`
- `lib/app.dart`
- `lib/shared/theme/app_theme.dart`

**✋ VALIDATION REQUISE AVANT ÉTAPE 1.2**

---

**ÉTAPE 1.2 : Base de Données SQLite**
- Configuration SQLite
- Schéma de base de données
- Tables : sessions, sales, tickets, sync_queue
- Migrations

**Livrables :**
- `lib/shared/services/database_service.dart`

**Structure de la Base de Données :**

```sql
-- Table : sessions
CREATE TABLE sessions (
  id TEXT PRIMARY KEY,
  bus_id TEXT NOT NULL,
  bus_matricule TEXT NOT NULL,
  session_code TEXT NOT NULL,
  ticket_range_start INTEGER NOT NULL,
  ticket_range_end INTEGER NOT NULL,
  current_ticket_number INTEGER NOT NULL,
  created_at TEXT NOT NULL,
  expires_at TEXT NOT NULL,
  is_active INTEGER DEFAULT 1,
  is_synced INTEGER DEFAULT 0
);

-- Table : sales
CREATE TABLE sales (
  id TEXT PRIMARY KEY,
  session_id TEXT NOT NULL,
  ticket_number INTEGER NOT NULL,
  amount INTEGER NOT NULL,
  timestamp TEXT NOT NULL,
  is_synced INTEGER DEFAULT 0,
  sync_attempts INTEGER DEFAULT 0,
  FOREIGN KEY (session_id) REFERENCES sessions(id)
);

-- Table : sync_queue
CREATE TABLE sync_queue (
  id TEXT PRIMARY KEY,
  data_type TEXT NOT NULL, -- 'sale' ou 'session'
  data_id TEXT NOT NULL,
  data_json TEXT NOT NULL,
  attempts INTEGER DEFAULT 0,
  last_attempt TEXT,
  created_at TEXT NOT NULL
);

-- Index pour performance
CREATE INDEX idx_sales_session ON sales(session_id);
CREATE INDEX idx_sales_synced ON sales(is_synced);
CREATE INDEX idx_sync_queue_type ON sync_queue(data_type);
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 1.3**

---

**ÉTAPE 1.3 : Services de Base**
- StorageService (GetStorage)
- ApiService (Dio)
- NetworkService (détection réseau)
- Helpers et utilitaires

**Livrables :**
- `lib/shared/services/storage_service.dart`
- `lib/shared/services/api_service.dart`
- `lib/shared/services/network_service.dart`
- `lib/shared/utils/ticket_formatter.dart`
- `lib/shared/utils/date_helpers.dart`

**✋ VALIDATION REQUISE AVANT ÉTAPE 1.4**

---

**ÉTAPE 1.4 : Widgets de Base**
- BigButton (bouton géant pour vente)
- StatusBanner (bannière de statut en haut)
- LoadingOverlay
- NetworkIndicator

**Livrables :**
- `lib/shared/widgets/big_button.dart`
- `lib/shared/widgets/status_banner.dart`
- `lib/shared/widgets/loading_overlay.dart`
- `lib/shared/widgets/network_indicator.dart`

**UI Specs BigButton :**
- Hauteur : 100dp minimum
- Coins arrondis : 16dp
- Text size : 48sp pour le montant
- Shadow prononcée
- Feedback tactile fort
- Animation au tap (scale + haptic)

**✋ VALIDATION REQUISE AVANT PHASE 2**

---

### 🔷 PHASE 2 : CONNEXION DE SESSION

**ÉTAPE 2.1 : Modèles - Session**
- SessionModel complet
- Conversion to/from JSON
- Conversion to/from SQLite Map

**Livrables :**
- `lib/features/session/data/models/session_model.dart`

**Structure SessionModel :**
```dart
class SessionModel {
  final String id;
  final String busId;
  final String busMatricule;
  final String sessionCode;
  final int ticketRangeStart;
  final int ticketRangeEnd;
  final int currentTicketNumber;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isActive;
  final bool isSynced;
  
  // Computed
  int get remainingTickets => ticketRangeEnd - currentTicketNumber;
  bool get isExpired => DateTime.now().isAfter(expiresAt);
  double get progressPercentage => 
    (currentTicketNumber - ticketRangeStart) / 
    (ticketRangeEnd - ticketRangeStart);
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.2**

---

**ÉTAPE 2.2 : Repository & Datasources - Session**
- SessionRepository
- LocalDataSource (SQLite)
- RemoteDataSource (API)

**Livrables :**
- `lib/features/session/data/repositories/session_repository.dart`
- `lib/features/session/data/datasources/local/session_local_datasource.dart`
- `lib/features/session/data/datasources/remote/session_remote_datasource.dart`

**Fonctionnalités Repository :**
- Valider code de session (API)
- Sauvegarder session localement
- Récupérer session active
- Terminer session
- Vérifier expiration

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.3**

---

**ÉTAPE 2.3 : Controller - Session**
- SessionController avec GetX
- Gestion états de connexion
- Validation du code
- Démarrage de session
- PIN à 4 chiffres pour déverrouillage rapide

**Livrables :**
- `lib/features/session/presentation/controllers/session_controller.dart`

**États à gérer :**
- idle
- validating
- valid
- invalid
- expired
- locked (nécessite PIN)
- unlocked

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.4**

---

**ÉTAPE 2.4 : UI - Splash Screen**
- Logo avec animation
- Vérification de session active
- Navigation automatique

**Livrables :**
- `lib/features/session/presentation/screens/splash_screen.dart`

**Logique Splash :**
1. Vérifier si session active existe
2. Vérifier si session non expirée
3. Si OUI → Écran de vente (avec PIN)
4. Si NON → Écran de connexion

**UI Specs :**
- Background : Dégradé cyan → vert
- Logo centré GÉANT
- "SUNU TICKET" en dessous
- Loader circulaire
- Durée : 2 secondes max

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.5**

---

**ÉTAPE 2.5 : UI - Login Screen**
- Saisie matricule du bus
- Saisie code de session (6 chiffres)
- Bouton "Démarrer la Session"
- Validation en temps réel

**Livrables :**
- `lib/features/session/presentation/screens/login_screen.dart`
- `lib/features/session/presentation/widgets/bus_selector_widget.dart`
- `lib/features/session/presentation/widgets/code_input_widget.dart`

**UI Specs :**
- Background : Bleu pâle
- Card centrale blanche
- Logo en haut
- Champ matricule : Lecture seule si un seul bus assigné
- Champ code : 6 cases pour les chiffres
- Auto-focus sur première case
- Validation automatique à 6 chiffres
- Bouton géant "DÉMARRER" (orange)
- Messages d'erreur clairs :
  - "Code invalide"
  - "Session expirée"
  - "Pas de connexion internet"

**Logique de Connexion :**
1. User entre matricule + code
2. App contacte le serveur pour valider
3. Si valide :
   - Serveur renvoie les infos session (plage tickets, etc.)
   - App sauvegarde en SQLite
   - User crée un PIN à 4 chiffres
   - Navigation vers écran de vente
4. Si invalide :
   - Message d'erreur
   - Possibilité de réessayer

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.6**

---

**ÉTAPE 2.6 : UI - PIN Lock Screen**
- Écran de déverrouillage rapide
- 4 chiffres
- Tentatives limitées
- Retour à login si trop d'échecs

**Livrables :**
- `lib/features/session/presentation/screens/pin_lock_screen.dart`

**UI Specs :**
- Background sombre (semi-transparent)
- 4 cercles pour les chiffres
- Pavé numérique géant (0-9)
- Animation d'erreur si mauvais PIN
- 3 tentatives max → retour login
- Option "J'ai oublié mon PIN" → retour login

**✋ VALIDATION REQUISE AVANT PHASE 3**

---

### 🔷 PHASE 3 : VENTE DE TICKETS (CŒUR DE L'APP)

**ÉTAPE 3.1 : Modèles - Sales & Tickets**
- TicketModel
- SaleModel
- Conversion JSON et SQLite

**Livrables :**
- `lib/features/selling/data/models/ticket_model.dart`
- `lib/features/selling/data/models/sale_model.dart`

**Structure TicketModel :**
```dart
class TicketModel {
  final String id;
  final int ticketNumber;
  final String sessionId;
  final String busMatricule;
  final String line;
  final int amount;
  final DateTime issuedAt;
  final String qrData; // Pour QR code
  
  // Pour impression
  String toThermalPrintFormat();
}
```

**Structure SaleModel :**
```dart
class SaleModel {
  final String id;
  final String sessionId;
  final int ticketNumber;
  final int amount;
  final DateTime timestamp;
  final bool isSynced;
  final int syncAttempts;
  
  // Computed
  String get formattedAmount => '${amount} FCFA';
  String get formattedTime => DateFormat('HH:mm:ss').format(timestamp);
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.2**

---

**ÉTAPE 3.2 : Repository & Datasources - Sales**
- SalesRepository
- LocalDataSource (SQLite)
- RemoteDataSource (pour sync)

**Livrables :**
- `lib/features/selling/data/repositories/sales_repository.dart`
- `lib/features/selling/data/datasources/local/sales_local_datasource.dart`

**Fonctionnalités Repository :**
- Enregistrer une vente
- Récupérer toutes les ventes non synchronisées
- Marquer une vente comme synchronisée
- Obtenir statistiques du jour
- Nettoyer les ventes anciennes

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.3**

---

**ÉTAPE 3.3 : Service d'Impression Bluetooth**
- Recherche d'imprimantes
- Connexion Bluetooth
- Formatage de ticket thermique
- Impression

**Livrables :**
- `lib/shared/services/printer_service.dart`
- `lib/features/printing/data/models/printer_model.dart`

**Format du Ticket Thermique (58mm) :**
```
════════════════════════
    SUNU TICKET
════════════════════════
Bus: DK-3842-RB
Ligne: 4 Colobane-Liberté

Tarif: 150 FCFA
Ticket N°: 8347

Date: 05/12/2025
Heure: 14:35
════════════════════════
[QR CODE ICI]
════════════════════════
  Merci de votre voyage !
```

**Fonctions PrinterService :**
- `scanForPrinters()` - Liste Bluetooth devices
- `connectToPrinter(address)` - Connexion
- `printTicket(TicketModel)` - Impression
- `testPrint()` - Ticket de test
- `isConnected()` - Statut connexion

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.4**

---

**ÉTAPE 3.4 : Controller - Selling**
- SellingController
- Logique de vente
- Gestion du compteur de tickets
- Sauvegarde en base locale
- Déclenchement impression

**Livrables :**
- `lib/features/selling/presentation/controllers/selling_controller.dart`

**Flux de Vente :**
1. User appuie sur bouton prix (ex: 150 FCFA)
2. Controller :
   - Génère ID de vente (UUID)
   - Récupère numéro de ticket suivant
   - Crée SaleModel
   - Sauvegarde en SQLite
   - Incrémente le compteur
   - Déclenche l'impression
3. UI :
   - Animation de succès
   - Son (optionnel)
   - Mise à jour compteurs
   - Imprimante imprime

**États à gérer :**
- ready (prêt à vendre)
- selling (en cours)
- printing (impression)
- success (vente réussie)
- error (erreur impression/sauvegarde)

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.5**

---

**ÉTAPE 3.5 : UI - Selling Screen (Structure)**
- Layout principal
- AppBar avec infos session
- Zone de boutons de prix
- Zone d'informations

**Livrables :**
- `lib/features/selling/presentation/screens/selling_screen.dart`

**Layout de l'Écran :**
```
┌─────────────────────────────────┐
│ [StatusBanner] Sync + Réseau    │ ← Bannière en haut
├─────────────────────────────────┤
│                                 │
│  Bus: DK-3842-RB                │ ← Infos session
│  Tickets restants: 653          │
│                                 │
├─────────────────────────────────┤
│                                 │
│   ┌───────────┐ ┌───────────┐  │
│   │           │ │           │  │
│   │  150 F    │ │  100 F    │  │ ← Boutons GÉANTS
│   │           │ │           │  │
│   └───────────┘ └───────────┘  │
│                                 │
│   ┌───────────┐ ┌───────────┐  │
│   │           │ │           │  │
│   │  200 F    │ │  Autre    │  │
│   │           │ │           │  │
│   └───────────┘ └───────────┘  │
│                                 │
├─────────────────────────────────┤
│                                 │
│  Dernier ticket: #8347          │ ← Infos dernière vente
│  Total du jour: 52 050 FCFA    │
│  Ventes du jour: 347            │
│                                 │
└─────────────────────────────────┘
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.6**

---

**ÉTAPE 3.6 : UI - Price Buttons (Boutons de Prix)**
- Boutons géants pour chaque tarif
- Animation au tap
- Feedback haptique
- States (enabled/disabled/loading)

**Livrables :**
- `lib/features/selling/presentation/widgets/price_button.dart`

**UI Specs :**
- Taille : 160dp x 160dp
- Border radius : 20dp
- Gradient background (cyan → vert pour normal, orange pour réduit)
- Text : 64sp pour le montant
- Shadow importante
- Animation scale au tap (0.95)
- Haptic feedback fort
- Disabled si session expirée ou imprimante déconnectée

**Prix configurables :**
- 150 FCFA (Normal) - Bleu
- 100 FCFA (Étudiant/Réduit) - Orange
- 200 FCFA (Spécial) - Vert
- "Autre" (saisie manuelle) - Gris

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.7**

---

**ÉTAPE 3.7 : UI - Sale Counter & Stats**
- Compteur de ventes du jour
- Recettes du jour
- Dernier ticket vendu
- Mise à jour en temps réel

**Livrables :**
- `lib/features/selling/presentation/widgets/sale_counter.dart`
- `lib/features/selling/presentation/widgets/last_ticket_display.dart`

**UI Specs Sale Counter :**
- Card blanche avec ombre
- 3 infos en ligne :
  - Ventes : 347 (icône ticket)
  - Recettes : 52 050 FCFA (icône money)
  - Restants : 653 (icône stack)
- Text bold, tailles adaptées
- Animation des chiffres qui changent

**UI Specs Last Ticket :**
- Banner horizontal
- "Dernier ticket : #8347 à 14:35"
- Animation slide-in à chaque nouvelle vente
- Fond gradient léger

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.8**

---

**ÉTAPE 3.8 : UI - Status Banner**
- Bannière de statut en haut
- Indicateur de réseau
- Indicateur de synchronisation
- Nombre de ventes en attente

**Livrables :**
- Intégration dans StatusBanner (déjà créé en Phase 1)

**UI Specs :**
- Hauteur : 50dp
- Fond : vert si tout OK, orange si ventes non sync, rouge si problème
- Icônes : WiFi + Sync
- Text : "Connecté - 0 ventes en attente" ou "Hors ligne - 23 ventes à synchroniser"
- Tap pour forcer sync

**✋ VALIDATION REQUISE AVANT PHASE 4**

---

### 🔷 PHASE 4 : SYNCHRONISATION

**ÉTAPE 4.1 : Modèle - Sync Status**
- SyncStatusModel
- État de synchronisation

**Livrables :**
- `lib/features/sync/data/models/sync_status_model.dart`

**Structure :**
```dart
class SyncStatusModel {
  final int pendingSales;
  final int totalSalesToday;
  final DateTime? lastSyncTime;
  final bool isSyncing;
  final bool hasError;
  final String? errorMessage;
  
  // Computed
  bool get needsSync => pendingSales > 0;
  String get lastSyncText => lastSyncTime == null 
    ? 'Jamais synchronisé' 
    : 'Sync il y a ${timeAgo(lastSyncTime!)}';
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 4.2**

---

**ÉTAPE 4.2 : Repository - Sync**
- SyncRepository
- Upload des ventes vers serveur
- Gestion des erreurs
- Retry mechanism

**Livrables :**
- `lib/features/sync/data/repositories/sync_repository.dart`
- `lib/features/sync/data/datasources/remote/sync_remote_datasource.dart`

**Fonctionnalités :**
- `syncPendingSales()` - Synchroniser toutes les ventes en attente
- `syncSingleSale(saleId)` - Sync une vente spécifique
- `getSyncStatus()` - Statut actuel
- `clearSyncedSales()` - Nettoyer les ventes sync anciennes

**Logique de Sync :**
1. Récupérer toutes les ventes avec `is_synced = 0`
2. Grouper par lots de 50
3. Envoyer au serveur (POST /api/sales/batch)
4. Si succès : Marquer comme sync (`is_synced = 1`)
5. Si échec : Incrémenter `sync_attempts`, réessayer plus tard

**✋ VALIDATION REQUISE AVANT ÉTAPE 4.3**

---

**ÉTAPE 4.3 : Controller - Sync**
- SyncController
- Synchronisation automatique
- Synchronisation manuelle
- Détection de réseau

**Livrables :**
- `lib/features/sync/presentation/controllers/sync_controller.dart`

**