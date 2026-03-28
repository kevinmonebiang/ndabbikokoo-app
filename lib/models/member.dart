enum MemberStatus { upToDate, overdue }

class Member {
  const Member({
    required this.memberNumber,
    required this.fullName,
    required this.roleLabel,
    required this.community,
    required this.city,
    required this.country,
    required this.phone,
    required this.email,
    required this.joinedOn,
    required this.monthlyContribution,
    required this.totalPaidThisYear,
    required this.balanceDue,
    required this.status,
    required this.validUntil,
  });

  final String memberNumber;
  final String fullName;
  final String roleLabel;
  final String community;
  final String city;
  final String country;
  final String phone;
  final String email;
  final DateTime joinedOn;
  final double monthlyContribution;
  final double totalPaidThisYear;
  final double balanceDue;
  final MemberStatus status;
  final DateTime validUntil;

  String get statusLabel {
    switch (status) {
      case MemberStatus.upToDate:
        return 'A jour';
      case MemberStatus.overdue:
        return 'En retard';
    }
  }
}

