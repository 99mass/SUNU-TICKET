# 🚌 PROMPT COMPLET : DÉVELOPPEMENT SUNU TICKET PRO (Flutter)

## 📱 CONTEXTE DU PROJET

**Nom de l'Application :** SUNU TICKET Pro  
**Plateforme :** Android (Flutter)  
**Public Cible :** Propriétaires de bus urbains au Sénégal  
**Objectif :** Application de gestion et monitoring en temps réel des recettes de billetterie électronique

---

## 🎨 CHARTE GRAPHIQUE OFFICIELLE

### Palette de Couleurs

| Usage | Couleur | Code Hex | Description |
|-------|---------|----------|-------------|
| **Primaire** | Bleu Ceruléen | `#0854A2` | Couleur principale (boutons, headers, éléments actifs) |
| **Secondaire** | Orange Vif | `#FF8C00` | Accents, alertes, badges, actions importantes |
| **Dégradé Start** | Cyan Clair | `#4DD0E1` | Début des dégradés (cards, backgrounds) |
| **Dégradé End** | Vert Menthe | `#C8E6C9` | Fin des dégradés (cards, backgrounds) |
| **Background** | Bleu Pâle | `#E0F7FA` | Fond général de l'application |
| **Texte Principal** | Gris Foncé | `#2C3E50` | Texte principal (titres, labels) |
| **Texte Secondaire** | Gris Moyen | `#7F8C8D` | Texte secondaire (sous-titres, hints) |
| **Succès** | Vert | `#27AE60` | Messages de succès, validations |
| **Erreur** | Rouge | `#E74C3C` | Erreurs, alertes critiques |
| **Blanc** | Blanc Pur | `#FFFFFF` | Fond des cards, texte sur fond foncé |

### Logo et Identité Visuelle

