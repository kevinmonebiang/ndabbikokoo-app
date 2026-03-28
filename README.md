
# Ndabbikokoo App

Application Flutter elegante pour une association Bassa de la diaspora, orientee consultation en lecture seule des informations membres et des cotisations, avec administration conservee dans Odoo.

## Fonctionnalites incluses

- connexion avec numero de membre, email ou telephone
- affichage du profil membre
- consultation des cotisations
- historique des paiements
- statut membre : a jour / en retard
- annonces et communiques
- contacts utiles de l'association
- carte de membre numerique

## Important sur Postgres

L'application mobile ne doit pas se connecter directement a Postgres. :

1. Flutter mobile
2. Odoo expose des routes API securisees
3. Postgres derriere Odoo

Cela permet de proteger les identifiants, gerer les droits d'acces, journaliser les connexions et garder l'application en mode lecture seule.

## Demarrage du projet

flutter create .

flutter pub get

flutter run

## Comptes de demonstration

Pour tester l'interface avec les donnees demo :

- identifiant : `BAS-24017`
- ou email : `marie.muteba@ndabbikokoo.org`
- ou telephone : `+33 6 74 10 22 45`
- code secret : `1234`

## Branchement au backend Odoo

Le point d'entree utilise :

- `MockMemberRepository` en mode demo
- `OdooMemberRepository` quand `USE_MOCK_DATA=false`

Pour connecter le backend existant :

1. exposer depuis Odoo les routes mobile de connexion et de portail membre
2. lancer l app avec `--dart-define=USE_MOCK_DATA=false`
3. renseigner `ODOO_BASE_URL`
4. adapter les chemins si necessaire avec `ODOO_LOGIN_PATH` et `ODOO_PORTAL_PATH`

Un modele d'integration est disponible dans `docs/backend_integration.md`.

## Logo

Le projet attend le logo ici :

- `assets/branding/logo.png`


## Structure

- `lib/app.dart` : point d'entree applicatif
- `lib/screens/` : ecrans
- `lib/models/` : modeles metier
- `lib/repositories/` : acces aux donnees
- `lib/theme/` : identite visuelle
- `lib/widgets/` : composants reutilisables
=======
# ndabbikokoo-app
Application pour l'association  des Bassa de la diaspora, orienté consultation en lecture seule des informations membres et des cotisations, avec administration avec Odoo.
