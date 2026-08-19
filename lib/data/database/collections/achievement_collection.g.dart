// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAchievementCollectionCollection on Isar {
  IsarCollection<AchievementCollection> get achievementCollections =>
      this.collection();
}

const AchievementCollectionSchema = CollectionSchema(
  name: r'AchievementCollection',
  id: -9107043524806984430,
  properties: {
    r'type': PropertySchema(
      id: 0,
      name: r'type',
      type: IsarType.string,
      enumMap: _AchievementCollectiontypeEnumValueMap,
    ),
    r'unlockedAt': PropertySchema(
      id: 1,
      name: r'unlockedAt',
      type: IsarType.dateTime,
    ),
  },
  estimateSize: _achievementCollectionEstimateSize,
  serialize: _achievementCollectionSerialize,
  deserialize: _achievementCollectionDeserialize,
  deserializeProp: _achievementCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'type': IndexSchema(
      id: 5117122708147080838,
      name: r'type',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'type',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _achievementCollectionGetId,
  getLinks: _achievementCollectionGetLinks,
  attach: _achievementCollectionAttach,
  version: '3.1.0+1',
);

int _achievementCollectionEstimateSize(
  AchievementCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _achievementCollectionSerialize(
  AchievementCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.type.name);
  writer.writeDateTime(offsets[1], object.unlockedAt);
}

AchievementCollection _achievementCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AchievementCollection();
  object.id = id;
  object.type =
      _AchievementCollectiontypeValueEnumMap[reader.readStringOrNull(
        offsets[0],
      )] ??
      AchievementType.firstSession;
  object.unlockedAt = reader.readDateTime(offsets[1]);
  return object;
}

P _achievementCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_AchievementCollectiontypeValueEnumMap[reader.readStringOrNull(
                offset,
              )] ??
              AchievementType.firstSession)
          as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AchievementCollectiontypeEnumValueMap = {
  r'firstSession': r'firstSession',
  r'streak3': r'streak3',
  r'streak7': r'streak7',
  r'streak30': r'streak30',
  r'dailyGoalMet': r'dailyGoalMet',
  r'tenSessions': r'tenSessions',
  r'fiftySessions': r'fiftySessions',
  r'hundredSessions': r'hundredSessions',
};
const _AchievementCollectiontypeValueEnumMap = {
  r'firstSession': AchievementType.firstSession,
  r'streak3': AchievementType.streak3,
  r'streak7': AchievementType.streak7,
  r'streak30': AchievementType.streak30,
  r'dailyGoalMet': AchievementType.dailyGoalMet,
  r'tenSessions': AchievementType.tenSessions,
  r'fiftySessions': AchievementType.fiftySessions,
  r'hundredSessions': AchievementType.hundredSessions,
};

Id _achievementCollectionGetId(AchievementCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _achievementCollectionGetLinks(
  AchievementCollection object,
) {
  return [];
}

void _achievementCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  AchievementCollection object,
) {
  object.id = id;
}

extension AchievementCollectionQueryWhereSort
    on QueryBuilder<AchievementCollection, AchievementCollection, QWhere> {
  QueryBuilder<AchievementCollection, AchievementCollection, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AchievementCollectionQueryWhere
    on
        QueryBuilder<
          AchievementCollection,
          AchievementCollection,
          QWhereClause
        > {
  QueryBuilder<AchievementCollection, AchievementCollection, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterWhereClause>
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

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterWhereClause>
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

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterWhereClause>
  typeEqualTo(AchievementType type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'type', value: [type]),
      );
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterWhereClause>
  typeNotEqualTo(AchievementType type) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'type',
                lower: [],
                upper: [type],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'type',
                lower: [type],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'type',
                lower: [type],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'type',
                lower: [],
                upper: [type],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension AchievementCollectionQueryFilter
    on
        QueryBuilder<
          AchievementCollection,
          AchievementCollection,
          QFilterCondition
        > {
  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
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
    AchievementCollection,
    AchievementCollection,
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
    AchievementCollection,
    AchievementCollection,
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
    AchievementCollection,
    AchievementCollection,
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
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeEqualTo(AchievementType value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeGreaterThan(
    AchievementType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeLessThan(
    AchievementType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeBetween(
    AchievementType lower,
    AchievementType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'type',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'type',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  unlockedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'unlockedAt', value: value),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  unlockedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'unlockedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  unlockedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'unlockedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    AchievementCollection,
    AchievementCollection,
    QAfterFilterCondition
  >
  unlockedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'unlockedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension AchievementCollectionQueryObject
    on
        QueryBuilder<
          AchievementCollection,
          AchievementCollection,
          QFilterCondition
        > {}

extension AchievementCollectionQueryLinks
    on
        QueryBuilder<
          AchievementCollection,
          AchievementCollection,
          QFilterCondition
        > {}

extension AchievementCollectionQuerySortBy
    on QueryBuilder<AchievementCollection, AchievementCollection, QSortBy> {
  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  sortByUnlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedAt', Sort.asc);
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  sortByUnlockedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedAt', Sort.desc);
    });
  }
}

extension AchievementCollectionQuerySortThenBy
    on QueryBuilder<AchievementCollection, AchievementCollection, QSortThenBy> {
  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  thenByUnlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedAt', Sort.asc);
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QAfterSortBy>
  thenByUnlockedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedAt', Sort.desc);
    });
  }
}

extension AchievementCollectionQueryWhereDistinct
    on QueryBuilder<AchievementCollection, AchievementCollection, QDistinct> {
  QueryBuilder<AchievementCollection, AchievementCollection, QDistinct>
  distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AchievementCollection, AchievementCollection, QDistinct>
  distinctByUnlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unlockedAt');
    });
  }
}

extension AchievementCollectionQueryProperty
    on
        QueryBuilder<
          AchievementCollection,
          AchievementCollection,
          QQueryProperty
        > {
  QueryBuilder<AchievementCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AchievementCollection, AchievementType, QQueryOperations>
  typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<AchievementCollection, DateTime, QQueryOperations>
  unlockedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unlockedAt');
    });
  }
}
