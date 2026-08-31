// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppSettingsCollectionCollection on Isar {
  IsarCollection<AppSettingsCollection> get appSettingsCollections =>
      this.collection();
}

const AppSettingsCollectionSchema = CollectionSchema(
  name: r'AppSettingsCollection',
  id: -1201272823460988305,
  properties: {
    r'breakDuration': PropertySchema(
      id: 0,
      name: r'breakDuration',
      type: IsarType.long,
    ),
    r'focusSound': PropertySchema(
      id: 1,
      name: r'focusSound',
      type: IsarType.string,
      enumMap: _AppSettingsCollectionfocusSoundEnumValueMap,
    ),
    r'language': PropertySchema(
      id: 2,
      name: r'language',
      type: IsarType.string,
      enumMap: _AppSettingsCollectionlanguageEnumValueMap,
    ),
    r'notificationsEnabled': PropertySchema(
      id: 3,
      name: r'notificationsEnabled',
      type: IsarType.bool,
    ),
    r'soundEnabled': PropertySchema(
      id: 4,
      name: r'soundEnabled',
      type: IsarType.bool,
    ),
    r'studyDuration': PropertySchema(
      id: 5,
      name: r'studyDuration',
      type: IsarType.long,
    ),
    r'theme': PropertySchema(
      id: 6,
      name: r'theme',
      type: IsarType.string,
      enumMap: _AppSettingsCollectionthemeEnumValueMap,
    )
  },
  estimateSize: _appSettingsCollectionEstimateSize,
  serialize: _appSettingsCollectionSerialize,
  deserialize: _appSettingsCollectionDeserialize,
  deserializeProp: _appSettingsCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appSettingsCollectionGetId,
  getLinks: _appSettingsCollectionGetLinks,
  attach: _appSettingsCollectionAttach,
  version: '3.1.0+1',
);

int _appSettingsCollectionEstimateSize(
  AppSettingsCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.focusSound.name.length * 3;
  bytesCount += 3 + object.language.name.length * 3;
  bytesCount += 3 + object.theme.name.length * 3;
  return bytesCount;
}

void _appSettingsCollectionSerialize(
  AppSettingsCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.breakDuration);
  writer.writeString(offsets[1], object.focusSound.name);
  writer.writeString(offsets[2], object.language.name);
  writer.writeBool(offsets[3], object.notificationsEnabled);
  writer.writeBool(offsets[4], object.soundEnabled);
  writer.writeLong(offsets[5], object.studyDuration);
  writer.writeString(offsets[6], object.theme.name);
}

AppSettingsCollection _appSettingsCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettingsCollection();
  object.breakDuration = reader.readLong(offsets[0]);
  object.focusSound = _AppSettingsCollectionfocusSoundValueEnumMap[
          reader.readStringOrNull(offsets[1])] ??
      FocusSoundMode.none;
  object.id = id;
  object.language = _AppSettingsCollectionlanguageValueEnumMap[
          reader.readStringOrNull(offsets[2])] ??
      AppLanguage.en;
  object.notificationsEnabled = reader.readBool(offsets[3]);
  object.soundEnabled = reader.readBool(offsets[4]);
  object.studyDuration = reader.readLong(offsets[5]);
  object.theme = _AppSettingsCollectionthemeValueEnumMap[
          reader.readStringOrNull(offsets[6])] ??
      AppThemeMode.system;
  return object;
}

P _appSettingsCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (_AppSettingsCollectionfocusSoundValueEnumMap[
              reader.readStringOrNull(offset)] ??
          FocusSoundMode.none) as P;
    case 2:
      return (_AppSettingsCollectionlanguageValueEnumMap[
              reader.readStringOrNull(offset)] ??
          AppLanguage.en) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (_AppSettingsCollectionthemeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          AppThemeMode.system) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AppSettingsCollectionfocusSoundEnumValueMap = {
  r'none': r'none',
  r'rain': r'rain',
  r'ocean': r'ocean',
  r'forest': r'forest',
  r'cafe': r'cafe',
};
const _AppSettingsCollectionfocusSoundValueEnumMap = {
  r'none': FocusSoundMode.none,
  r'rain': FocusSoundMode.rain,
  r'ocean': FocusSoundMode.ocean,
  r'forest': FocusSoundMode.forest,
  r'cafe': FocusSoundMode.cafe,
};
const _AppSettingsCollectionlanguageEnumValueMap = {
  r'en': r'en',
  r'ar': r'ar',
};
const _AppSettingsCollectionlanguageValueEnumMap = {
  r'en': AppLanguage.en,
  r'ar': AppLanguage.ar,
};
const _AppSettingsCollectionthemeEnumValueMap = {
  r'system': r'system',
  r'light': r'light',
  r'dark': r'dark',
};
const _AppSettingsCollectionthemeValueEnumMap = {
  r'system': AppThemeMode.system,
  r'light': AppThemeMode.light,
  r'dark': AppThemeMode.dark,
};

