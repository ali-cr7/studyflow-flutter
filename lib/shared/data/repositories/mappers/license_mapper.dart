import 'package:study_planner/core/constants/database_constants.dart';
import 'package:study_planner/shared/data/database/collections/license_collection.dart';
import 'package:study_planner/shared/domain/entities/license.dart';

abstract final class LicenseMapper {
  static License toDomain(LicenseCollection c) {
    return License(
      activationId: c.activationId,
      type: c.type,
      status: c.status,
      activatedAt: c.activatedAt,
      createdAt: c.createdAt,
    );
  }

  static LicenseCollection toCollection(License license) {
    return LicenseCollection()
      ..id = DatabaseConstants.singletonId
      ..activationId = license.activationId
      ..type = license.type
      ..status = license.status
      ..activatedAt = license.activatedAt
      ..createdAt = license.createdAt;
  }
}
