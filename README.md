# 🚌 SUNU TICKET
## Solution de Billetterie Électronique pour le Transport Urbain

**Présentation Officielle - Décembre 2025**

---

## 📋 RÉSUMÉ EXÉCUTIF

**Sunu Ticket** est une solution de billetterie électronique conçue pour les propriétaires de bus urbains au Sénégal (GIE, Tata, AFTU). 

**Le problème :** Les systèmes actuels coûtent ~36 000 FCFA/mois en location de matériel, avec peu de transparence et des risques de fraude élevés.

**Notre solution :** Un abonnement logiciel à 2 000 FCFA/mois utilisant les téléphones existants des propriétaires, avec un système anti-fraude révolutionnaire.

**Le résultat :** 94% d'économie pour les propriétaires + transparence totale + contrôle en temps réel.

---

## 🎯 LE PROBLÈME QU'ON RÉSOUT

### Les Douleurs des Propriétaires de Bus

1. **Coût Élevé de Location**
   - 9 000 FCFA/semaine pour le matériel de billetterie
   - Paiement obligatoire même si le bus ne roule pas
   - ~432 000 FCFA/an par bus

2. **Manque de Transparence**
   - Impossible de savoir en temps réel combien de passagers ont été transportés
   - Dépendance totale aux déclarations du receveur
   - Découverte des fraudes souvent trop tard

3. **Fraude Endémique**
   - Receveurs qui vendent sans émettre de ticket
   - Destruction de preuves (tickets non déclarés)
   - Pertes estimées à 20-30% des recettes réelles

---

## 💡 NOTRE SOLUTION

### L'Offre Sunu Ticket

| Élément | Concurrent Actuel | Sunu Ticket | Votre Gain |
|---------|-------------------|-------------|------------|
| **Coût Mensuel** | 36 000 FCFA | 2 000 FCFA | **34 000 FCFA d'économie** |
| **Matériel** | Location (doit être rendu) | Votre propre téléphone | Vous êtes propriétaire |
| **Transparence** | Rapport en fin de journée | Temps réel via app | Contrôle immédiat |
| **Anti-fraude** | Basique | Système à double sécurité | Protection maximale |
| **Flexibilité** | Payé même si bus arrêté | Payé seulement si utilisé | Zéro stress |

### Le Pitch en Une Phrase

> **"Payez 2 000 FCFA par mois au lieu de 36 000 FCFA, utilisez votre propre téléphone, et surveillez vos recettes en temps réel depuis votre canapé."**

---

## 🏗️ COMMENT ÇA MARCHE

Le système Sunu Ticket repose sur **deux applications mobiles** qui travaillent ensemble avec un serveur central sécurisé.

### Application 1️⃣ : SUNU TICKET Pro (Pour le Propriétaire)

**C'est votre centre de contrôle personnel.**

#### Installation et Configuration Initiale

1. **Téléchargement** : Vous installez **Sunu Ticket Pro** sur votre smartphone personnel
2. **Inscription Sécurisée** :
   - Vous entrez votre numéro de téléphone (qui devient votre identifiant)
   - Vous recevez un code SMS (OTP) pour vérifier
   - Vous créez votre mot de passe maître
   - Système d'authentification à deux facteurs (2FA) automatique

3. **Enregistrement de Vos Bus** :
   - Pour chaque bus, vous entrez :
     - Le matricule du véhicule
     - La ligne (ex: Ligne 4 Colobane-Liberté 6)
     - Le nom du chauffeur (optionnel)

#### Utilisation Quotidienne

**Chaque Matin :**

1. Vous ouvrez **Sunu Ticket Pro**
2. Vous sélectionnez le bus qui va travailler aujourd'hui
3. Vous appuyez sur **"Générer Code de Session"**
4. L'application affiche un code à 6 chiffres (exemple: **428-951**)
5. Ce code est valable 24 heures uniquement
6. Vous communiquez ce code à votre receveur (par téléphone, WhatsApp, ou en personne)

**Pendant la Journée :**

Vous accédez à votre **Dashboard en Temps Réel** :

- 📊 **Nombre de tickets vendus** (mis à jour à chaque synchronisation)
- 💰 **Recettes du jour** par bus
- 🎫 **Dernier ticket émis** (numéro et heure)
- ⚠️ **Alertes de fraude** (si détectées)
- 📱 **Statut de connexion** du receveur
- 📈 **Historique** des 7 derniers jours