Id _appSettingsCollectionGetId(AppSettingsCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingsCollectionGetLinks(
    AppSettingsCollection object) {
  return [];
}

void _appSettingsCollectionAttach(
    IsarCollection<dynamic> col, Id id, AppSettingsCollection object) {
  object.id = id;
}

extension AppSettingsCollectionQueryWhereSort
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QWhere> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingsCollectionQueryWhere on QueryBuilder<AppSettingsCollection,
    AppSettingsCollection, QWhereClause> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
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

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idBetween(
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

extension AppSettingsCollectionQueryFilter on QueryBuilder<
    AppSettingsCollection, AppSettingsCollection, QFilterCondition> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> breakDurationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breakDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> breakDurationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breakDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> breakDurationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breakDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> breakDurationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breakDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> focusSoundEqualTo(
    FocusSoundMode value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'focusSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> focusSoundGreaterThan(
    FocusSoundMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'focusSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> focusSoundLessThan(
    FocusSoundMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'focusSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> focusSoundBetween(
    FocusSoundMode lower,
    FocusSoundMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'focusSound',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> focusSoundStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'focusSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> focusSoundEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'focusSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      focusSoundContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'focusSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      focusSoundMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'focusSound',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> focusSoundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'focusSound',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> focusSoundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'focusSound',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
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

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
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

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
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

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> languageEqualTo(
    AppLanguage value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> languageGreaterThan(
    AppLanguage value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> languageLessThan(
    AppLanguage value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> languageBetween(
    AppLanguage lower,
    AppLanguage upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'language',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> languageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> languageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      languageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      languageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'language',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> languageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> languageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> notificationsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationsEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> soundEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soundEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> studyDurationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studyDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> studyDurationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'studyDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> studyDurationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'studyDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> studyDurationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'studyDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themeEqualTo(
    AppThemeMode value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themeGreaterThan(
    AppThemeMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themeLessThan(
    AppThemeMode value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themeBetween(
    AppThemeMode lower,
    AppThemeMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'theme',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      themeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'theme',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      themeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'theme',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'theme',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> themeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'theme',
        value: '',
      ));
    });
  }
}

extension AppSettingsCollectionQueryObject on QueryBuilder<
    AppSettingsCollection, AppSettingsCollection, QFilterCondition> {}

extension AppSettingsCollectionQueryLinks on QueryBuilder<AppSettingsCollection,
    AppSettingsCollection, QFilterCondition> {}

extension AppSettingsCollectionQuerySortBy
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QSortBy> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByBreakDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakDuration', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByBreakDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakDuration', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByFocusSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusSound', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByFocusSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusSound', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortBySoundEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortBySoundEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByStudyDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyDuration', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByStudyDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyDuration', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }
}

extension AppSettingsCollectionQuerySortThenBy
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QSortThenBy> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByBreakDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakDuration', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByBreakDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakDuration', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByFocusSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusSound', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByFocusSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusSound', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenBySoundEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenBySoundEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByStudyDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyDuration', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByStudyDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyDuration', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'theme', Sort.desc);
    });
  }
}

extension AppSettingsCollectionQueryWhereDistinct
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByBreakDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breakDuration');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByFocusSound({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'focusSound', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByLanguage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'language', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationsEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctBySoundEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soundEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByStudyDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'studyDuration');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByTheme({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'theme', caseSensitive: caseSensitive);
    });
  }
}

extension AppSettingsCollectionQueryProperty on QueryBuilder<
    AppSettingsCollection, AppSettingsCollection, QQueryProperty> {
  QueryBuilder<AppSettingsCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettingsCollection, int, QQueryOperations>
      breakDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breakDuration');
    });
  }

  QueryBuilder<AppSettingsCollection, FocusSoundMode, QQueryOperations>
      focusSoundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'focusSound');
    });
  }

  QueryBuilder<AppSettingsCollection, AppLanguage, QQueryOperations>
      languageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'language');
    });
  }

  QueryBuilder<AppSettingsCollection, bool, QQueryOperations>
      notificationsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationsEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, bool, QQueryOperations>
      soundEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soundEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, int, QQueryOperations>
      studyDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'studyDuration');
    });
  }

  QueryBuilder<AppSettingsCollection, AppThemeMode, QQueryOperations>
      themeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'theme');
    });
  }
}
