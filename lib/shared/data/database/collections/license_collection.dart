import 'package:isar/isar.dart';
import 'package:study_planner/shared/domain/enums/license_status.dart';
import 'package:study_planner/shared/domain/enums/license_type.dart';

part 'license_collection.g.dart';

/// Singleton Isar row (id = 1) that stores the locally persisted license.
///
/// Created exactly once, immediately after a successful Supabase activation.
/// The app reads this row on every launch to decide whether to show the
/// activation screen or open normally — zero network requests required after
/// the first activation.
@collection
class LicenseCollection {
  Id id = 1;

  /// Server-generated UUID from the `redeem_activation_code` RPC.
  /// This is the only proof of a valid redemption stored locally.
  late String activationId;

  @Enumerated(EnumType.name)
  late LicenseType type;

  @Enumerated(EnumType.name)
  late LicenseStatus status;

  late DateTime activatedAt;

  late DateTime createdAt;
}
