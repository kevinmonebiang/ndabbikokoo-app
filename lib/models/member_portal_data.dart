import 'announcement.dart';
import 'association_contact.dart';
import 'member.dart';
import 'payment.dart';

class MemberPortalData {
  const MemberPortalData({
    required this.member,
    required this.payments,
    required this.announcements,
    required this.contacts,
  });

  final Member member;
  final List<Payment> payments;
  final List<Announcement> announcements;
  final List<AssociationContact> contacts;
}

