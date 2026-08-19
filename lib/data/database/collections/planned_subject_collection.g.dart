// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planned_subject_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlannedSubjectCollectionCollection on Isar {
  IsarCollection<PlannedSubjectCollection> get plannedSubjectCollections =>
      this.collection();
}

const PlannedSubjectCollectionSchema = CollectionSchema(
  name: r'PlannedSubjectCollection',
  id: -932584103181922240,
  properties: {
    r'completed': PropertySchema(
      id: 0,
      name: r'completed',
      type: IsarType.bool,
    ),
    r'dailyPlanId': PropertySchema(
      id: 1,
      name: r'dailyPlanId',
      type: IsarType.long,
    ),
    r'plannedMinutes': PropertySchema(
      id: 2,
      name: r'plannedMinutes',
      type: IsarType.long,
    ),
    r'priority': PropertySchema(id: 3, name: r'priority', type: IsarType.long),
    r'sortOrder': PropertySchema(
      id: 4,
      name: r'sortOrder',
      type: IsarType.long,
    ),
    r'subjectId': PropertySchema(
      id: 5,
      name: r'subjectId',
      type: IsarType.long,
    ),
  },
  estimateSize: _plannedSubjectCollectionEstimateSize,
  serialize: _plannedSubjectCollectionSerialize,
  deserialize: _plannedSubjectCollectionDeserialize,
  deserializeProp: _plannedSubjectCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'dailyPlanId_sortOrder': IndexSchema(
      id: 2603168247487282818,
      name: r'dailyPlanId_sortOrder',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dailyPlanId',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'sortOrder',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _plannedSubjectCollectionGetId,
  getLinks: _plannedSubjectCollectionGetLinks,
  attach: _plannedSubjectCollectionAttach,
  version: '3.1.0+1',
);

int _plannedSubjectCollectionEstimateSize(
  PlannedSubjectCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _plannedSubjectCollectionSerialize(
  PlannedSubjectCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.completed);
  writer.writeLong(offsets[1], object.dailyPlanId);
  writer.writeLong(offsets[2], object.plannedMinutes);
  writer.writeLong(offsets[3], object.priority);
  writer.writeLong(offsets[4], object.sortOrder);
  writer.writeLong(offsets[5], object.subjectId);
}

PlannedSubjectCollection _plannedSubjectCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlannedSubjectCollection();
  object.completed = reader.readBool(offsets[0]);
  object.dailyPlanId = reader.readLong(offsets[1]);
  object.id = id;
  object.plannedMinutes = reader.readLong(offsets[2]);
  object.priority = reader.readLong(offsets[3]);
  object.sortOrder = reader.readLong(offsets[4]);
  object.subjectId = reader.readLong(offsets[5]);
  return object;
}

P _plannedSubjectCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _plannedSubjectCollectionGetId(PlannedSubjectCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _plannedSubjectCollectionGetLinks(
  PlannedSubjectCollection object,
) {
  return [];
}

void _plannedSubjectCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  PlannedSubjectCollection object,
) {
  object.id = id;
}

extension PlannedSubjectCollectionQueryWhereSort
    on
        QueryBuilder<
          PlannedSubjectCollection,
          PlannedSubjectCollection,
          QWhere
        > {
  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterWhere>
  anyDailyPlanIdSortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dailyPlanId_sortOrder'),
      );
    });
  }
}

