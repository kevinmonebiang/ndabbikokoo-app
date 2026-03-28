# Integration Flutter - Odoo - Postgres

## Architecture reelle du projet

- application Flutter pour les membres
- backend metier et administration dans Odoo
- base de donnees Postgres derriere Odoo

L application mobile ne doit pas parler directement a Postgres. Elle doit appeler des routes Odoo exposees pour le mobile.

## Ce qui est deja prepare dans Flutter

- un mode demo avec `MockMemberRepository`
- un mode backend avec `OdooMemberRepository`
- un basculement par variables d environnement dans `AppConfig`

## Variables d environnement utiles

Vous pouvez lancer Flutter avec :

```bash
flutter run --dart-define=USE_MOCK_DATA=false --dart-define=ODOO_BASE_URL=https://votre-odoo.com
```

Optionnellement :

```bash
flutter run \
  --dart-define=USE_MOCK_DATA=false \
  --dart-define=ODOO_BASE_URL=https://votre-odoo.com \
  --dart-define=ODOO_LOGIN_PATH=/api/mobile/member/login \
  --dart-define=ODOO_PORTAL_PATH=/api/mobile/member/portal
```

## Contrat API conseille cote Odoo

### Connexion

`POST /api/mobile/member/login`

```json
{
  "identifier": "BAS-24017",
  "secret": "1234"
}
```

Reponse conseillee :

```json
{
  "token": "jwt-ou-token-session",
  "memberId": 42
}
```

### Chargement du portail membre

`GET /api/mobile/member/portal`

Header :

```text
Authorization: Bearer <token>
```

Reponse conseillee :

```json
{
  "data": {
    "member": {
      "memberNumber": "BAS-24017",
      "fullName": "Marie Muteba Ndzi",
      "roleLabel": "Membre active",
      "community": "Communaute Bassa Europe",
      "city": "Paris",
      "country": "France",
      "phone": "+33 6 74 10 22 45",
      "email": "marie.muteba@ndabbikokoo.org",
      "joinedOn": "2021-09-12",
      "monthlyContribution": 25,
      "totalPaidThisYear": 250,
      "balanceDue": 50,
      "status": "overdue",
      "validUntil": "2026-05-31"
    },
    "payments": [
      {
        "label": "Cotisation fevrier 2026",
        "reference": "PAY-2026-0208",
        "method": "Virement",
        "amount": 25,
        "paidOn": "2026-02-08",
        "statusLabel": "Valide"
      }
    ],
    "announcements": [
      {
        "title": "Assemblee generale du printemps",
        "category": "Communique",
        "message": "Message de l annonce",
        "publishedOn": "2026-03-20",
        "highlighted": true
      }
    ],
    "contacts": [
      {
        "name": "Claudine Ndzi",
        "role": "Presidente",
        "phone": "+33 6 14 22 71 90",
        "email": "presidence@ndabbikokoo.org",
        "availability": "Lun - Ven, 18h a 21h"
      }
    ]
  }
}
```

## Mapping deja tolerant dans Flutter

Le repository Odoo accepte plusieurs variantes de noms de champs, par exemple :

- `memberNumber` ou `member_number`
- `joinedOn` ou `joined_on`
- `payments` ou `contributions`
- `announcements` ou `news`

Cela permet d adapter plus facilement le mobile a vos routes Odoo existantes.

## Logo

Pour afficher votre vrai logo dans l application, ajoutez le fichier :

- `assets/branding/logo.png`

Le composant `BrandMark` utilisera automatiquement ce fichier. Sinon, il affiche un embleme de secours inspire de votre logo.