**En Fin de Journée :**

- Vous recevez un **rapport automatique par SMS**
- Le code de session expire à minuit
- Toutes les données sont sauvegardées dans le cloud

#### Fonctionnalités Avancées

- **Comparaison entre bus** : Quel bus génère le plus de recettes ?
- **Alertes configurables** : Recevez un SMS si aucune vente depuis 2 heures
- **Historique complet** : Consultez les recettes de n'importe quel jour passé
- **Détection d'anomalies** : Le système vous alerte si un numéro de ticket manque

---

### Application 2️⃣ : SUNU TICKET (Pour le Receveur)

**C'est l'outil de vente simple et rapide pour le terrain.**

#### Démarrage de la Journée

**Le receveur doit d'abord se connecter :**

1. Il ouvre l'application **Sunu Ticket**
2. L'écran de connexion lui demande :
   - **Matricule du Bus** (exemple: DK-3842-RB)
   - **Code de Session du Jour** (le code à 6 chiffres que VOUS lui avez donné)
3. Il appuie sur **"Démarrer la Session"**

**Que se passe-t-il en arrière-plan ?**

- L'application contacte le serveur central
- Le serveur vérifie que le code est valide et correspond bien à ce bus
- Le serveur attribue une **séquence de numéros de tickets** pour la journée (exemple: tickets #5000 à #6000)
- L'application se déverrouille et passe en mode vente
- Le receveur crée un **PIN à 4 chiffres** pour les déverrouillages rapides

⚠️ **Point de Sécurité Critique** : Sans le bon code de session, l'application refuse de démarrer. Le receveur ne peut PAS vendre sans votre autorisation.

#### Vente de Tickets (Mode Hors Ligne)

**L'interface est ultra-simple :**

1. Le receveur voit les boutons de tarifs prédéfinis :
   - **150 FCFA** (tarif normal)
   - **100 FCFA** (tarif étudiant/réduit)
   - Autres tarifs si configurés

2. Un passager monte → Le receveur appuie sur le bouton du tarif
3. L'imprimante Bluetooth imprime automatiquement le ticket :
   ```
   ═══════════════════════
   SUNU TICKET
   ═══════════════════════
   Bus: DK-3842-RB
   Ligne: 4 Colobane-Liberté
   
   Tarif: 150 FCFA
   Ticket N°: 5247
   
   Date: 05/12/2025
   Heure: 14:35
   ═══════════════════════
   Merci de votre voyage !
   ```

4. Le ticket est remis au passager
5. **Important** : La vente est enregistrée LOCALEMENT sur le téléphone (dans une base SQLite)

**Fonctionnement Hors Ligne Total :**

- ✅ Le receveur peut vendre TOUTE LA JOURNÉE sans réseau
- ✅ Les tickets s'impriment instantanément
- ✅ Toutes les données sont stockées sur le téléphone
- ✅ Aucun ralentissement, aucune attente

#### Synchronisation des Données

**Quand le receveur a du réseau (WiFi ou 3G/4G) :**

1. Un bouton **"Synchroniser"** clignote en haut de l'écran
2. Il appuie dessus
3. L'application envoie TOUTES les ventes au serveur central
4. Le propriétaire reçoit immédiatement les mises à jour sur son Dashboard

**La synchronisation peut se faire :**

- En cours de route (si réseau disponible)
- À la pause déjeuner
- En fin de journée au garage
- N'importe quand dès qu'il y a du réseau

#### Déverrouillage Rapide

Pour éviter de ressaisir le matricule et le code de session à chaque arrêt :

- Après le démarrage initial, le receveur utilise son **PIN à 4 chiffres**
- L'application se déverrouille instantanément
- Il peut reprendre les ventes immédiatement

---

## 🛡️ LE SYSTÈME ANTI-FRAUDE RÉVOLUTIONNAIRE

C'est le cœur de notre innovation. Nous avons conçu un système à **double barrière** qui rend la fraude presque impossible.

### Barrière 1️⃣ : Le Verrouillage Forcé et Traçable

**Scénario de Fraude Classique :**

Un receveur malhonnête vend 50 tickets en liquide (7 500 FCFA), puis efface les données de l'application pour ne rien déclarer au propriétaire.

**Notre Contre-Mesure :**

1. **Effacement = Verrouillage Automatique**
   - Dès que les données sont effacées, le token de session est détruit
   - L'application retourne IMMÉDIATEMENT à l'écran de connexion
   - Le receveur ne peut plus vendre

2. **Obligation de Contact**
   - Pour redémarrer, le receveur doit vous contacter pour obtenir un nouveau code de session
   - Vous savez INSTANTANÉMENT qu'il y a eu un problème

3. **Votre Réaction**
   - Avant de lui donner un nouveau code, vous lui demandez : "Pourquoi as-tu besoin d'un nouveau code ?"
   - Vous vérifiez les dernières données synchronisées
   - Vous décidez : nouveau code ou investigation approfondie

**Résultat :** Le receveur ne peut pas effacer discrètement. Il doit passer par vous, ce qui déclenche l'alerte.

### Barrière 2️⃣ : Le Talon de Billet Virtuel

**Le Principe de la Numérotation Séquentielle :**

Imaginez un carnet de tickets physique avec 100 talons numérotés de 1 à 100. Si le receveur rend le carnet avec seulement 80 tickets, vous savez immédiatement qu'il en manque 20.

**Notre Version Digitale :**

1. **Attribution au Démarrage**
   - Quand le receveur démarre sa session, le serveur lui attribue une plage de numéros
   - Exemple : "Aujourd'hui, tu as les tickets #5000 à #6000" (1000 tickets possibles)

2. **Traçabilité Absolue**
   - Chaque ticket vendu utilise un numéro dans l'ordre
   - Le serveur garde une trace de TOUS les numéros attribués

3. **Contrôle Automatique**
   - À la synchronisation, le serveur vérifie :
     - Ticket #5000 ✅
     - Ticket #5001 ✅
     - Ticket #5002 ❌ MANQUANT
     - Ticket #5003 ✅
   
4. **Alerte Immédiate**
   - Le Dashboard du propriétaire affiche : **⚠️ 15 tickets manquants dans la séquence**
   - Vous savez EXACTEMENT combien de ventes ont été cachées

**Scénario de Test :**

- Le receveur efface 50 tickets de sa base locale
- Il synchronise les 200 autres tickets
- Le serveur détecte les trous : #5010 à #5060 manquants
- VOUS recevez l'alerte : "50 tickets non comptabilisés = 7 500 FCFA manquants"
- Le receveur doit justifier chaque numéro manquant

**Résultat :** Même avec une reconnexion, le receveur ne peut pas faire disparaître les ventes. Les numéros manquants le trahissent.

---

## 🔄 FLUX COMPLET D'UNE JOURNÉE TYPE

### 📅 Lundi 5 Décembre 2025 - Bus DK-3842-RB (Ligne 4)

**6h00 AM - Chez le Propriétaire (Vous)**

1. Vous prenez votre café
2. Vous ouvrez **Sunu Ticket Pro**
3. Vous sélectionnez le bus DK-3842-RB
4. Vous appuyez sur "Générer Code"
5. Code affiché : **683-492**
6. Vous envoyez ce code par WhatsApp à votre receveur Moussa

**6h30 AM - Au Garage (Moussa le Receveur)**

1. Moussa reçoit le code : 683-492
2. Il ouvre Sunu Vente
3. Il entre :
   - Matricule : DK-3842-RB
   - Code : 683-492
4. Le serveur valide et attribue les tickets #8000 à #9000
5. L'application se déverrouille
6. Moussa crée son PIN : 1234

**7h00 AM - Départ de Colobane**

1. Premier passager monte
2. Moussa appuie sur "150 FCFA"
3. Ticket #8000 s'imprime
4. Passager reçoit son ticket
5. Vente enregistrée LOCALEMENT (pas de réseau encore)

**9h30 AM - Arrivée à Liberté 6**

1. Moussa a vendu 85 tickets (tickets #8000 à #8085)
2. Il a du WiFi au point d'arrêt
3. Il appuie sur "Synchroniser"
4. Les 85 ventes partent vers le serveur

**9h31 AM - Sur Votre Téléphone**

1. Notification : "📊 Nouvelle synchronisation - Bus DK-3842-RB"
2. Vous ouvrez **Sunu Ticket Pro**
3. Vous voyez :
   - **85 tickets vendus**
   - **12 750 FCFA de recettes**
   - Dernier ticket : #8085 à 9h28
4. Vous êtes rassuré, tout se passe bien

**12h00 PM - Pause Déjeuner**

1. Moussa a vendu 130 tickets de plus (jusqu'à #8215)
2. Il synchronise à nouveau
3. Vous recevez la mise à jour :
   - Total : **215 tickets**
   - Total : **32 250 FCFA**

**18h00 PM - Fin de Service**

1. Moussa a terminé sa journée
2. Total final : 347 tickets vendus (jusqu'à #8347)
3. Il synchronise une dernière fois
4. Vous voyez le rapport final :
   - **347 tickets vendus**
   - **52 050 FCFA de recettes**
   - **Aucun numéro manquant ✅**
   - Séquence complète : #8000 à #8347

**18h30 PM - Rapport Automatique**

Vous recevez un SMS :

```
SUNU TICKET - Rapport du 05/12/2025
Bus: DK-3842-RB
Tickets: 347
Recettes: 52 050 FCFA
Statut: ✅ Tout est OK
```

---

## 🛠️ INFRASTRUCTURE TECHNIQUE

### Architecture du Système

```
┌─────────────────┐
│ SUNU TICKET Pro │  ← Vous (Propriétaire)
│  (Android)      │
└────────┬────────┘
         │
         ↓ Internet (WiFi/4G)
         │
┌────────▼─────────────────────────┐
│   SERVEUR CENTRAL SÉCURISÉ       │
│   - Base de données               │
│   - Gestion codes session         │
│   - Contrôle séquences            │
│   - Détection fraudes             │
└────────┬─────────────────────────┘
         │
         ↓ Internet (WiFi/4G)
         │
┌────────▼────────┐
│  SUNU TICKET    │  ← Receveur
│  (Android)      │
│  + Imprimante   │
│    Bluetooth    │
└─────────────────┘
```

### Composants Matériels Nécessaires

**Pour le Propriétaire :**
- 1 smartphone Android (votre téléphone personnel)
- Connexion internet (WiFi ou forfait data)

**Pour Chaque Bus :**
- 1 smartphone Android (≥ Android 8.0)
  - Prix estimé : 40 000 - 60 000 FCFA
  - Peut être un téléphone d'occasion
- 1 imprimante thermique Bluetooth
  - Prix estimé : 35 000 - 45 000 FCFA
  - Modèles compatibles : BluetoothReceipt Printer, EPPOS, etc.
- Papier thermique 58mm (rouleaux)
  - Prix : ~500 FCFA le rouleau
  - Durée : ~400 tickets par rouleau

**Investissement Initial par Bus :**
- Total matériel : 75 000 - 105 000 FCFA (une seule fois)
- Rentabilité : 2-3 mois vs système concurrent

### Stockage et Sécurité des Données

**Sur le Téléphone du Receveur :**
- Base SQLite locale cryptée
- Capacité : ~10 000 tickets stockables hors ligne
- Données effacées automatiquement après synchronisation réussie

**Sur le Serveur Central :**
- Hébergement cloud sécurisé (AWS ou équivalent)
- Backup automatique quotidien
- Conservation des données : 2 ans minimum
- Cryptage SSL/TLS pour toutes les communications

---

## 💰 MODÈLE ÉCONOMIQUE

### Pour Vous (Propriétaire)

**Coûts :**

| Élément | Coût |
|---------|------|
| Abonnement Sunu Ticket | 2 000 FCFA/mois par bus |
| Téléphone du receveur | 50 000 FCFA (une fois) |
| Imprimante Bluetooth | 40 000 FCFA (une fois) |
| Papier thermique | ~3 000 FCFA/mois |
| **Total Mensuel** | **~5 000 FCFA** |

**Comparaison avec le Concurrent :**

- Concurrent : 36 000 FCFA/mois
- Sunu Ticket : 5 000 FCFA/mois
- **Économie : 31 000 FCFA/mois**
- **Économie annuelle : 372 000 FCFA**

**Retour sur Investissement :**

- Investissement initial : 90 000 FCFA
- Économie mensuelle : 31 000 FCFA
- **ROI : 3 mois** (après ça, c'est 100% de profit)

### Pour Nous (Sunu Ticket)

**Revenus par Bus :**
- Abonnement : 2 000 FCFA/mois
- Objectif : 500 bus la première année
- **Revenu mensuel cible : 1 000 000 FCFA**

**Coûts :**
- Serveur cloud : ~50 000 FCFA/mois
- Support client : 2 agents à 150 000 FCFA/mois
- Maintenance : 100 000 FCFA/mois
- **Total coûts : ~400 000 FCFA/mois**

**Marge nette : ~600 000 FCFA/mois** (à 500 bus)

---

## 📊 PLAN DE LANCEMENT

### Phase 1 : Développement MVP (2 mois)

**Objectifs :**
- ✅ Sunu Ticket Pro fonctionnel (génération codes, dashboard)
- ✅ Sunu Ticket fonctionnel (vente hors ligne, impression)
- ✅ Serveur central opérationnel
- ✅ Système anti-fraude intégré

**Livrables :**
- 2 applications Android testées
- Documentation technique
- Guide d'utilisation simplifié

### Phase 2 : Programme Pilote (2-3 mois)

**Objectifs :**
- Recruter 1 GIE partenaire (5 bus)
- Offre **100% GRATUITE** pendant 3 mois
- Nous fournissons tout : imprimantes, formation, support

**Métriques à Mesurer :**
- Taux de fraude détecté
- Économies réalisées (preuves chiffrées)
- Satisfaction propriétaires
- Facilité d'utilisation receveurs

**Livrable Final :**
- Étude de cas avec chiffres réels
- Témoignages vidéo
- Preuves d'économies (34 000 FCFA/mois)

### Phase 3 : Lancement Commercial (6 mois)

**Mois 1-2 : Attaque Ligne 4**
- Cibler tous les GIE de la Ligne 4
- Offre de lancement : **1er mois à 1 000 FCFA**
- Objectif : 30 bus

**Mois 3-4 : Extension Zones Périphériques**
- Lignes 5, 7, 8 (Pikine, Guédiawaye)
- Partenariats avec associations de transporteurs
- Objectif cumulé : 100 bus

**Mois 5-6 : Expansion Dakar Centre**
- Lignes 1, 2, 3 (Plateau, Médina)
- Marketing via bouche-à-oreille
- Objectif cumulé : 200 bus

**Année 2 : Objectif 500 bus**

---

## 🎤 ARGUMENTS DE VENTE CLÉS

### Pour Convaincre un Propriétaire Sceptique

**Argument 1 : L'Économie Brutale**
> "Monsieur, combien vous payez par semaine pour votre système actuel ? 9 000 FCFA ? Sur un an, ça fait 468 000 FCFA. Avec nous, vous payez 24 000 FCFA par an. Vous économisez **444 000 FCFA**. Avec ça, vous pouvez payer 3 mois de carburant !"

**Argument 2 : Le Contrôle en Temps Réel**
> "Vous êtes chez vous, votre bus roule. Vous prenez votre téléphone, vous voyez EXACTEMENT combien de passagers sont montés. Plus besoin d'attendre le soir pour savoir si votre receveur dit la vérité."

**Argument 3 : La Propriété du Matériel**
> "Le téléphone et l'imprimante sont À VOUS. Pas de location. Si vous arrêtez de travailler avec nous demain, vous gardez tout. Aucun autre système ne vous offre ça."

**Argument 4 : La Sécurité Anti-Fraude**
> "Si votre receveur efface les données pour vous voler, il ne peut plus vendre. Il doit vous appeler pour redemander un code. Vous saurez IMMÉDIATEMENT qu'il y a un problème."

**Argument 5 : Pas de Risque**
> "On vous offre 1 mois gratuit. Vous testez. Si ça ne marche pas, vous ne payez rien et vous arrêtez. Mais je vous garantis qu'après 1 mois, vous ne voudrez plus revenir en arrière."

---

## ❓ RÉPONSES AUX OBJECTIONS

### "Et si le téléphone tombe en panne ?"

**Réponse :**
"C'est justement l'avantage : c'est VOTRE téléphone. Vous pouvez le réparer vous-même ou en acheter un autre. Avec les systèmes en location, si leur machine tombe en panne, vous devez attendre qu'ils viennent la réparer. Vous perdez des jours de recettes. Avec nous, vous mettez l'application sur un autre téléphone en 10 minutes."

### "Mon receveur ne sait pas utiliser un smartphone."

**Réponse :**
"Notre application est ULTRA-SIMPLE. Il y a 2 gros boutons : 150 FCFA et 100 FCFA. C'est tout. Même un enfant de 10 ans peut l'utiliser. Et on forme votre receveur gratuitement pendant 1 heure. Après ça, c'est automatique."

### "Et s'il n'y a pas de réseau internet ?"

**Réponse :**
"C'est prévu ! Le receveur peut vendre TOUTE LA JOURNÉE sans internet. Zéro problème. Les tickets s'impriment, tout fonctionne. Il synchronise seulement quand il a du réseau, même en fin de journée. Vous recevez les données dès qu'il se connecte."

### "2 000 FCFA par mois, c'est quand même de l'argent."

**Réponse :**
"Exact. Mais regardez : vous payez actuellement 36 000 FCFA par mois. Avec nous, c'est 2 000 FCFA. Vous économisez 34 000 FCFA. Sur 1 an, c'est 408 000 FCFA d'économie. Ça paie combien de pneus neufs ? Combien de révisions ?"

### "Comment je sais que vous n'allez pas augmenter le prix après ?"

**Réponse :**
"Nous vous offrons un **contrat de 2 ans à prix fixe : 2 000 FCFA/mois garanti**. Même si demain on décide d'augmenter pour les nouveaux clients, vous gardez votre prix. C'est écrit noir sur blanc dans le contrat."

---

## 📞 CONTACT ET PROCHAINES ÉTAPES

### Pour Devenir Client Pilote (GRATUIT)

Si vous êtes propriétaire de bus et intéressé par notre programme pilote gratuit :

1. **Appelez-nous** : [Numéro de Téléphone]
2. **WhatsApp** : [Numéro WhatsApp]
3. **Email** : contact@sunuticket.sn

**Ce qu'on vous offre pendant le pilote :**
- ✅ 3 mois GRATUITS (zéro paiement)
- ✅ Imprimantes fournies
- ✅ Formation complète
- ✅ Support 7j/7
- ✅ Aucun engagement après les 3 mois

**Conditions pour participer :**
- Avoir au moins 3 bus opérationnels
- Être basé à Dakar
- Accepter que nous documentions les résultats (photos, vidéos, témoignages)

### Pour Investir dans Sunu Ticket

Si vous êtes investisseur intéressé par le projet :

**Nous recherchons :**
- 15 000 000 FCFA pour le développement et le lancement
- Partenaires stratégiques (associations de transporteurs, GIE)

**Retour attendu :**
- Année 1 : 200 bus = 4 800 000 FCFA/an
- Année 2 : 500 bus = 12 000 000 FCFA/an
- Année 3 : 1000 bus = 24 000 000 FCFA/an

---

## 🏆 POURQUOI NOUS ALLONS RÉUSSIR

### Notre Avantage Concurrentiel

1. **Prix imbattable** : 94% moins cher que la concurrence
2. **Technologie robuste** : Fonctionne hors ligne
3. **Anti-fraude unique** : Double système de sécurité
4. **Propriété matérielle** : Le client garde son équipement
5. **Support local** : Équipe basée à Dakar, réactive

### Notre Vision

**Court terme (1 an) :** Devenir le standard sur 3 lignes de bus à Dakar

**Moyen terme (3 ans) :** Équiper 50% des bus GIE de Dakar

**Long terme (5 ans) :** Extension aux taxis, cars rapides, transport interurbain

---

## 📝 CONCLUSION

**Sunu Ticket** n'est pas juste un logiciel. C'est une révolution dans la gestion du transport urbain au Sénégal.

Nous offrons aux propriétaires de bus :
- Une **économie massive** (34 000 FCFA/mois)
- Un **contrôle total** sur leurs recettes
- Une **protection anti-fraude** inégalée
- Une **liberté** vis-à-vis des systèmes de location coûteux

**Le transport urbain sénégalais mérite mieux.**

**Nous sommes prêts à le prouver.**

---

*Sunu Ticket - La billetterie qui respecte votre argent.*

**Contact :** sambadiop161@gmail.com