extension PlannedSubjectCollectionQueryWhere
    on
        QueryBuilder<
          PlannedSubjectCollection,
          PlannedSubjectCollection,
          QWhereClause
        > {
  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdEqualToAnySortOrder(int dailyPlanId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'dailyPlanId_sortOrder',
          value: [dailyPlanId],
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdNotEqualToAnySortOrder(int dailyPlanId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dailyPlanId_sortOrder',
                lower: [],
                upper: [dailyPlanId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dailyPlanId_sortOrder',
                lower: [dailyPlanId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dailyPlanId_sortOrder',
                lower: [dailyPlanId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dailyPlanId_sortOrder',
                lower: [],
                upper: [dailyPlanId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdGreaterThanAnySortOrder(int dailyPlanId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dailyPlanId_sortOrder',
          lower: [dailyPlanId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdLessThanAnySortOrder(int dailyPlanId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dailyPlanId_sortOrder',
          lower: [],
          upper: [dailyPlanId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdBetweenAnySortOrder(
    int lowerDailyPlanId,
    int upperDailyPlanId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dailyPlanId_sortOrder',
          lower: [lowerDailyPlanId],
          includeLower: includeLower,
          upper: [upperDailyPlanId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdSortOrderEqualTo(int dailyPlanId, int sortOrder) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'dailyPlanId_sortOrder',
          value: [dailyPlanId, sortOrder],
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdEqualToSortOrderNotEqualTo(int dailyPlanId, int sortOrder) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dailyPlanId_sortOrder',
                lower: [dailyPlanId],
                upper: [dailyPlanId, sortOrder],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dailyPlanId_sortOrder',
                lower: [dailyPlanId, sortOrder],
                includeLower: false,
                upper: [dailyPlanId],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dailyPlanId_sortOrder',
                lower: [dailyPlanId, sortOrder],
                includeLower: false,
                upper: [dailyPlanId],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'dailyPlanId_sortOrder',
                lower: [dailyPlanId],
                upper: [dailyPlanId, sortOrder],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdEqualToSortOrderGreaterThan(
    int dailyPlanId,
    int sortOrder, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dailyPlanId_sortOrder',
          lower: [dailyPlanId, sortOrder],
          includeLower: include,
          upper: [dailyPlanId],
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdEqualToSortOrderLessThan(
    int dailyPlanId,
    int sortOrder, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dailyPlanId_sortOrder',
          lower: [dailyPlanId],
          upper: [dailyPlanId, sortOrder],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterWhereClause
  >
  dailyPlanIdEqualToSortOrderBetween(
    int dailyPlanId,
    int lowerSortOrder,
    int upperSortOrder, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'dailyPlanId_sortOrder',
          lower: [dailyPlanId, lowerSortOrder],
          includeLower: includeLower,
          upper: [dailyPlanId, upperSortOrder],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension PlannedSubjectCollectionQueryFilter
    on
        QueryBuilder<
          PlannedSubjectCollection,
          PlannedSubjectCollection,
          QFilterCondition
        > {
  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  completedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'completed', value: value),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  dailyPlanIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dailyPlanId', value: value),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  dailyPlanIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dailyPlanId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  dailyPlanIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dailyPlanId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  dailyPlanIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dailyPlanId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  plannedMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'plannedMinutes', value: value),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  plannedMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'plannedMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  plannedMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'plannedMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  plannedMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'plannedMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  priorityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'priority', value: value),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  priorityGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'priority',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  priorityLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'priority',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  priorityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'priority',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  sortOrderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sortOrder', value: value),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  sortOrderGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sortOrder',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  sortOrderLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sortOrder',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  sortOrderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sortOrder',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  subjectIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'subjectId', value: value),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  subjectIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'subjectId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  subjectIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'subjectId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    PlannedSubjectCollection,
    PlannedSubjectCollection,
    QAfterFilterCondition
  >
  subjectIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'subjectId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension PlannedSubjectCollectionQueryObject
    on
        QueryBuilder<
          PlannedSubjectCollection,
          PlannedSubjectCollection,
          QFilterCondition
        > {}

extension PlannedSubjectCollectionQueryLinks
    on
        QueryBuilder<
          PlannedSubjectCollection,
          PlannedSubjectCollection,
          QFilterCondition
        > {}

extension PlannedSubjectCollectionQuerySortBy
    on
        QueryBuilder<
          PlannedSubjectCollection,
          PlannedSubjectCollection,
          QSortBy
        > {
  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortByDailyPlanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyPlanId', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortByDailyPlanIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyPlanId', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortByPlannedMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedMinutes', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortByPlannedMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedMinutes', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  sortBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }
}

extension PlannedSubjectCollectionQuerySortThenBy
    on
        QueryBuilder<
          PlannedSubjectCollection,
          PlannedSubjectCollection,
          QSortThenBy
        > {
  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenByDailyPlanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyPlanId', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenByDailyPlanIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyPlanId', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenByPlannedMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedMinutes', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenByPlannedMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedMinutes', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QAfterSortBy>
  thenBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }
}

extension PlannedSubjectCollectionQueryWhereDistinct
    on
        QueryBuilder<
          PlannedSubjectCollection,
          PlannedSubjectCollection,
          QDistinct
        > {
  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QDistinct>
  distinctByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completed');
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QDistinct>
  distinctByDailyPlanId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyPlanId');
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QDistinct>
  distinctByPlannedMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plannedMinutes');
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QDistinct>
  distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QDistinct>
  distinctBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortOrder');
    });
  }

  QueryBuilder<PlannedSubjectCollection, PlannedSubjectCollection, QDistinct>
  distinctBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subjectId');
    });
  }
}

extension PlannedSubjectCollectionQueryProperty
    on
        QueryBuilder<
          PlannedSubjectCollection,
          PlannedSubjectCollection,
          QQueryProperty
        > {
  QueryBuilder<PlannedSubjectCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlannedSubjectCollection, bool, QQueryOperations>
  completedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completed');
    });
  }

  QueryBuilder<PlannedSubjectCollection, int, QQueryOperations>
  dailyPlanIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyPlanId');
    });
  }

  QueryBuilder<PlannedSubjectCollection, int, QQueryOperations>
  plannedMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plannedMinutes');
    });
  }

  QueryBuilder<PlannedSubjectCollection, int, QQueryOperations>
  priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<PlannedSubjectCollection, int, QQueryOperations>
  sortOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortOrder');
    });
  }

  QueryBuilder<PlannedSubjectCollection, int, QQueryOperations>
  subjectIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subjectId');
    });
  }
}
