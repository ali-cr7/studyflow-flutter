// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_session_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStudySessionCollectionCollection on Isar {
  IsarCollection<StudySessionCollection> get studySessionCollections =>
      this.collection();
}

const StudySessionCollectionSchema = CollectionSchema(
  name: r'StudySessionCollection',
  id: -8993042713632026744,
  properties: {
    r'completed': PropertySchema(
      id: 0,
      name: r'completed',
      type: IsarType.bool,
    ),
    r'duration': PropertySchema(id: 1, name: r'duration', type: IsarType.long),
    r'endTime': PropertySchema(
      id: 2,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'notes': PropertySchema(id: 3, name: r'notes', type: IsarType.string),
    r'startTime': PropertySchema(
      id: 4,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'subjectId': PropertySchema(
      id: 5,
      name: r'subjectId',
      type: IsarType.long,
    ),
  },
  estimateSize: _studySessionCollectionEstimateSize,
  serialize: _studySessionCollectionSerialize,
  deserialize: _studySessionCollectionDeserialize,
  deserializeProp: _studySessionCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'subjectId': IndexSchema(
      id: 440306668014799972,
      name: r'subjectId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'subjectId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
    r'startTime': IndexSchema(
      id: -3870335341264752872,
      name: r'startTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'startTime',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _studySessionCollectionGetId,
  getLinks: _studySessionCollectionGetLinks,
  attach: _studySessionCollectionAttach,
  version: '3.1.0+1',
);

int _studySessionCollectionEstimateSize(
  StudySessionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _studySessionCollectionSerialize(
  StudySessionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.completed);
  writer.writeLong(offsets[1], object.duration);
  writer.writeDateTime(offsets[2], object.endTime);
  writer.writeString(offsets[3], object.notes);
  writer.writeDateTime(offsets[4], object.startTime);
  writer.writeLong(offsets[5], object.subjectId);
}

StudySessionCollection _studySessionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StudySessionCollection();
  object.completed = reader.readBool(offsets[0]);
  object.duration = reader.readLong(offsets[1]);
  object.endTime = reader.readDateTimeOrNull(offsets[2]);
  object.id = id;
  object.notes = reader.readStringOrNull(offsets[3]);
  object.startTime = reader.readDateTime(offsets[4]);
  object.subjectId = reader.readLong(offsets[5]);
  return object;
}

P _studySessionCollectionDeserializeProp<P>(
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _studySessionCollectionGetId(StudySessionCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _studySessionCollectionGetLinks(
  StudySessionCollection object,
) {
  return [];
}

void _studySessionCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  StudySessionCollection object,
) {
  object.id = id;
}

extension StudySessionCollectionQueryWhereSort
    on QueryBuilder<StudySessionCollection, StudySessionCollection, QWhere> {
  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterWhere>
  anySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'subjectId'),
      );
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterWhere>
  anyStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'startTime'),
      );
    });
  }
}

extension StudySessionCollectionQueryWhere
    on
        QueryBuilder<
          StudySessionCollection,
          StudySessionCollection,
          QWhereClause
        > {
  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  subjectIdEqualTo(int subjectId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'subjectId', value: [subjectId]),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  subjectIdNotEqualTo(int subjectId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'subjectId',
                lower: [],
                upper: [subjectId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'subjectId',
                lower: [subjectId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'subjectId',
                lower: [subjectId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'subjectId',
                lower: [],
                upper: [subjectId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  subjectIdGreaterThan(int subjectId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'subjectId',
          lower: [subjectId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  subjectIdLessThan(int subjectId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'subjectId',
          lower: [],
          upper: [subjectId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  subjectIdBetween(
    int lowerSubjectId,
    int upperSubjectId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'subjectId',
          lower: [lowerSubjectId],
          includeLower: includeLower,
          upper: [upperSubjectId],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  startTimeEqualTo(DateTime startTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'startTime', value: [startTime]),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  startTimeNotEqualTo(DateTime startTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'startTime',
                lower: [],
                upper: [startTime],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'startTime',
                lower: [startTime],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'startTime',
                lower: [startTime],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'startTime',
                lower: [],
                upper: [startTime],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  startTimeGreaterThan(DateTime startTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'startTime',
          lower: [startTime],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  startTimeLessThan(DateTime startTime, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'startTime',
          lower: [],
          upper: [startTime],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterWhereClause
  >
  startTimeBetween(
    DateTime lowerStartTime,
    DateTime upperStartTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'startTime',
          lower: [lowerStartTime],
          includeLower: includeLower,
          upper: [upperStartTime],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension StudySessionCollectionQueryFilter
    on
        QueryBuilder<
          StudySessionCollection,
          StudySessionCollection,
          QFilterCondition
        > {
  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  durationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'duration', value: value),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  durationGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'duration',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  durationLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'duration',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  durationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'duration',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  endTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endTime', value: value),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  endTimeGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  endTimeLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  endTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
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
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  startTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startTime', value: value),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  startTimeGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  startTimeLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
    QAfterFilterCondition
  >
  startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
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
    StudySessionCollection,
    StudySessionCollection,
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

extension StudySessionCollectionQueryObject
    on
        QueryBuilder<
          StudySessionCollection,
          StudySessionCollection,
          QFilterCondition
        > {}

extension StudySessionCollectionQueryLinks
    on
        QueryBuilder<
          StudySessionCollection,
          StudySessionCollection,
          QFilterCondition
        > {}

extension StudySessionCollectionQuerySortBy
    on QueryBuilder<StudySessionCollection, StudySessionCollection, QSortBy> {
  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  sortBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }
}

extension StudySessionCollectionQuerySortThenBy
    on
        QueryBuilder<
          StudySessionCollection,
          StudySessionCollection,
          QSortThenBy
        > {
  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completed', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QAfterSortBy>
  thenBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }
}

extension StudySessionCollectionQueryWhereDistinct
    on QueryBuilder<StudySessionCollection, StudySessionCollection, QDistinct> {
  QueryBuilder<StudySessionCollection, StudySessionCollection, QDistinct>
  distinctByCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completed');
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QDistinct>
  distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QDistinct>
  distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QDistinct>
  distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QDistinct>
  distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<StudySessionCollection, StudySessionCollection, QDistinct>
  distinctBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subjectId');
    });
  }
}

extension StudySessionCollectionQueryProperty
    on
        QueryBuilder<
          StudySessionCollection,
          StudySessionCollection,
          QQueryProperty
        > {
  QueryBuilder<StudySessionCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StudySessionCollection, bool, QQueryOperations>
  completedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completed');
    });
  }

  QueryBuilder<StudySessionCollection, int, QQueryOperations>
  durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<StudySessionCollection, DateTime?, QQueryOperations>
  endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<StudySessionCollection, String?, QQueryOperations>
  notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<StudySessionCollection, DateTime, QQueryOperations>
  startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<StudySessionCollection, int, QQueryOperations>
  subjectIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subjectId');
    });
  }
}
