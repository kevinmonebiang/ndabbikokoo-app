import '../models/announcement.dart';
import '../models/association_contact.dart';
import '../models/member.dart';
import '../models/member_portal_data.dart';
import '../models/payment.dart';
import 'member_repository.dart';

class MockMemberRepository implements MemberRepository {
  static const String _demoSecret = '1234';

  final MemberPortalData _demoData = MemberPortalData(
    member: Member(
      memberNumber: 'BAS-24017',
      fullName: 'Marie Muteba Ndzi',
      roleLabel: 'Membre active',
      community: 'Communaute Bassa Europe',
      city: 'Paris',
      country: 'France',
      phone: '+33 6 74 10 22 45',
      email: 'marie.muteba@ndabbikokoo.org',
      joinedOn: DateTime(2021, 9, 12),
      monthlyContribution: 25,
      totalPaidThisYear: 250,
      balanceDue: 50,
      status: MemberStatus.overdue,
      validUntil: DateTime(2026, 5, 31),
    ),
    payments: [
      Payment(
        label: 'Cotisation fevrier 2026',
        reference: 'PAY-2026-0208',
        method: 'Virement',
        amount: 25,
        paidOn: DateTime(2026, 2, 8),
        statusLabel: 'Valide',
      ),
      Payment(
        label: 'Cotisation janvier 2026',
        reference: 'PAY-2026-0110',
        method: 'Mobile money',
        amount: 25,
        paidOn: DateTime(2026, 1, 10),
        statusLabel: 'Valide',
      ),
      Payment(
        label: 'Cotisation decembre 2025',
        reference: 'PAY-2025-1218',
        method: 'Virement',
        amount: 25,
        paidOn: DateTime(2025, 12, 18),
        statusLabel: 'Valide',
      ),
      Payment(
        label: 'Cotisation novembre 2025',
        reference: 'PAY-2025-1111',
        method: 'Especes',
        amount: 25,
        paidOn: DateTime(2025, 11, 11),
        statusLabel: 'Valide',
      ),
      Payment(
        label: 'Fonds de solidarite',
        reference: 'PAY-2025-1015',
        method: 'Virement',
        amount: 100,
        paidOn: DateTime(2025, 10, 15),
        statusLabel: 'Valide',
      ),
    ],
    announcements: [
      Announcement(
        title: 'Assemblee generale du printemps',
        category: 'Communique',
        message:
            'La prochaine assemblee generale aura lieu le 18 avril a Paris et sera egalement diffusee en ligne pour les membres de la diaspora.',
        publishedOn: DateTime(2026, 3, 20),
        highlighted: true,
      ),
      Announcement(
        title: 'Rappel de cotisation du premier trimestre',
        category: 'Tresorerie',
        message:
            'Les membres ayant un solde en attente sont invites a regulariser avant le 31 mars afin de garder leur statut a jour.',
        publishedOn: DateTime(2026, 3, 12),
      ),
      Announcement(
        title: 'Programme jeunesse Bassa',
        category: 'Vie associative',
        message:
            'Un nouveau programme de mentorat est lance pour rapprocher les jeunes de la diaspora et les aines de l association.',
        publishedOn: DateTime(2026, 2, 27),
      ),
    ],
    contacts: const [
      AssociationContact(
        name: 'Claudine Ndzi',
        role: 'Presidente',
        phone: '+33 6 14 22 71 90',
        email: 'presidence@ndabbikokoo.org',
        availability: 'Lun - Ven, 18h a 21h',
      ),
      AssociationContact(
        name: 'Henri Mbappe',
        role: 'Tresorier',
        phone: '+32 471 55 18 32',
        email: 'tresorerie@ndabbikokoo.org',
        availability: 'Mar - Sam, 9h a 18h',
      ),
      AssociationContact(
        name: 'Aline Beya',
        role: 'Secretariat',
        phone: '+49 1512 908 77 40',
        email: 'secretariat@ndabbikokoo.org',
        availability: 'Tous les jours, 10h a 20h',
      ),
    ],
  );

  @override
  Future<MemberPortalData> signIn({
    required String identifier,
    required String secret,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final normalizedIdentifier = _normalizeIdentifier(identifier);
    final allowedIdentifiers = <String>{
      _normalizeIdentifier(_demoData.member.memberNumber),
      _demoData.member.email.toLowerCase(),
      _normalizeIdentifier(_demoData.member.phone),
    };

    if (!allowedIdentifiers.contains(normalizedIdentifier)) {
      throw const AuthFailure(
        'Identifiant introuvable. Utilisez le numero membre, l email ou le telephone enregistres.',
      );
    }

    if (secret != _demoSecret) {
      throw const AuthFailure('Code secret incorrect.');
    }

    return _demoData;
  }

  String _normalizeIdentifier(String value) {
    final lowered = value.trim().toLowerCase();
    if (lowered.contains('@')) {
      return lowered;
    }

    return lowered.replaceAll(RegExp(r'[^0-9a-z]'), '');
  }
}
