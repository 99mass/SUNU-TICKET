# Prompt pour Génération Backend Spring Boot (Sunu Ticket Pro)

**Rôle :** Senior Backend Developer (Java/Spring Boot)
**Objectif :** Créer une API REST sécurisée pour l'application mobile "Sunu Ticket Pro".
**Stack Technique :** Java 17, Spring Boot 3, Spring Security (JWT), PostgreSQL, Lombok, JPA/Hibernate.

---

## 1. Base de Données (Entités & Tables)

### Table: `users`
Gère les utilisateurs de l'application (propriétaires de bus/gestionnaires).
- `id` (Long, Primary Key, Auto-increment)
- `name` (String, Not Null)
- `phone` (String, Unique, Not Null) - Format: "+22177XXXXXXX"
- `password` (String, Not Null) - Hashé (BCrypt)
- `is_verified` (Boolean, Default: false) - Statut vérification OTP
- `created_at` (Timestamp)
- `updated_at` (Timestamp)

### Table: `otp_verifications`
Stocke les codes OTP temporaires pour l'inscription et la récupération de mot de passe.
- `id` (Long, Primary Key)
- `phone` (String, Not Null)
- `code` (String, Not Null) - 6 chiffres
- `expires_at` (Timestamp, Not Null)
- `is_used` (Boolean, Default: false)

---

## 2. API Endpoints & Contrats (JSON)

Tous les endpoints sont préfixés par `/api/v1/auth`.

### A. Inscription
**POST** `/register`
- **Body :**
  ```json
  {
    "name": "Moussa Diop",
    "phone": "+221771234567",
    "password": "1234" // Code PIN 4 chiffres
  }
  ```
- **Logique :** Créer l'utilisateur avec `is_verified = false`. Générer et envoyer un OTP (simulé pour l'instant).
- **Response (201 Created) :**
  ```json
  {
    "success": true,
    "message": "Inscription réussie. Veuillez vérifier votre téléphone.",
    "user": { "id": 1, "name": "Moussa Diop", "phone": "+221771234567", "is_verified": false }
  }
  ```

### B. Connexion
**POST** `/login`
- **Body :**
  ```json
  {
    "phone": "+221771234567",
    "password": "1234"
  }
  ```
- **Logique :** Vérifier credentials. Si `is_verified` est false, renvoyer une erreur spécifique ou un flag. Sinon, retourner le JWT.
- **Response (200 OK) :**
  ```json
  {
    "success": true,
    "token": "eyJhbGciOiJIUzI1NiJ9...",
    "user": { ... },
    "message": "Connexion réussie"
  }
  ```

### C. Vérification OTP
**POST** `/verify-otp`
- **Body :**
  ```json
  {
    "phone": "+221771234567",
    "otp": "123456"
  }
  ```
- **Logique :** Vérifier si le code correspond et n'est pas expiré. Si OK, passer `users.is_verified` à `true`.
- **Response (200 OK) :**
  ```json
  {
    "success": true,
    "token": "eyJhbGciOiJIUzI1NiJ9...", // Générer le token ici aussi pour auto-login
    "user": { ... },
    "message": "Compte vérifié avec succès"
  }
  ```

### D. Mot de passe oublié (Demande)
**POST** `/forgot-password/send-otp`
- **Body :**
  ```json
  {
    "phone": "+221771234567"
  }
  ```
- **Logique :** Vérifier si le user existe. Si oui, générer un nouveau code OTP.
- **Response (200 OK) :**
  ```json
  {
    "success": true,
    "message": "Code de réinitialisation envoyé"
  }
  ```

### E. Réinitialisation Mot de passe
**POST** `/reset-password`
- **Body :**
  ```json
  {
    "phone": "+221771234567",
    "new_password": "5678"
    // Note: L'OTP doit avoir été vérifié au préalable, ou inclus ici pour sécuriser
  }
  ```
- **Logique :** Mettre à jour le mot de passe hashé.
- **Response (200 OK) :**
  ```json
  {
    "success": true,
    "message": "Mot de passe modifié avec succès"
  }
  ```

### F. Utilisateur Courant
**GET** `/me`
- **Headers :** `Authorization: Bearer <token>`
- **Response (200 OK) :**
  ```json
  {
    "success": true,
    "user": { ... }
  }
  ```

---

## 3. Instructions Spécifiques
1.  Utiliser **Spring Security** pour sécuriser les endpoints (sauf `/auth/**` qui sont publics).
2.  Implémenter un **JwtAuthenticationFilter** pour valider le token sur les requêtes protégées.
3.  Utiliser le pattern **Repository/Service/Controller**.
4.  Gérer les exceptions globales (GlobalExceptionHandler) pour retourner des erreurs JSON propres (`success: false`, `message: "Erreur..."`).
5.  Le mot de passe est un code PIN de 4 chiffres, mais doit être stocké de manière sécurisée (BCrypt).
