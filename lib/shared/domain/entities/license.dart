import 'package:study_planner/shared/domain/enums/license_status.dart';
import 'package:study_planner/shared/domain/enums/license_type.dart';

/// Local license record written to Isar after successful activation.
///
/// The activation code itself is never stored here — only the server-issued
/// [activationId] (a UUID) that proves the code was validly redeemed.
class License {
  const License({
    required this.activationId,
    required this.type,
    required this.status,
    required this.activatedAt,
    required this.createdAt,
  });

  /// Server-generated UUID returned by the `redeem_activation_code` RPC.
  final String activationId;

  final LicenseType type;
  final LicenseStatus status;

  /// Wall-clock time when the activation RPC succeeded on the server.
  final DateTime activatedAt;

  /// Wall-clock time when this local record was first written.
  final DateTime createdAt;

  bool get isActive => status == LicenseStatus.active;
}
