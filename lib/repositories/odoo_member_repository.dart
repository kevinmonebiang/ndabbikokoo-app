import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/announcement.dart';
import '../models/association_contact.dart';
import '../models/member.dart';
import '../models/member_portal_data.dart';
import '../models/payment.dart';
import 'member_repository.dart';

class OdooMemberRepository implements MemberRepository {
  OdooMemberRepository({
    http.Client? client,
    this.baseUrl = AppConfig.odooBaseUrl,
    this.loginPath = AppConfig.odooLoginPath,
    this.portalPath = AppConfig.odooPortalPath,
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;
  final String loginPath;
  final String portalPath;

  @override
  Future<MemberPortalData> signIn({
    required String identifier,
    required String secret,
  }) async {
    if (baseUrl.isEmpty) {
      throw const AuthFailure(
        'Configurez ODOO_BASE_URL avant d utiliser le backend Odoo.',
      );
    }

    final loginResponse = await _client.post(
      Uri.parse('$baseUrl$loginPath'),
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'identifier': identifier.trim(),
        'secret': secret,
      }),
    );

    if (loginResponse.statusCode == 401 || loginResponse.statusCode == 403) {
      throw const AuthFailure('Identifiants invalides.');
    }

    if (loginResponse.statusCode < 200 || loginResponse.statusCode >= 300) {
      throw AuthFailure(
        'Connexion Odoo indisponible (${loginResponse.statusCode}).',
      );
    }

    final loginJson = _decodeMap(loginResponse.body);
    final token = _readString(loginJson, 'token') ??
        _readString(_readMap(loginJson, 'data'), 'token');

    if (token == null || token.isEmpty) {
      throw const AuthFailure(
        'Le backend Odoo n a pas retourne de jeton de session.',
      );
    }

    final portalResponse = await _client.get(
      Uri.parse('$baseUrl$portalPath'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (portalResponse.statusCode < 200 || portalResponse.statusCode >= 300) {
      throw AuthFailure(
        'Chargement du portail membre impossible (${portalResponse.statusCode}).',
      );
    }

    return _parsePortal(_decodeMap(portalResponse.body));
  }

  MemberPortalData _parsePortal(Map<String, dynamic> json) {
    final payload = _readMap(json, 'data') ?? json;
    final memberJson = _readMap(payload, 'member') ?? payload;
    final paymentsJson =
        _readList(payload, 'payments') ?? _readList(payload, 'contributions') ?? const [];
    final announcementsJson =
        _readList(payload, 'announcements') ?? _readList(payload, 'news') ?? const [];
    final contactsJson =
        _readList(payload, 'contacts') ?? _readList(payload, 'associationContacts') ?? const [];

    return MemberPortalData(
      member: Member(
        memberNumber: _readString(memberJson, 'memberNumber') ??
            _readString(memberJson, 'member_number') ??
            'N/A',
        fullName:
            _readString(memberJson, 'fullName') ?? _readString(memberJson, 'name') ?? 'Membre',
        roleLabel: _readString(memberJson, 'roleLabel') ??
            _readString(memberJson, 'role') ??
            'Membre',
        community: _readString(memberJson, 'community') ??
            _readString(memberJson, 'communityName') ??
            'Association',
        city: _readString(memberJson, 'city') ?? '-',
        country: _readString(memberJson, 'country') ?? '-',
        phone: _readString(memberJson, 'phone') ??
            _readString(memberJson, 'mobile') ??
            '-',
        email: _readString(memberJson, 'email') ?? '-',
        joinedOn: _readDate(memberJson, 'joinedOn') ??
            _readDate(memberJson, 'joined_on') ??
            DateTime.now(),
        monthlyContribution: _readDouble(memberJson, 'monthlyContribution') ??
            _readDouble(memberJson, 'monthly_contribution') ??
            0,
        totalPaidThisYear: _readDouble(memberJson, 'totalPaidThisYear') ??
            _readDouble(memberJson, 'total_paid_this_year') ??
            0,
        balanceDue: _readDouble(memberJson, 'balanceDue') ??
            _readDouble(memberJson, 'balance_due') ??
            0,
        status: _readStatus(memberJson),
        validUntil: _readDate(memberJson, 'validUntil') ??
            _readDate(memberJson, 'valid_until') ??
            DateTime.now(),
      ),
      payments: paymentsJson
          .whereType<Map<String, dynamic>>()
          .map(
            (paymentJson) => Payment(
              label: _readString(paymentJson, 'label') ??
                  _readString(paymentJson, 'name') ??
                  'Paiement',
              reference: _readString(paymentJson, 'reference') ??
                  _readString(paymentJson, 'ref') ??
                  '-',
              method: _readString(paymentJson, 'method') ??
                  _readString(paymentJson, 'payment_method') ??
                  '-',
              amount: _readDouble(paymentJson, 'amount') ?? 0,
              paidOn: _readDate(paymentJson, 'paidOn') ??
                  _readDate(paymentJson, 'paid_on') ??
                  DateTime.now(),
              statusLabel: _readString(paymentJson, 'statusLabel') ??
                  _readString(paymentJson, 'status') ??
                  'Valide',
            ),
          )
          .toList(),
      announcements: announcementsJson
          .whereType<Map<String, dynamic>>()
          .map(
            (announcementJson) => Announcement(
              title: _readString(announcementJson, 'title') ?? 'Annonce',
              category: _readString(announcementJson, 'category') ?? 'Information',
              message: _readString(announcementJson, 'message') ??
                  _readString(announcementJson, 'content') ??
                  '',
              publishedOn: _readDate(announcementJson, 'publishedOn') ??
                  _readDate(announcementJson, 'published_on') ??
                  DateTime.now(),
              highlighted: _readBool(announcementJson, 'highlighted') ?? false,
            ),
          )
          .toList(),
      contacts: contactsJson
          .whereType<Map<String, dynamic>>()
          .map(
            (contactJson) => AssociationContact(
              name: _readString(contactJson, 'name') ?? 'Contact',
              role: _readString(contactJson, 'role') ?? '-',
              phone: _readString(contactJson, 'phone') ?? '-',
              email: _readString(contactJson, 'email') ?? '-',
              availability: _readString(contactJson, 'availability') ??
                  _readString(contactJson, 'hours') ??
                  '-',
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> _decodeMap(String body) {
    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    throw const AuthFailure('Reponse JSON invalide recue depuis Odoo.');
  }

  Map<String, dynamic>? _readMap(Map<String, dynamic>? source, String key) {
    if (source == null) {
      return null;
    }

    final value = source[key];
    if (value is Map<String, dynamic>) {
      return value;
    }

    return null;
  }

  List<dynamic>? _readList(Map<String, dynamic>? source, String key) {
    if (source == null) {
      return null;
    }

    final value = source[key];
    if (value is List<dynamic>) {
      return value;
    }

    return null;
  }

  String? _readString(Map<String, dynamic>? source, String key) {
    if (source == null) {
      return null;
    }

    final value = source[key];
    if (value == null) {
      return null;
    }

    return value.toString().trim();
  }

  double? _readDouble(Map<String, dynamic>? source, String key) {
    final raw = _readString(source, key);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    return double.tryParse(raw);
  }

  bool? _readBool(Map<String, dynamic>? source, String key) {
    if (source == null) {
      return null;
    }

    final value = source[key];
    if (value is bool) {
      return value;
    }

    if (value is String) {
      return value.toLowerCase() == 'true';
    }

    return null;
  }

  DateTime? _readDate(Map<String, dynamic>? source, String key) {
    final raw = _readString(source, key);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    return DateTime.tryParse(raw);
  }

  MemberStatus _readStatus(Map<String, dynamic> source) {
    final raw = (_readString(source, 'status') ??
            _readString(source, 'statusLabel') ??
            _readString(source, 'member_status') ??
            '')
        .toLowerCase();

    if (raw.contains('retard') || raw.contains('overdue') || raw.contains('late')) {
      return MemberStatus.overdue;
    }

    return MemberStatus.upToDate;
  }
}

