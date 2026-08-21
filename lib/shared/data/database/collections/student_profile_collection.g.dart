// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStudentProfileCollectionCollection on Isar {
  IsarCollection<StudentProfileCollection> get studentProfileCollections =>
      this.collection();
}

const StudentProfileCollectionSchema = CollectionSchema(
  name: r'StudentProfileCollection',
  id: 3646505827184386584,
  properties: {
    r'dailyGoalMinutes': PropertySchema(
      id: 0,
      name: r'dailyGoalMinutes',
      type: IsarType.long,
    ),
    r'grade': PropertySchema(
      id: 1,
      name: r'grade',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'preferredSessionDuration': PropertySchema(
      id: 3,
      name: r'preferredSessionDuration',
      type: IsarType.long,
    ),
    r'sleepTime': PropertySchema(
      id: 4,
      name: r'sleepTime',
      type: IsarType.long,
    ),
    r'wakeUpTime': PropertySchema(
      id: 5,
      name: r'wakeUpTime',
      type: IsarType.long,
    )
  },
  estimateSize: _studentProfileCollectionEstimateSize,
  serialize: _studentProfileCollectionSerialize,
  deserialize: _studentProfileCollectionDeserialize,
  deserializeProp: _studentProfileCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _studentProfileCollectionGetId,
  getLinks: _studentProfileCollectionGetLinks,
  attach: _studentProfileCollectionAttach,
  version: '3.1.0+1',
);

int _studentProfileCollectionEstimateSize(
  StudentProfileCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.grade.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _studentProfileCollectionSerialize(
  StudentProfileCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.dailyGoalMinutes);
  writer.writeString(offsets[1], object.grade);
  writer.writeString(offsets[2], object.name);
  writer.writeLong(offsets[3], object.preferredSessionDuration);
  writer.writeLong(offsets[4], object.sleepTime);
  writer.writeLong(offsets[5], object.wakeUpTime);
}

StudentProfileCollection _studentProfileCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StudentProfileCollection();
  object.dailyGoalMinutes = reader.readLong(offsets[0]);
  object.grade = reader.readString(offsets[1]);
  object.id = id;
  object.name = reader.readString(offsets[2]);
  object.preferredSessionDuration = reader.readLong(offsets[3]);
  object.sleepTime = reader.readLong(offsets[4]);
  object.wakeUpTime = reader.readLong(offsets[5]);
  return object;
}

P _studentProfileCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
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

Id _studentProfileCollectionGetId(StudentProfileCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _studentProfileCollectionGetLinks(
    StudentProfileCollection object) {
  return [];
}

void _studentProfileCollectionAttach(
    IsarCollection<dynamic> col, Id id, StudentProfileCollection object) {
  object.id = id;
}

extension StudentProfileCollectionQueryWhereSort on QueryBuilder<
    StudentProfileCollection, StudentProfileCollection, QWhere> {
  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StudentProfileCollectionQueryWhere on QueryBuilder<
    StudentProfileCollection, StudentProfileCollection, QWhereClause> {
  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StudentProfileCollectionQueryFilter on QueryBuilder<
    StudentProfileCollection, StudentProfileCollection, QFilterCondition> {
  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> dailyGoalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> dailyGoalMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> dailyGoalMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> dailyGoalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyGoalMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> gradeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> gradeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> gradeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> gradeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grade',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> gradeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> gradeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
          QAfterFilterCondition>
      gradeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
          QAfterFilterCondition>
      gradeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'grade',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> gradeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grade',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> gradeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'grade',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> preferredSessionDurationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredSessionDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> preferredSessionDurationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preferredSessionDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> preferredSessionDurationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preferredSessionDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> preferredSessionDurationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preferredSessionDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> sleepTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sleepTime',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> sleepTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sleepTime',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> sleepTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sleepTime',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> sleepTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sleepTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> wakeUpTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wakeUpTime',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> wakeUpTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wakeUpTime',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> wakeUpTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wakeUpTime',
        value: value,
      ));
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection,
      QAfterFilterCondition> wakeUpTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wakeUpTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StudentProfileCollectionQueryObject on QueryBuilder<
    StudentProfileCollection, StudentProfileCollection, QFilterCondition> {}

extension StudentProfileCollectionQueryLinks on QueryBuilder<
    StudentProfileCollection, StudentProfileCollection, QFilterCondition> {}

extension StudentProfileCollectionQuerySortBy on QueryBuilder<
    StudentProfileCollection, StudentProfileCollection, QSortBy> {
  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByDailyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByDailyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByGrade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByGradeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByPreferredSessionDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredSessionDuration', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByPreferredSessionDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredSessionDuration', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortBySleepTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepTime', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortBySleepTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepTime', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByWakeUpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      sortByWakeUpTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.desc);
    });
  }
}

extension StudentProfileCollectionQuerySortThenBy on QueryBuilder<
    StudentProfileCollection, StudentProfileCollection, QSortThenBy> {
  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByDailyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByDailyGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByGrade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByGradeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByPreferredSessionDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredSessionDuration', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByPreferredSessionDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredSessionDuration', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenBySleepTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepTime', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenBySleepTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sleepTime', Sort.desc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByWakeUpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.asc);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QAfterSortBy>
      thenByWakeUpTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wakeUpTime', Sort.desc);
    });
  }
}

extension StudentProfileCollectionQueryWhereDistinct on QueryBuilder<
    StudentProfileCollection, StudentProfileCollection, QDistinct> {
  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QDistinct>
      distinctByDailyGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyGoalMinutes');
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QDistinct>
      distinctByGrade({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grade', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QDistinct>
      distinctByPreferredSessionDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preferredSessionDuration');
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QDistinct>
      distinctBySleepTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sleepTime');
    });
  }

  QueryBuilder<StudentProfileCollection, StudentProfileCollection, QDistinct>
      distinctByWakeUpTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wakeUpTime');
    });
  }
}

extension StudentProfileCollectionQueryProperty on QueryBuilder<
    StudentProfileCollection, StudentProfileCollection, QQueryProperty> {
  QueryBuilder<StudentProfileCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StudentProfileCollection, int, QQueryOperations>
      dailyGoalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyGoalMinutes');
    });
  }

  QueryBuilder<StudentProfileCollection, String, QQueryOperations>
      gradeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grade');
    });
  }

  QueryBuilder<StudentProfileCollection, String, QQueryOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<StudentProfileCollection, int, QQueryOperations>
      preferredSessionDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preferredSessionDuration');
    });
  }

  QueryBuilder<StudentProfileCollection, int, QQueryOperations>
      sleepTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sleepTime');
    });
  }

  QueryBuilder<StudentProfileCollection, int, QQueryOperations>
      wakeUpTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wakeUpTime');
    });
  }
}