- **Logo Principal :** Bus bleu (#0854A2) avec ticket au-dessus, flèches circulaires symbolisant le cycle de vente
- **Icône App :** Version simplifiée du logo sur fond dégradé cyan → vert menthe
- **Typographie :** 
  - Titres : **Poppins Bold** (si disponible, sinon system bold)
  - Corps : **Roboto Regular** (font système par défaut)

---

## 🏗️ ARCHITECTURE DU PROJET

### Structure des Dossiers

```
lib/
├── main.dart
├── app.dart
│
├── features/                    # Fonctionnalités principales
│   ├── auth/                   # Authentification
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── auth_response_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── datasources/
│   │   │       ├── auth_remote_datasource.dart
│   │   │       └── mock_data/
│   │   │           └── users.json
│   │   ├── presentation/
│   │   │   ├── controllers/
│   │   │   │   └── auth_controller.dart
│   │   │   ├── screens/
│   │   │   │   ├── splash_screen.dart
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── register_screen.dart
│   │   │   │   └── otp_verification_screen.dart
│   │   │   └── widgets/
│   │   │       ├── custom_text_field.dart
│   │   │       └── auth_button.dart
│   │   └── domain/
│   │       └── entities/
│   │           └── user_entity.dart
│   │
│   ├── dashboard/              # Tableau de bord principal
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── dashboard_stats_model.dart
│   │   │   │   └── bus_summary_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── dashboard_repository.dart
│   │   │   └── datasources/
│   │   │       └── mock_data/
│   │   │           └── dashboard_stats.json
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── dashboard_controller.dart
│   │       ├── screens/
│   │       │   └── dashboard_screen.dart
│   │       └── widgets/
│   │           ├── stats_card.dart
│   │           ├── revenue_chart.dart
│   │           ├── bus_list_item.dart
│   │           └── alert_banner.dart
│   │
│   ├── bus_management/         # Gestion des bus
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── bus_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── bus_repository.dart
│   │   │   └── datasources/
│   │   │       └── mock_data/
│   │   │           └── buses.json
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── bus_controller.dart
│   │       ├── screens/
│   │       │   ├── bus_list_screen.dart
│   │       │   ├── add_bus_screen.dart
│   │       │   ├── edit_bus_screen.dart
│   │       │   └── bus_details_screen.dart
│   │       └── widgets/
│   │           ├── bus_card.dart
│   │           └── bus_form.dart
│   │
│   ├── session_management/     # Génération codes session
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── session_model.dart
│   │   │   │   └── session_code_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── session_repository.dart
│   │   │   └── datasources/
│   │   │       └── mock_data/
│   │   │           └── sessions.json
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── session_controller.dart
│   │       ├── screens/
│   │       │   ├── generate_code_screen.dart
│   │       │   ├── active_sessions_screen.dart
│   │       │   └── session_history_screen.dart
│   │       └── widgets/
│   │           ├── session_code_display.dart
│   │           ├── bus_selector.dart
│   │           └── session_card.dart
│   │
│   ├── sales_monitoring/       # Monitoring ventes temps réel
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── sale_model.dart
│   │   │   │   ├── ticket_model.dart
│   │   │   │   └── real_time_stats_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── sales_repository.dart
│   │   │   └── datasources/
│   │   │       └── mock_data/
│   │   │           ├── sales.json
│   │   │           └── tickets.json
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── sales_controller.dart
│   │       ├── screens/
│   │       │   ├── real_time_monitoring_screen.dart
│   │       │   ├── sales_history_screen.dart
│   │       │   └── ticket_details_screen.dart
│   │       └── widgets/
│   │           ├── live_stats_card.dart
│   │           ├── ticket_list_item.dart
│   │           └── sales_timeline.dart
│   │
│   ├── reports/                # Rapports et analyses
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── daily_report_model.dart
│   │   │   │   ├── weekly_report_model.dart
│   │   │   │   └── monthly_report_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── reports_repository.dart
│   │   │   └── datasources/
│   │   │       └── mock_data/
│   │   │           └── reports.json
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── reports_controller.dart
│   │       ├── screens/
│   │       │   ├── reports_screen.dart
│   │       │   ├── daily_report_screen.dart
│   │       │   └── comparative_analysis_screen.dart
│   │       └── widgets/
│   │           ├── report_card.dart
│   │           ├── chart_widget.dart
│   │           └── export_button.dart
│   │
│   ├── fraud_detection/        # Détection fraudes
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── fraud_alert_model.dart
│   │   │   │   └── anomaly_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── fraud_repository.dart
│   │   │   └── datasources/
│   │   │       └── mock_data/
│   │   │           └── fraud_alerts.json
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── fraud_controller.dart
│   │       ├── screens/
│   │       │   ├── fraud_alerts_screen.dart
│   │       │   └── alert_details_screen.dart
│   │       └── widgets/
│   │           ├── alert_card.dart
│   │           └── severity_badge.dart
│   │
│   └── profile/                # Profil utilisateur
│       ├── data/
│       │   ├── models/
│       │   │   └── profile_model.dart
│       │   ├── repositories/
│       │   │   └── profile_repository.dart
│       │   └── datasources/
│       │       └── mock_data/
│       │           └── profile.json
│       └── presentation/
│           ├── controllers/
│           │   └── profile_controller.dart
│           ├── screens/
│           │   ├── profile_screen.dart
│           │   ├── edit_profile_screen.dart
│           │   └── settings_screen.dart
│           └── widgets/
│               └── profile_header.dart
│
└── shared/                     # Éléments partagés
    ├── constants/
    │   ├── app_colors.dart
    │   ├── app_text_styles.dart
    │   ├── app_dimensions.dart
    │   ├── api_endpoints.dart
    │   └── app_strings.dart
    │
    ├── widgets/
    │   ├── custom_app_bar.dart
    │   ├── custom_button.dart
    │   ├── custom_card.dart
    │   ├── loading_indicator.dart
    │   ├── error_widget.dart
    │   ├── empty_state_widget.dart
    │   ├── bottom_nav_bar.dart
    │   └── gradient_container.dart
    │
    ├── utils/
    │   ├── formatters.dart
    │   ├── validators.dart
    │   ├── date_helpers.dart
    │   └── currency_helpers.dart
    │
    ├── services/
    │   ├── api_service.dart
    │   ├── storage_service.dart
    │   ├── notification_service.dart
    │   └── mock_api_service.dart
    │
    ├── models/
    │   └── api_response.dart
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
  get: ^4.6.6                    # GetX pour state management et routing
  
  # API & Networking
  dio: ^5.4.0                    # HTTP client
  
  # Data Persistence
  get_storage: ^2.1.1            # Local storage simple
  
  # UI Components
  fl_chart: ^0.66.0              # Charts et graphiques
  intl: ^0.19.0                  # Formatage dates et nombres
  cached_network_image: ^3.3.1  # Cache images
  
  # Utils
  logger: ^2.0.2                 # Logging
  uuid: ^4.3.3                   # Génération UUID
```

---

## 🎯 MÉTHODOLOGIE DE DÉVELOPPEMENT (ÉTAPE PAR ÉTAPE)

### ⚠️ RÈGLE ABSOLUE : VALIDATION OBLIGATOIRE ENTRE CHAQUE ÉTAPE

**Processus de développement :**

1. Je développe UNE SEULE ÉTAPE à la fois
2. Je fournis le code complet de l'étape
3. **TU TESTES et VALIDES** l'étape
4. Tu me donnes ton feedback (bugs, modifications, validations)
5. Je corrige si nécessaire
6. **SEULEMENT après ta validation explicite**, je passe à l'étape suivante

**Format de validation attendu de ta part :**

```
✅ ÉTAPE X VALIDÉE
- Fonctionnalité testée : OK
- UI conforme : OK
- Pas de bugs détectés : OK
- Commentaires : [tes remarques]

➡️ PRÊT POUR ÉTAPE X+1
```

---

## 📋 LISTE DES ÉTAPES DE DÉVELOPPEMENT

### 🔷 PHASE 1 : CONFIGURATION & STRUCTURE DE BASE

**ÉTAPE 1.1 : Setup Projet & Configuration Initiale**
- Création de la structure de dossiers complète
- Configuration `pubspec.yaml`
- Setup des constantes (couleurs, styles, dimensions)
- Création du thème de l'app
- Configuration GetX

**Livrables :**
- `lib/shared/constants/app_colors.dart`
- `lib/shared/constants/app_text_styles.dart`
- `lib/shared/constants/app_dimensions.dart`
- `lib/shared/theme/app_theme.dart`
- `lib/main.dart`
- `lib/app.dart`

**✋ VALIDATION REQUISE AVANT ÉTAPE 4.4**

---

**ÉTAPE 4.4 : UI - Add Bus Screen**
- Formulaire d'ajout de bus
- Validation en temps réel
- Photo du bus (optionnel)
- Sélection ligne

**Livrables :**
- `lib/features/bus_management/presentation/screens/add_bus_screen.dart`
- `lib/features/bus_management/presentation/widgets/bus_form.dart`

**UI Specs :**
- Formulaire avec sections
- Champs : Matricule, Ligne, Nom chauffeur, Téléphone chauffeur
- Bouton "Ajouter Bus" en bas (bleu)
- Validation : matricule unique, téléphone valide
- Success snackbar après ajout

**✋ VALIDATION REQUISE AVANT ÉTAPE 4.5**

---

**ÉTAPE 4.5 : UI - Bus Details Screen**
- Vue détaillée d'un bus
- Statistiques lifetime
- Historique des 30 derniers jours
- Options de modification/suppression

**Livrables :**
- `lib/features/bus_management/presentation/screens/bus_details_screen.dart`

**UI Specs :**
- Hero animation depuis la liste
- Header avec photo et matricule
- Cards : Recettes totales, Tickets totaux, Jours actifs
- Graphique performance 30 jours
- Boutons : Éditer, Supprimer, Générer Code

**✋ VALIDATION REQUISE AVANT ÉTAPE 4.6**

---

**ÉTAPE 4.6 : UI - Edit Bus Screen**
- Modification des infos bus
- Formulaire pré-rempli
- Validation
- Confirmation avant sauvegarde

**Livrables :**
- `lib/features/bus_management/presentation/screens/edit_bus_screen.dart`

**UI Specs :**
- Même formulaire que Add Bus mais pré-rempli
- Bouton "Sauvegarder" au lieu de "Ajouter"
- Dialog de confirmation si modifications importantes
- Success message après update

**✋ VALIDATION REQUISE AVANT PHASE 5**

---

### 🔷 PHASE 5 : GESTION DES SESSIONS

**ÉTAPE 5.1 : Modèles & Données Mock - Sessions**
- Modèle Session
- Modèle SessionCode
- Fichier JSON avec sessions actives/historiques
- Repository

**Livrables :**
- `lib/features/session_management/data/models/session_model.dart`
- `lib/features/session_management/data/models/session_code_model.dart`
- `lib/features/session_management/data/datasources/mock_data/sessions.json`

**Contenu `sessions.json` :**
```json
{
  "active_sessions": [
    {
      "session_id": "session_001",
      "bus_id": "bus_001",
      "bus_matricule": "DK-3842-RB",
      "code": "428951",
      "created_at": "2025-12-05T06:00:00Z",
      "expires_at": "2025-12-06T00:00:00Z",
      "status": "active",
      "ticket_range_start": 8000,
      "ticket_range_end": 9000,
      "current_ticket_number": 8347,
      "receiver_name": "Moussa Ba",
      "is_synced": true,
      "last_sync": "2025-12-05T18:30:00Z"
    },
    {
      "session_id": "session_002",
      "bus_id": "bus_002",
      "bus_matricule": "DK-4521-AB",
      "code": "683492",
      "created_at": "2025-12-05T06:30:00Z",
      "expires_at": "2025-12-06T00:30:00Z",
      "status": "active",
      "ticket_range_start": 5000,
      "ticket_range_end": 6000,
      "current_ticket_number": 5623,
      "receiver_name": "Ibrahima Ndiaye",
      "is_synced": true,
      "last_sync": "2025-12-05T18:45:00Z"
    }
  ],
  "session_history": [
    {
      "session_id": "session_h_001",
      "bus_id": "bus_001",
      "bus_matricule": "DK-3842-RB",
      "code": "157893",
      "created_at": "2025-12-04T06:00:00Z",
      "expires_at": "2025-12-05T00:00:00Z",
      "status": "expired",
      "ticket_range_start": 7000,
      "ticket_range_end": 8000,
      "total_tickets_sold": 412,
      "total_revenue": 61800,
      "receiver_name": "Moussa Ba",
      "anomalies_detected": 0
    },
    {
      "session_id": "session_h_002",
      "bus_id": "bus_002",
      "bus_matricule": "DK-4521-AB",
      "code": "892341",
      "created_at": "2025-12-04T06:30:00Z",
      "expires_at": "2025-12-05T00:30:00Z",
      "status": "expired",
      "ticket_range_start": 4000,
      "ticket_range_end": 5000,
      "total_tickets_sold": 387,
      "total_revenue": 58050,
      "receiver_name": "Ibrahima Ndiaye",
      "anomalies_detected": 1
    }
  ]
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 5.2**

---

**ÉTAPE 5.2 : Controller - Session Management**
- SessionController
- Génération de codes aléatoires (6 chiffres)
- Attribution de plages de tickets
- Validation de codes
- Gestion expiration

**Livrables :**
- `lib/features/session_management/presentation/controllers/session_controller.dart`

**Logique de génération :**
- Code : 6 chiffres aléatoires
- Ticket range : 1000 tickets par session
- Expiration : 24h après création
- Vérification : code unique par bus/jour

**✋ VALIDATION REQUISE AVANT ÉTAPE 5.3**

---

**ÉTAPE 5.3 : UI - Generate Code Screen**
- Sélection du bus
- Bouton "Générer Code Session"
- Affichage du code en GRAND
- Options de partage (WhatsApp, SMS, Copier)
- Animation de génération

**Livrables :**
- `lib/features/session_management/presentation/screens/generate_code_screen.dart`
- `lib/features/session_management/presentation/widgets/session_code_display.dart`
- `lib/features/session_management/presentation/widgets/bus_selector.dart`

**UI Specs :**
- Dropdown pour sélectionner le bus
- Bouton orange "Générer Code" avec icône
- Code affiché en très gros (48sp) dans une card
- Animation : confetti ou pulse lors de la génération
- Boutons de partage en dessous
- Informations : Valide jusqu'à [date], Plage tickets [start-end]

**✋ VALIDATION REQUISE AVANT ÉTAPE 5.4**

---

**ÉTAPE 5.4 : UI - Active Sessions Screen**
- Liste des sessions actives du jour
- Statut de chaque session
- Dernière synchronisation
- Indicateur temps restant

**Livrables :**
- `lib/features/session_management/presentation/screens/active_sessions_screen.dart`
- `lib/features/session_management/presentation/widgets/session_card.dart`

**UI Specs :**
- Card par session avec gradient
- Badge "ACTIF" vert
- Code de session masqué (•••456) avec bouton révéler
- Compteur temps restant (ex: "Expire dans 5h 23min")
- Progress bar : tickets utilisés / total disponible
- Dernière sync avec timestamp
- Tap pour voir détails

**✋ VALIDATION REQUISE AVANT ÉTAPE 5.5**

---

**ÉTAPE 5.5 : UI - Session History Screen**
- Historique des sessions passées
- Filtres par date/bus
- Statistiques par session
- Détection d'anomalies

**Livrables :**
- `lib/features/session_management/presentation/screens/session_history_screen.dart`

**UI Specs :**
- Liste chronologique inversée (plus récent en haut)
- Cards grises pour sessions expirées
- Infos : Date, Bus, Tickets vendus, Recettes
- Badge rouge si anomalies détectées
- Filtres : Tous / Avec anomalies / Par bus
- Search bar pour recherche par code

**✋ VALIDATION REQUISE AVANT PHASE 6**

---

### 🔷 PHASE 6 : MONITORING DES VENTES

**ÉTAPE 6.1 : Modèles & Données Mock - Sales**
- Modèle Sale
- Modèle Ticket
- Modèle RealTimeStats
- Fichiers JSON

**Livrables :**
- `lib/features/sales_monitoring/data/models/sale_model.dart`
- `lib/features/sales_monitoring/data/models/ticket_model.dart`
- `lib/features/sales_monitoring/data/models/real_time_stats_model.dart`
- `lib/features/sales_monitoring/data/datasources/mock_data/sales.json`
- `lib/features/sales_monitoring/data/datasources/mock_data/tickets.json`

**Contenu `sales.json` :**
```json
{
  "today_sales": [
    {
      "sale_id": "sale_001",
      "session_id": "session_001",
      "bus_id": "bus_001",
      "bus_matricule": "DK-3842-RB",
      "ticket_number": 8347,
      "amount": 150,
      "timestamp": "2025-12-05T18:28:34Z",
      "payment_method": "cash",
      "location": {
        "lat": 14.7167,
        "lng": -17.4677,
        "address": "Liberté 6, Dakar"
      }
    },
    {
      "sale_id": "sale_002",
      "session_id": "session_001",
      "bus_id": "bus_001",
      "bus_matricule": "DK-3842-RB",
      "ticket_number": 8346,
      "amount": 100,
      "timestamp": "2025-12-05T18:25:12Z",
      "payment_method": "cash",
      "location": {
        "lat": 14.7145,
        "lng": -17.4656,
        "address": "Point E, Dakar"
      }
    }
  ],
  "real_time_stats": {
    "bus_001": {
      "current_passengers": 45,
      "sales_last_hour": 23,
      "revenue_last_hour": 3450,
      "average_sale_interval_seconds": 156,
      "status": "selling"
    },
    "bus_002": {
      "current_passengers": 38,
      "sales_last_hour": 19,
      "revenue_last_hour": 2850,
      "average_sale_interval_seconds": 189,
      "status": "selling"
    }
  }
}
```

**Contenu `tickets.json` :**
```json
{
  "tickets": [
    {
      "ticket_id": "ticket_8347",
      "ticket_number": 8347,
      "session_id": "session_001",
      "bus_matricule": "DK-3842-RB",
      "line": "Ligne 4 Colobane-Liberté",
      "amount": 150,
      "issued_at": "2025-12-05T18:28:34Z",
      "passenger_type": "normal",
      "qr_code": "QR_DATA_HERE",
      "is_validated": true,
      "validated_at": "2025-12-05T18:28:34Z"
    }
  ]
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 6.2**

---

**ÉTAPE 6.2 : Controller - Sales Monitoring**
- SalesController
- Chargement données temps réel
- Auto-refresh toutes les 10 secondes
- Filtrage par bus/date
- Calcul de statistiques

**Livrables :**
- `lib/features/sales_monitoring/presentation/controllers/sales_controller.dart`

**Fonctionnalités :**
- Stream de données simulant le temps réel
- Calcul de moyennes (tickets/heure, revenue/heure)
- Détection de patterns (pas de vente depuis X temps)
- Export de données

**✋ VALIDATION REQUISE AVANT ÉTAPE 6.3**

---

**ÉTAPE 6.3 : UI - Real Time Monitoring Screen**
- Vue en temps réel par bus
- Cartes avec stats live
- Liste des dernières ventes
- Animations d'arrivée de nouvelles ventes

**Livrables :**
- `lib/features/sales_monitoring/presentation/screens/real_time_monitoring_screen.dart`
- `lib/features/sales_monitoring/presentation/widgets/live_stats_card.dart`

**UI Specs :**
- Sélecteur de bus en haut
- Badge "LIVE" qui pulse (vert)
- Cards principales :
  - Recettes du jour (grand, bleu)
  - Tickets vendus (orange)
  - Dernier ticket (gris avec timestamp)
  - Ventes dernière heure (petit graphique)
- Animation : Nouvelle vente = flash orange + son (optionnel)
- Timeline des 10 dernières ventes qui défile
- Auto-refresh indicator

**✋ VALIDATION REQUISE AVANT ÉTAPE 6.4**

---

**ÉTAPE 6.4 : UI - Sales History Screen**
- Liste complète des ventes
- Filtres avancés (date, bus, montant)
- Search par numéro de ticket
- Pagination

**Livrables :**
- `lib/features/sales_monitoring/presentation/screens/sales_history_screen.dart`
- `lib/features/sales_monitoring/presentation/widgets/ticket_list_item.dart`

**UI Specs :**
- Filtres en haut : Date range picker, Bus selector
- Liste avec cards compactes
- Chaque item : N° ticket, Heure, Montant, Bus
- Icônes selon type de passager
- Tap pour voir détails du ticket
- Infinite scroll / Lazy loading
- Empty state si pas de résultats

**✋ VALIDATION REQUISE AVANT ÉTAPE 6.5**

---

**ÉTAPE 6.5 : UI - Ticket Details Screen**
- Vue détaillée d'un ticket
- QR code du ticket
- Toutes les métadonnées
- Option de partage

**Livrables :**
- `lib/features/sales_monitoring/presentation/screens/ticket_details_screen.dart`

**UI Specs :**
- Design type "ticket physique"
- QR code au centre
- Infos : N° ticket, Bus, Ligne, Date/Heure, Montant
- Localisation si disponible (mini map)
- Statut : Validé / Non validé
- Bouton "Partager le ticket"
- Design avec coins arrondis et perforations simulées

**✋ VALIDATION REQUISE AVANT ÉTAPE 6.6**

---

**ÉTAPE 6.6 : UI - Sales Timeline Widget**
- Timeline verticale des ventes
- Affichage fluide et continu
- Groupement par heure
- Indicateurs visuels

**Livrables :**
- `lib/features/sales_monitoring/presentation/widgets/sales_timeline.dart`

**UI Specs :**
- Ligne verticale centrale (bleu)
- Points pour chaque vente
- Groupes horaires : "14h00 - 15h00" (23 ventes, 3 450 FCFA)
- Animation d'apparition pour nouvelles ventes
- Scroll infini vers le haut (historique)
- Aujourd'hui marqué différemment

**✋ VALIDATION REQUISE AVANT PHASE 7**

---

### 🔷 PHASE 7 : RAPPORTS ET ANALYSES

**ÉTAPE 7.1 : Modèles & Données Mock - Reports**
- Modèle DailyReport
- Modèle WeeklyReport
- Modèle MonthlyReport
- Fichier JSON

**Livrables :**
- `lib/features/reports/data/models/daily_report_model.dart`
- `lib/features/reports/data/models/weekly_report_model.dart`
- `lib/features/reports/data/models/monthly_report_model.dart`
- `lib/features/reports/data/datasources/mock_data/reports.json`

**Contenu `reports.json` :**
```json
{
  "daily_reports": [
    {
      "report_id": "daily_2025_12_05",
      "date": "2025-12-05",
      "total_revenue": 487500,
      "total_tickets": 3250,
      "active_buses": 12,
      "average_revenue_per_bus": 40625,
      "best_performing_bus": {
        "matricule": "DK-3842-RB",
        "revenue": 52050,
        "tickets": 347
      },
      "worst_performing_bus": {
        "matricule": "DK-7821-ZX",
        "revenue": 18900,
        "tickets": 126
      },
      "peak_hours": [
        {"hour": "07:00", "tickets": 456, "revenue": 68400},
        {"hour": "17:00", "tickets": 512, "revenue": 76800}
      ],
      "anomalies_count": 2
    }
  ],
  "weekly_reports": [
    {
      "report_id": "weekly_2025_w49",
      "week_number": 49,
      "year": 2025,
      "start_date": "2025-12-01",
      "end_date": "2025-12-07",
      "total_revenue": 3113000,
      "total_tickets": 20753,
      "average_daily_revenue": 444714,
      "daily_breakdown": [
        {"day": "Lundi", "revenue": 425000, "tickets": 2833},
        {"day": "Mardi", "revenue": 468000, "tickets": 3120},
        {"day": "Mercredi", "revenue": 512000, "tickets": 3413},
        {"day": "Jeudi", "revenue": 489000, "tickets": 3260},
        {"day": "Vendredi", "revenue": 534000, "tickets": 3560},
        {"day": "Samedi", "revenue": 387000, "tickets": 2580},
        {"day": "Dimanche", "revenue": 298000, "tickets": 1987}
      ],
      "growth_percentage": 8.5
    }
  ],
  "monthly_reports": [
    {
      "report_id": "monthly_2025_11",
      "month": 11,
      "year": 2025,
      "month_name": "Novembre",
      "total_revenue": 13245000,
      "total_tickets": 88300,
      "active_buses_count": 12,
      "average_daily_revenue": 441500,
      "best_day": {
        "date": "2025-11-15",
        "revenue": 567000,
        "reason": "Vendredi avant week-end"
      },
      "worst_day": {
        "date": "2025-11-10",
        "revenue": 234000,
        "reason": "Jour férié - Tabaski"
      },
      "growth_vs_previous_month": 12.3,
      "top_3_buses": [
        {"matricule": "DK-3842-RB", "revenue": 1456000},
        {"matricule": "DK-4521-AB", "revenue": 1389000},
        {"matricule": "DK-6789-EF", "revenue": 1234000}
      ]
    }
  ]
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 7.2**

---

**ÉTAPE 7.2 : Controller - Reports**
- ReportsController
- Génération de rapports
- Calculs statistiques avancés
- Comparaisons périodiques
- Export PDF

**Livrables :**
- `lib/features/reports/presentation/controllers/reports_controller.dart`

**Fonctionnalités :**
- Génération automatique de rapports quotidiens
- Calcul de croissance (%)
- Identification des tendances
- Comparaisons bus-à-bus
- Prévisions basiques

**✋ VALIDATION REQUISE AVANT ÉTAPE 7.3**

---

**ÉTAPE 7.3 : UI - Reports Main Screen**
- Vue d'ensemble des rapports
- Onglets : Jour / Semaine / Mois
- Cards de sélection rapide
- Bouton "Générer Rapport Personnalisé"

**Livrables :**
- `lib/features/reports/presentation/screens/reports_screen.dart`
- `lib/features/reports/presentation/widgets/report_card.dart`

**UI Specs :**
- Tabs en haut : Quotidien | Hebdomadaire | Mensuel
- Cards pour chaque période avec preview
- Design : gradient bleu → vert
- Infos preview : Date, Recettes totales, Croissance %
- Icône selon type de rapport
- Tap pour voir détails complets

**✋ VALIDATION REQUISE AVANT ÉTAPE 7.4**

---

**ÉTAPE 7.4 : UI - Daily Report Screen**
- Rapport détaillé journalier
- Graphique performance horaire
- Classement des bus
- Anomalies détectées

**Livrables :**
- `lib/features/reports/presentation/screens/daily_report_screen.dart`
- `lib/features/reports/presentation/widgets/chart_widget.dart`

**UI Specs :**
- Header avec date et total
- Section "Performances" :
  - Graphique en courbe : ventes par heure
  - Peak hours highlighted en orange
- Section "Classement des Bus" :
  - Top 3 avec médailles
  - Liste complète des autres
- Section "Anomalies" si présentes
- Bouton "Exporter en PDF" en haut à droite

**✋ VALIDATION REQUISE AVANT ÉTAPE 7.5**

---

**ÉTAPE 7.5 : UI - Comparative Analysis Screen**
- Comparaison entre périodes
- Comparaison entre bus
- Graphiques multiples
- Insights automatiques

**Livrables :**
- `lib/features/reports/presentation/screens/comparative_analysis_screen.dart`

**UI Specs :**
- Sélecteurs : 2 périodes à comparer
- Cards de comparaison côte à côte
- Flèches de croissance (↑ vert, ↓ rouge)
- Graphiques superposés (lignes de couleurs différentes)
- Section "Insights" :
  - "Votre meilleur jour : Vendredi (+15%)"
  - "Bus le plus rentable : DK-3842-RB"
  - "Heures creuses : 12h-14h"
- Export disponible

**✋ VALIDATION REQUISE AVANT ÉTAPE 7.6**

---

**ÉTAPE 7.6 : UI - Export Functionality**
- Export PDF des rapports
- Export CSV des données brutes
- Partage via email/WhatsApp
- Preview avant export

**Livrables :**
- `lib/features/reports/presentation/widgets/export_button.dart`
- Intégration de package PDF

**UI Specs :**
- Bouton "Exporter" avec icône download
- Bottom sheet avec options :
  - PDF (pour impression/envoi)
  - CSV (pour analyse Excel)
  - Image (screenshot du rapport)
- Preview du PDF généré
- Options de partage natives Android

**✋ VALIDATION REQUISE AVANT PHASE 8**

---

### 🔷 PHASE 8 : DÉTECTION DE FRAUDES

**ÉTAPE 8.1 : Modèles & Données Mock - Fraud Detection**
- Modèle FraudAlert
- Modèle Anomaly
- Fichier JSON avec alertes
- Repository

**Livrables :**
- `lib/features/fraud_detection/data/models/fraud_alert_model.dart`
- `lib/features/fraud_detection/data/models/anomaly_model.dart`
- `lib/features/fraud_detection/data/datasources/mock_data/fraud_alerts.json`

**Contenu `fraud_alerts.json` :**
```json
{
  "active_alerts": [
    {
      "alert_id": "alert_001",
      "type": "missing_tickets",
      "severity": "high",
      "bus_id": "bus_001",
      "bus_matricule": "DK-3842-RB",
      "session_id": "session_001",
      "title": "Tickets manquants détectés",
      "description": "15 numéros de tickets manquants dans la séquence",
      "details": {
        "expected_range": "8000-8347",
        "missing_numbers": [8012, 8045, 8067, 8089, 8123, 8156, 8189, 8201, 8234, 8267, 8289, 8301, 8323, 8334, 8340],
        "estimated_loss": 2250
      },
      "created_at": "2025-12-05T16:20:00Z",
      "is_resolved": false,
      "priority": 1
    },
    {
      "alert_id": "alert_002",
      "type": "no_sync",
      "severity": "medium",
      "bus_id": "bus_002",
      "bus_matricule": "DK-4521-AB",
      "session_id": "session_002",
      "title": "Aucune synchronisation récente",
      "description": "Le receveur n'a pas synchronisé depuis 3 heures",
      "details": {
        "last_sync": "2025-12-05T15:45:00Z",
        "hours_since_sync": 3.25,
        "expected_tickets": 150,
        "synced_tickets": 0
      },
      "created_at": "2025-12-05T18:50:00Z",
      "is_resolved": false,
      "priority": 2
    },
    {
      "alert_id": "alert_003",
      "type": "data_cleared",
      "severity": "critical",
      "bus_id": "bus_003",
      "bus_matricule": "DK-2134-CD",
      "session_id": "session_003",
      "title": "Données effacées - Nouvelle connexion",
      "description": "Le receveur a demandé un nouveau code après effacement",
      "details": {
        "previous_code": "892341",
        "new_code_requested_at": "2025-12-05T14:30:00Z",
        "tickets_before_clear": 87,
        "estimated_loss": 13050,
        "receiver_name": "Cheikh Ndiaye"
      },
      "created_at": "2025-12-05T14:30:00Z",
      "is_resolved": false,
      "priority": 1
    }
  ],
  "resolved_alerts": [
    {
      "alert_id": "alert_h_001",
      "type": "unusual_pattern",
      "severity": "low",
      "bus_id": "bus_001",
      "bus_matricule": "DK-3842-RB",
      "title": "Pattern de vente inhabituel",
      "description": "Pic de ventes inhabituel détecté à 22h",
      "created_at": "2025-12-04T22:15:00Z",
      "resolved_at": "2025-12-04T23:00:00Z",
      "resolution_note": "Événement spécial au stade - Normal",
      "is_resolved": true
    }
  ],
  "fraud_statistics": {
    "total_alerts_this_month": 23,
    "critical_alerts": 5,
    "high_alerts": 8,
    "medium_alerts": 7,
    "low_alerts": 3,
    "resolved_rate": 82,
    "estimated_losses_prevented": 156000,
    "most_common_type": "missing_tickets"
  }
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 8.2**

---

**ÉTAPE 8.2 : Controller - Fraud Detection**
- FraudController
- Détection d'anomalies
- Calcul de sévérité
- Notifications push
- Marquage résolution

**Livrables :**
- `lib/features/fraud_detection/presentation/controllers/fraud_controller.dart`

**Logique de détection :**
- Missing tickets : Comparaison séquence attendue vs reçue
- No sync : Timeout de 2h sans sync
- Data cleared : Nouvelle demande de code
- Unusual pattern : Déviation statistique (ML basique)
- Calcul de perte estimée automatique

**✋ VALIDATION REQUISE AVANT ÉTAPE 8.3**

---

**ÉTAPE 8.3 : UI - Fraud Alerts Screen**
- Liste des alertes actives
- Filtres par sévérité
- Tri par priorité
- Compteurs rapides

**Livrables :**
- `lib/features/fraud_detection/presentation/screens/fraud_alerts_screen.dart`
- `lib/features/fraud_detection/presentation/widgets/alert_card.dart`
- `lib/features/fraud_detection/presentation/widgets/severity_badge.dart`

**UI Specs :**
- Header avec statistiques :
  - Total alertes actives (badge rouge)
  - Pertes estimées du mois
- Filtres : Toutes | Critiques | Résolues
- Cards par alerte :
  - Badge de sévérité (rouge/orange/jaune)
  - Titre en gras
  - Bus concerné
  - Description courte
  - Timestamp relatif ("Il y a 2h")
  - Icône selon type d'alerte
- Animation : Pulse pour nouvelles alertes
- Swipe pour marquer comme résolu

**✋ VALIDATION REQUISE AVANT ÉTAPE 8.4**

---

**ÉTAPE 8.4 : UI - Alert Details Screen**
- Vue complète d'une alerte
- Détails techniques
- Actions possibles
- Historique de l'alerte

**Livrables :**
- `lib/features/fraud_detection/presentation/screens/alert_details_screen.dart`

**UI Specs :**
- Header avec badge sévérité large
- Section "Détails" :
  - Bus, Session, Receveur
  - Date/Heure de détection
  - Type d'anomalie
- Section "Informations Techniques" :
  - Tickets manquants (liste)
  - Plage attendue vs reçue
  - Perte estimée en GROS
- Section "Actions" :
  - Bouton "Contacter le Receveur" (appel/WhatsApp)
  - Bouton "Voir les ventes du bus"
  - Bouton "Marquer comme résolu"
- Si résolu : Note de résolution affichée
- Timeline des événements liés

**✋ VALIDATION REQUISE AVANT PHASE 9**

---

### 🔷 PHASE 9 : PROFIL UTILISATEUR

**ÉTAPE 9.1 : Modèles & Données Mock - Profile**
- Modèle Profile complet
- Préférences utilisateur
- Fichier JSON

**Livrables :**
- `lib/features/profile/data/models/profile_model.dart`
- `lib/features/profile/data/datasources/mock_data/profile.json`

**Contenu `profile.json` :**
```json
{
  "user": {
    "id": "user_001",
    "name": "Abdoulaye Diop",
    "phone": "+221771234567",
    "email": "abdoulaye.diop@example.com",
    "photo_url": null,
    "created_at": "2025-01-15T10:00:00Z",
    "subscription": {
      "status": "active",
      "plan": "pro",
      "price_per_bus": 2000,
      "total_buses": 12,
      "monthly_cost": 24000,
      "next_billing_date": "2026-01-15",
      "payment_method": "mobile_money"
    },
    "statistics": {
      "total_buses": 12,
      "total_lifetime_revenue": 156780000,
      "total_lifetime_tickets": 1045200,
      "days_active": 324,
      "fraud_alerts_resolved": 89,
      "average_daily_revenue": 483889
    }
  },
  "preferences": {
    "language": "fr",
    "currency": "FCFA",
    "notifications": {
      "push_enabled": true,
      "email_enabled": false,
      "sms_enabled": true,
      "fraud_alerts": true,
      "daily_reports": true,
      "low_sync_warnings": true
    },
    "dashboard_layout": "default",
    "auto_refresh_interval": 10
  }
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 9.2**

---

**ÉTAPE 9.2 : Controller - Profile**
- ProfileController
- Chargement profil
- Mise à jour informations
- Gestion préférences
- Déconnexion

**Livrables :**
- `lib/features/profile/presentation/controllers/profile_controller.dart`

**Fonctionnalités :**
- Load user data
- Update profile (name, email, photo)
- Update preferences (notifications, language)
- Change password
- Logout avec confirmation

**✋ VALIDATION REQUISE AVANT ÉTAPE 9.3**

---

**ÉTAPE 9.3 : UI - Profile Screen**
- Vue principale du profil
- Informations utilisateur
- Statistiques personnelles
- Menu de navigation

**Livrables :**
- `lib/features/profile/presentation/screens/profile_screen.dart`
- `lib/features/profile/presentation/widgets/profile_header.dart`

**UI Specs :**
- Header avec gradient bleu :
  - Photo de profil (ou initiales)
  - Nom en grand
  - Téléphone en dessous
  - Bouton "Éditer" en haut à droite
- Section "Statistiques" :
  - Cards : Buses, Recettes totales, Jours actifs
- Section "Abonnement" :
  - Plan actuel
  - Coût mensuel
  - Prochaine facture
  - Bouton "Gérer l'abonnement"
- Menu avec icônes :
  - Éditer le profil
  - Paramètres
  - Notifications
  - Aide & Support
  - À propos
  - Déconnexion (rouge)

**✋ VALIDATION REQUISE AVANT ÉTAPE 9.4**

---

**ÉTAPE 9.4 : UI - Edit Profile Screen**
- Modification des informations
- Upload photo
- Validation des champs
- Sauvegarde

**Livrables :**
- `lib/features/profile/presentation/screens/edit_profile_screen.dart`

**UI Specs :**
- Photo de profil éditable (tap pour changer)
- Champs :
  - Nom complet
  - Email
  - Téléphone (lecture seule)
- Bouton "Sauvegarder" en bas
- Validation en temps réel
- Success snackbar après save

**✋ VALIDATION REQUISE AVANT ÉTAPE 9.5**

---

**ÉTAPE 9.5 : UI - Settings Screen**
- Paramètres de l'application
- Notifications
- Langue
- Préférences affichage

**Livrables :**
- `lib/features/profile/presentation/screens/settings_screen.dart`

**UI Specs :**
- Sections avec dividers :
  
**1. Notifications**
- Toggle : Notifications push
- Toggle : Alertes de fraude
- Toggle : Rapports quotidiens
- Toggle : Avertissements de sync

**2. Préférences**
- Dropdown : Langue (Français / Wolof)
- Dropdown : Intervalle de rafraîchissement (5s / 10s / 30s)
- Toggle : Mode sombre (pour future version)

**3. Sécurité**
- Bouton : Changer le mot de passe
- Toggle : Authentification biométrique
- Bouton : Historique des connexions

**4. À propos**
- Version de l'app
- Conditions d'utilisation
- Politique de confidentialité
- Nous contacter

**✋ VALIDATION REQUISE AVANT PHASE 10**

---

### 🔷 PHASE 10 : INTÉGRATION & POLISH

**ÉTAPE 10.1 : Navigation Globale**
- Bottom navigation bar fonctionnelle
- Routes GetX complètes
- Deep linking
- Back button handling

**Livrables :**
- Configuration complète des routes dans `lib/app.dart`
- Bottom nav bar intégré dans tous les écrans principaux

**Routes à configurer :**
```dart
- '/splash' → SplashScreen
- '/login' → LoginScreen
- '/register' → RegisterScreen
- '/otp' → OTPVerificationScreen
- '/dashboard' → DashboardScreen (default)
- '/buses' → BusListScreen
- '/buses/add' → AddBusScreen
- '/buses/:id' → BusDetailsScreen
- '/buses/:id/edit' → EditBusScreen
- '/sessions' → GenerateCodeScreen
- '/sessions/active' → ActiveSessionsScreen
- '/sessions/history' → SessionHistoryScreen
- '/sales' → RealTimeMonitoringScreen
- '/sales/history' → SalesHistoryScreen
- '/sales/ticket/:id' → TicketDetailsScreen
- '/reports' → ReportsScreen
- '/reports/daily' → DailyReportScreen
- '/reports/compare' → ComparativeAnalysisScreen
- '/fraud' → FraudAlertsScreen
- '/fraud/:id' → AlertDetailsScreen
- '/profile' → ProfileScreen
- '/profile/edit' → EditProfileScreen
- '/profile/settings' → SettingsScreen
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 10.2**

---

**ÉTAPE 10.2 : État de Chargement Unifié**
- Shimmer loading pour toutes les listes
- Skeleton screens pour les détails
- Loading indicators cohérents
- Empty states personnalisés

**Livrables :**
- `lib/shared/widgets/shimmer_loading.dart`
- `lib/shared/widgets/skeleton_card.dart`
- Intégration dans tous les écrans à données

**UI Specs :**
- Shimmer gris clair qui pulse
- Skeleton respectant la structure des cards réelles
- Loading indicator : circular bleu #0854A2
- Empty states avec illustrations et messages encourageants

**✋ VALIDATION REQUISE AVANT ÉTAPE 10.3**

---

**ÉTAPE 10.3 : Gestion d'Erreurs Unifiée**
- Error widgets personnalisés
- Messages d'erreur contextuels
- Retry mechanisms
- Offline mode indicators

**Livrables :**
- `lib/shared/widgets/error_view.dart`
- `lib/shared/widgets/network_error_widget.dart`
- `lib/shared/widgets/offline_banner.dart`

**UI Specs :**
- Illustrations d'erreur sympas
- Messages clairs et en français
- Bouton "Réessayer" toujours visible
- Bannière orange pour mode hors ligne
- Log des erreurs en mode debug

**✋ VALIDATION REQUISE AVANT ÉTAPE 10.4**

---

**ÉTAPE 10.4 : Animations et Transitions**
- Hero animations pour navigation
- Fade transitions
- Slide animations
- Micro-interactions

**Livrables :**
- Configuration des transitions GetX
- Animations sur boutons
- Feedback tactile

**Animations à implémenter :**
- Hero : Image bus list → details
- Fade : Changement d'onglets
- Slide : Bottom sheets
- Scale : Boutons au tap
- Pulse : Badges "LIVE"
- Confetti : Génération de code session

**✋ VALIDATION REQUISE AVANT ÉTAPE 10.5**

---

**ÉTAPE 10.5 : Notifications Push (Mock)**
- Service de notifications local
- Affichage des notifications
- Actions depuis notifications
- Badge counter

**Livrables :**
- `lib/shared/services/notification_service.dart`
- Intégration avec controllers

**Types de notifications :**
- Nouvelle vente (temps réel simulé)
- Alerte de fraude (critique)
- Rapport quotidien disponible
- Session expirée
- Absence de sync (warning)

**✋ VALIDATION REQUISE AVANT ÉTAPE 10.6**

---

**ÉTAPE 10.6 : Optimisations Performances**
- Lazy loading des listes
- Image caching
- Debouncing des recherches
- Optimisation des rebuilds

**Livrables :**
- Pagination sur toutes les listes longues
- CachedNetworkImage partout
- Debounce sur search fields (300ms)
- Optimisation GetX avec Obx précis

**✋ VALIDATION REQUISE AVANT ÉTAPE 10.7**

---

**ÉTAPE 10.7 : Accessibilité**
- Tailles de texte adaptatives
- Contraste suffisant
- Semantic labels
- Support lecteurs d'écran

**Livrables :**
- Vérification contraste (WCAG AA minimum)
- Semantics widgets sur éléments interactifs
- Support text scaling

**✋ VALIDATION REQUISE AVANT ÉTAPE 10.8**

---

**ÉTAPE 10.8 : Tests & Debug Tools**
- Mock data switcher
- Debug mode indicators
- Test de toutes les fonctionnalités
- Fix des bugs identifiés

**Livrables :**
- Toggle "Mode Mock" dans Settings
- Indicateur visible en mode debug
- Liste de bugs corrigés

**✋ VALIDATION REQUISE AVANT ÉTAPE 10.9**

---

**ÉTAPE 10.9 : Documentation du Code**
- Commentaires sur fonctions complexes
- README du projet
- Guide d'architecture
- Instructions de build

**Livrables :**
- `README.md` complet
- `ARCHITECTURE.md`
- Commentaires Dart doc sur classes principales

**✋ VALIDATION REQUISE AVANT ÉTAPE 10.10**

---

**ÉTAPE 10.10 : Préparation API Réelle**
- Configuration des endpoints
- Remplacement des mocks par API
- Gestion des tokens
- Retry policy sur erreurs réseau

**Livrables :**
- `lib/shared/constants/api_endpoints.dart` configuré
- `lib/shared/services/api_service.dart` complet avec interceptors
- Environment variables pour base URL
- Switch facile Mock ↔ API

**Structure API Endpoints :**
```dart
class ApiEndpoints {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.sunuticket.sn',
  );
  
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  
  // Dashboard
  static const String dashboardStats = '/dashboard/stats';
  
  // Buses
  static const String buses = '/buses';
  static String busDetails(String id) => '/buses/$id';
  
  // Sessions
  static const String generateSession = '/sessions/generate';
  static const String activeSessions = '/sessions/active';
  
  // Sales
  static const String realtimeSales = '/sales/realtime';
  static const String salesHistory = '/sales/history';
  
  // Reports
  static const String dailyReport = '/reports/daily';
  static const String weeklyReport = '/reports/weekly';
  
  // Fraud
  static const String fraudAlerts = '/fraud/alerts';
  
  // Profile
  static const String profile = '/profile';
}
```

**✋ VALIDATION REQUISE AVANT LIVRAISON FINALE**

---

## 🎨 GUIDES DE STYLE POUR TOUS LES ÉCRANS

### Constantes à Utiliser Partout

**Fichier : `lib/shared/constants/app_colors.dart`**
```dart
import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales
  static const Color primary = Color(0xFF0854A2);
  static const Color secondary = Color(0xFFFF8C00);
  
  // Dégradés
  static const Color gradientStart = Color(0xFF4DD0E1);
  static const Color gradientEnd = Color(0xFFC8E6C9);
  
  // Backgrounds
  static const Color background = Color(0xFFE0F7FA);
  static const Color cardBackground = Colors.white;
  
  // Textes
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textOnPrimary = Colors.white;
  
  // États
  static const Color success = Color(0xFF27AE60);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFFF8C00);
  static const Color info = Color(0xFF3498DB);
  
  // Status
  static const Color statusActive = Color(0xFF27AE60);
  static const Color statusInactive = Color(0xFF95A5A6);
  
  // Severity badges
  static const Color severityCritical = Color(0xFFE74C3C);
  static const Color severityHigh = Color(0xFFFF8C00);
  static const Color severityMedium = Color(0xFFF39C12);
  static const Color severityLow = Color(0xFF3498DB);
  
  // Gradients
  static LinearGradient primaryGradient = const LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient cardGradient = LinearGradient(
    colors: [
      Colors.white,
      gradientStart.withOpacity(0.1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
```

**Fichier : `lib/shared/constants/app_text_styles.dart`**
```dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headers
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
  
  // Special
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle code = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    letterSpacing: 8,
    fontFamily: 'monospace',
  );
}
```

**Fichier : `lib/shared/constants/app_dimensions.dart`**
```dart
class AppDimensions {
  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  
  // Margins
  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 16.0;
  static const double marginL = 24.0;
  static const double marginXL = 32.0;
  
  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusRound = 999.0;
  
  // Elevations
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  
  // Icon Sizes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  
  // Card Sizes
  static const double cardHeight = 120.0;
  static const double statsCardHeight = 100.0;
}
```

---

## 📱 EXEMPLES DE STRUCTURE D'ÉCRAN

### Template d'Écran Standard

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/constants/app_dimensions.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../controllers/example_controller.dart';

class ExampleScreen extends GetView<ExampleController> {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Titre de l\'Écran',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refresh,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingIndicator();
        }
        
        if (controller.hasError.value) {
          return CustomErrorWidget(
            message: controller.errorMessage.value,
            onRetry: controller.loadData,
          );
        }
        
        return RefreshIndicator(
          onRefresh: controller.refresh,
          child: ListView(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            children: [
              // Votre contenu ici
            ],
          ),
        );
      }),
    );
  }
}
```

---

## 🚀 COMMANDES DE DÉMARRAGE

**Pour lancer le projet :**
```bash
flutter pub get
flutter run
```

**Pour build en mode release :**
```bash
flutter build apk --release
```

**Pour tester avec mock data :**
- Mode mock activé par défaut
- Toggle dans Settings pour passer en mode API

---

## ✅ CHECKLIST FINALE AVANT LIVRAISON

### Fonctionnalités
- [ ] Toutes les features implémentées
- [ ] Navigation fluide entre écrans
- [ ] Mock data fonctionnel partout
- [ ] États de chargement visibles
- [ ] Gestion d'erreurs complète

### UI/UX
- [ ] Charte graphique respectée (couleurs, fonts)
- [ ] Animations présentes et smooth
- [ ] Responsive sur différentes tailles
- [ ] Dark mode compatible (si implémenté)
- [ ] Accessibilité de base

### Performance
- [ ] Pas de lag lors du scroll
- [ ] Images chargées efficacement
- [ ] Pas de memory leaks
- [ ] Build size raisonnable (< 50MB)

### Qualité du Code
- [ ] Structure des dossiers propre
- [ ] Noms de variables clairs
- [ ] Pas de code dupliqué majeur
- [ ] Commentaires sur logique complexe

### Prêt pour l'API
- [ ] Endpoints définis
- [ ] Switch Mock ↔ API facile
- [ ] Gestion des tokens préparée
- [ ] Error handling réseau

---

## 📞 SUPPORT PENDANT LE DÉVELOPPEMENT

**Format de Communication :**

Pour chaque étape, je fournirai :
1. ✅ Le code complet de l'étape
2. 📋 Les fichiers concernés
3. 🎨 Les captures d'écran UI (si applicable)
4. ⚠️ Les points d'attention
5. 🧪 Comment tester l'étape

Tu devras me répondre avec :
1. ✅ "VALIDÉ" ou ❌ "À CORRIGER"
2. 🐛 Liste des bugs trouvés
3. 💭 Tes commentaires/suggestions
4. ➡️ "PRÊT POUR ÉTAPE SUIVANTE"

---

## 🎯 RÉCAPITULATIF DU NOMBRE D'ÉTAPES

| Phase | Nombre d'Étapes | Durée Estimée |
|-------|-----------------|---------------|
| Phase 1 : Setup & Base | 3 étapes | 2-3 jours |
| Phase 2 : Auth | 6 étapes | 3-4 jours |
| Phase 3 : Dashboard | 7 étapes | 4-5 jours |
| Phase 4 : Bus Management | 6 étapes | 3-4 jours |
| Phase 5 : Session Management | 5 étapes | 3-4 jours |
| Phase 6 : Sales Monitoring | 6 étapes | 4-5 jours |
| Phase 7 : Reports | 6 étapes | 3-4 jours |
| Phase 8 : Fraud Detection | 4 étapes | 2-3 jours |
| Phase 9 : Profile | 5 étapes | 2-3 jours |
| Phase 10 : Polish & Integration | 10 étapes | 5-7 jours |
| **TOTAL** | **58 étapes** | **30-40 jours** |

---

## 🚀 PRÊT À COMMENCER ?

**Dis-moi :**
1. As-tu des questions sur l'architecture ?
2. Veux-tu modifier quelque chose avant de commencer ?
3. Es-tu prêt pour l'ÉTAPE 1.1 : Setup Projet & Configuration Initiale ?

**Une fois que tu confirmes, je commence immédiatement avec le code complet de l'étape 1.1 !** 🎯 VALIDATION REQUISE AVANT ÉTAPE 1.2**

---

**ÉTAPE 1.2 : Widgets Partagés de Base**
- CustomButton
- CustomCard
- CustomAppBar
- LoadingIndicator
- ErrorWidget
- EmptyStateWidget
- GradientContainer

**Livrables :**
- Tous les widgets dans `lib/shared/widgets/`

**✋ VALIDATION REQUISE AVANT ÉTAPE 1.3**

---

**ÉTAPE 1.3 : Services de Base**
- MockApiService (simulation API)
- StorageService (GetStorage)
- ApiService (Dio) avec configuration
- Helpers et utilitaires

**Livrables :**
- `lib/shared/services/mock_api_service.dart`
- `lib/shared/services/api_service.dart`
- `lib/shared/services/storage_service.dart`
- `lib/shared/utils/formatters.dart`
- `lib/shared/utils/validators.dart`

**✋ VALIDATION REQUISE AVANT PHASE 2**

---

### 🔷 PHASE 2 : AUTHENTIFICATION

**ÉTAPE 2.1 : Modèles & Données Mock - Auth**
- Création des modèles (User, AuthResponse)
- Fichiers JSON mock
- Repository avec mock data

**Livrables :**
- `lib/features/auth/data/models/`
- `lib/features/auth/data/datasources/mock_data/users.json`
- `lib/features/auth/data/repositories/auth_repository.dart`

**Contenu `users.json` :**
```json
{
  "users": [
    {
      "id": "user_001",
      "phone": "+221771234567",
      "name": "Abdoulaye Diop",
      "password": "password123",
      "created_at": "2025-01-15T10:00:00Z",
      "is_verified": true
    },
    {
      "id": "user_002",
      "phone": "+221771234568",
      "name": "Fatou Sall",
      "password": "password123",
      "created_at": "2025-02-10T14:30:00Z",
      "is_verified": true
    }
  ],
  "otp_codes": {
    "+221771234567": "123456",
    "+221771234568": "654321"
  }
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.2**

---

**ÉTAPE 2.2 : Controller - Auth**
- AuthController avec GetX
- Gestion états (loading, success, error)
- Logique de connexion/inscription
- Validation OTP

**Livrables :**
- `lib/features/auth/presentation/controllers/auth_controller.dart`

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.3**

---

**ÉTAPE 2.3 : UI - Splash Screen**
- Écran de démarrage avec logo
- Animation de chargement
- Vérification de session
- Navigation automatique

**Livrables :**
- `lib/features/auth/presentation/screens/splash_screen.dart`

**UI Specs :**
- Background : Dégradé cyan → vert menthe
- Logo centré avec animation fade-in
- Texte "SUNU TICKET PRO" sous le logo
- Loader circulaire en bas

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.4**

---

**ÉTAPE 2.4 : UI - Login Screen**
- Formulaire de connexion
- Champ numéro de téléphone
- Champ mot de passe
- Bouton connexion
- Lien vers inscription

**Livrables :**
- `lib/features/auth/presentation/screens/login_screen.dart`
- `lib/features/auth/presentation/widgets/custom_text_field.dart`
- `lib/features/auth/presentation/widgets/auth_button.dart`

**UI Specs :**
- Background : Bleu pâle #E0F7FA
- Card blanche avec ombre
- Logo en haut
- Champs avec icônes
- Bouton primaire bleu #0854A2
- Validation en temps réel

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.5**

---

**ÉTAPE 2.5 : UI - Register Screen**
- Formulaire d'inscription
- Nom complet
- Numéro téléphone
- Mot de passe
- Confirmation mot de passe
- Validation

**Livrables :**
- `lib/features/auth/presentation/screens/register_screen.dart`

**✋ VALIDATION REQUISE AVANT ÉTAPE 2.6**

---

**ÉTAPE 2.6 : UI - OTP Verification Screen**
- Écran de saisie OTP
- 6 cases pour le code
- Timer de 60 secondes
- Bouton renvoyer code
- Validation automatique

**Livrables :**
- `lib/features/auth/presentation/screens/otp_verification_screen.dart`

**UI Specs :**
- 6 cases carrées pour chaque chiffre
- Focus automatique sur case suivante
- Couleur case active : bleu #0854A2
- Timer visible : "Renvoyer le code dans 0:45"

**✋ VALIDATION REQUISE AVANT PHASE 3**

---

### 🔷 PHASE 3 : DASHBOARD PRINCIPAL

**ÉTAPE 3.1 : Modèles & Données Mock - Dashboard**
- Modèles stats dashboard
- Fichier JSON avec données réalistes
- Repository

**Livrables :**
- `lib/features/dashboard/data/models/`
- `lib/features/dashboard/data/datasources/mock_data/dashboard_stats.json`

**Contenu `dashboard_stats.json` :**
```json
{
  "today_stats": {
    "date": "2025-12-05",
    "total_revenue": 487500,
    "total_tickets": 3250,
    "active_buses": 12,
    "alerts_count": 2
  },
  "buses_summary": [
    {
      "bus_id": "bus_001",
      "matricule": "DK-3842-RB",
      "line": "Ligne 4 Colobane-Liberté",
      "status": "active",
      "today_revenue": 52050,
      "today_tickets": 347,
      "last_sync": "2025-12-05T18:30:00Z",
      "current_ticket_number": 8347,
      "driver_name": "Moussa Ba"
    },
    {
      "bus_id": "bus_002",
      "matricule": "DK-4521-AB",
      "line": "Ligne 4 Colobane-Liberté",
      "status": "active",
      "today_revenue": 45300,
      "today_tickets": 302,
      "last_sync": "2025-12-05T18:45:00Z",
      "current_ticket_number": 5623,
      "driver_name": "Ibrahima Ndiaye"
    },
    {
      "bus_id": "bus_003",
      "matricule": "DK-2134-CD",
      "line": "Ligne 5 Pikine-Liberté 6",
      "status": "inactive",
      "today_revenue": 0,
      "today_tickets": 0,
      "last_sync": null,
      "current_ticket_number": null,
      "driver_name": "Amadou Diallo"
    }
  ],
  "weekly_chart_data": [
    {"day": "Lun", "revenue": 425000},
    {"day": "Mar", "revenue": 468000},
    {"day": "Mer", "revenue": 512000},
    {"day": "Jeu", "revenue": 489000},
    {"day": "Ven", "revenue": 534000},
    {"day": "Sam", "revenue": 387000},
    {"day": "Dim", "revenue": 298000}
  ],
  "recent_alerts": [
    {
      "alert_id": "alert_001",
      "type": "missing_tickets",
      "severity": "high",
      "bus_matricule": "DK-3842-RB",
      "message": "15 numéros de tickets manquants détectés",
      "timestamp": "2025-12-05T16:20:00Z",
      "is_resolved": false
    },
    {
      "alert_id": "alert_002",
      "type": "no_sync",
      "severity": "medium",
      "bus_matricule": "DK-4521-AB",
      "message": "Aucune synchronisation depuis 3 heures",
      "timestamp": "2025-12-05T15:45:00Z",
      "is_resolved": false
    }
  ]
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.2**

---

**ÉTAPE 3.2 : Controller - Dashboard**
- DashboardController
- Chargement stats
- Rafraîchissement automatique
- Gestion alertes

**Livrables :**
- `lib/features/dashboard/presentation/controllers/dashboard_controller.dart`

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.3**

---

**ÉTAPE 3.3 : UI - Dashboard Screen (Structure)**
- AppBar personnalisée
- Sections principales
- Bottom navigation bar
- Pull to refresh

**Livrables :**
- `lib/features/dashboard/presentation/screens/dashboard_screen.dart`
- `lib/shared/widgets/bottom_nav_bar.dart`

**UI Specs :**
- AppBar : Bleu #0854A2 avec logo et profil
- Background : Bleu pâle #E0F7FA
- Bottom Nav : 5 items (Dashboard, Bus, Session, Rapports, Profil)

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.4**

---

**ÉTAPE 3.4 : UI - Stats Cards Dashboard**
- Card recettes du jour
- Card tickets vendus
- Card bus actifs
- Card alertes
- Design avec icônes et animations

**Livrables :**
- `lib/features/dashboard/presentation/widgets/stats_card.dart`

**UI Specs :**
- Cards blanches avec ombre
- Gradient subtle en background
- Icônes colorées (orange pour recettes, bleu pour tickets)
- Animations au chargement (fade + scale)

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.5**

---

**ÉTAPE 3.5 : UI - Revenue Chart Widget**
- Graphique en barres (recettes 7 jours)
- Utilisation fl_chart
- Interactions tactiles
- Légendes

**Livrables :**
- `lib/features/dashboard/presentation/widgets/revenue_chart.dart`

**UI Specs :**
- Barres bleues avec gradient
- Axe X : Jours de la semaine
- Axe Y : Montants en FCFA
- Touch feedback avec tooltip

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.6**

---

**ÉTAPE 3.6 : UI - Bus List Items Dashboard**
- Liste des bus avec statut
- Info recettes en temps réel
- Dernière synchronisation
- Badge statut (actif/inactif)

**Livrables :**
- `lib/features/dashboard/presentation/widgets/bus_list_item.dart`

**UI Specs :**
- Card horizontale avec matricule en gros
- Badge vert (actif) ou gris (inactif)
- Icône bus
- Détails : recettes + tickets + heure sync
- Tap pour voir détails

**✋ VALIDATION REQUISE AVANT ÉTAPE 3.7**

---

**ÉTAPE 3.7 : UI - Alert Banner Dashboard**
- Bannière d'alertes en haut
- Défilement si plusieurs alertes
- Couleurs selon sévérité
- Action rapide

**Livrables :**
- `lib/features/dashboard/presentation/widgets/alert_banner.dart`

**UI Specs :**
- Rouge (#E74C3C) pour alertes critiques
- Orange (#FF8C00) pour alertes moyennes
- Icône d'alerte
- Message court
- Tap pour voir détails

**✋ VALIDATION REQUISE AVANT PHASE 4**

---

### 🔷 PHASE 4 : GESTION DES BUS

**ÉTAPE 4.1 : Modèles & Données Mock - Bus**
- Modèle Bus complet
- Fichier JSON avec liste bus
- Repository

**Livrables :**
- `lib/features/bus_management/data/models/bus_model.dart`
- `lib/features/bus_management/data/datasources/mock_data/buses.json`

**Contenu `buses.json` :**
```json
{
  "buses": [
    {
      "id": "bus_001",
      "matricule": "DK-3842-RB",
      "line": "Ligne 4 Colobane-Liberté",
      "driver_name": "Moussa Ba",
      "driver_phone": "+221771234567",
      "status": "active",
      "created_at": "2025-01-20T10:00:00Z",
      "owner_id": "user_001",
      "total_lifetime_revenue": 12450000,
      "total_lifetime_tickets": 83000
    },
    {
      "id": "bus_002",
      "matricule": "DK-4521-AB",
      "line": "Ligne 4 Colobane-Liberté",
      "driver_name": "Ibrahima Ndiaye",
      "driver_phone": "+221771234568",
      "status": "active",
      "created_at": "2025-02-15T14:30:00Z",
      "owner_id": "user_001",
      "total_lifetime_revenue": 8920000,
      "total_lifetime_tickets": 59467
    },
    {
      "id": "bus_003",
      "matricule": "DK-2134-CD",
      "line": "Ligne 5 Pikine-Liberté 6",
      "driver_name": "Amadou Diallo",
      "driver_phone": "+221771234569",
      "status": "inactive",
      "created_at": "2025-03-10T09:00:00Z",
      "owner_id": "user_001",
      "total_lifetime_revenue": 5670000,
      "total_lifetime_tickets": 37800
    }
  ]
}
```

**✋ VALIDATION REQUISE AVANT ÉTAPE 4.2**

---

**ÉTAPE 4.2 : Controller - Bus Management**
- BusController
- CRUD complet (Create, Read, Update, Delete)
- Validation des données
- Gestion états

**Livrables :**
- `lib/features/bus_management/presentation/controllers/bus_controller.dart`

**✋ VALIDATION REQUISE AVANT ÉTAPE 4.3**

---

**ÉTAPE 4.3 : UI - Bus List Screen**
- Liste complète des bus
- Recherche et filtres
- Bouton ajouter bus
- Cards avec infos essentielles

**Livrables :**
- `lib/features/bus_management/presentation/screens/bus_list_screen.dart`
- `lib/features/bus_management/presentation/widgets/bus_card.dart`

**UI Specs :**
- AppBar avec recherche
- FloatingActionButton orange pour ajouter
- Cards avec photo bus, matricule, ligne
- Badge statut visible
- Swipe actions (edit/delete)
