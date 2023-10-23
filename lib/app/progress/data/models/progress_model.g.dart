// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProgressModelCollection on Isar {
  IsarCollection<ProgressModel> get progressModels => this.collection();
}

const ProgressModelSchema = CollectionSchema(
  name: r'ProgressModel',
  id: 4905906747576427883,
  properties: {
    r'doneActions': PropertySchema(
      id: 0,
      name: r'doneActions',
      type: IsarType.intList,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'totalActions': PropertySchema(
      id: 2,
      name: r'totalActions',
      type: IsarType.intList,
    )
  },
  estimateSize: _progressModelEstimateSize,
  serialize: _progressModelSerialize,
  deserialize: _progressModelDeserialize,
  deserializeProp: _progressModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _progressModelGetId,
  getLinks: _progressModelGetLinks,
  attach: _progressModelAttach,
  version: '3.1.0+1',
);

int _progressModelEstimateSize(
  ProgressModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.doneActions.length * 4;
  bytesCount += 3 + object.totalActions.length * 4;
  return bytesCount;
}

void _progressModelSerialize(
  ProgressModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeIntList(offsets[0], object.doneActions);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeIntList(offsets[2], object.totalActions);
}

ProgressModel _progressModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProgressModel(
    doneActions: reader.readIntList(offsets[0]) ?? const [],
    id: id,
    totalActions: reader.readIntList(offsets[2]) ?? const [],
  );
  return object;
}

P _progressModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readIntList(offset) ?? const []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readIntList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _progressModelGetId(ProgressModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _progressModelGetLinks(ProgressModel object) {
  return [];
}

void _progressModelAttach(
    IsarCollection<dynamic> col, Id id, ProgressModel object) {
  object.id = id;
}

extension ProgressModelQueryWhereSort
    on QueryBuilder<ProgressModel, ProgressModel, QWhere> {
  QueryBuilder<ProgressModel, ProgressModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProgressModelQueryWhere
    on QueryBuilder<ProgressModel, ProgressModel, QWhereClause> {
  QueryBuilder<ProgressModel, ProgressModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<ProgressModel, ProgressModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterWhereClause> idBetween(
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

extension ProgressModelQueryFilter
    on QueryBuilder<ProgressModel, ProgressModel, QFilterCondition> {
  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doneActions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'doneActions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'doneActions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'doneActions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'doneActions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'doneActions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'doneActions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'doneActions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'doneActions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      doneActionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'doneActions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalActions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalActions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalActions',
        value: value,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalActions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'totalActions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'totalActions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'totalActions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'totalActions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'totalActions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterFilterCondition>
      totalActionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'totalActions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ProgressModelQueryObject
    on QueryBuilder<ProgressModel, ProgressModel, QFilterCondition> {}

extension ProgressModelQueryLinks
    on QueryBuilder<ProgressModel, ProgressModel, QFilterCondition> {}

extension ProgressModelQuerySortBy
    on QueryBuilder<ProgressModel, ProgressModel, QSortBy> {
  QueryBuilder<ProgressModel, ProgressModel, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }
}

extension ProgressModelQuerySortThenBy
    on QueryBuilder<ProgressModel, ProgressModel, QSortThenBy> {
  QueryBuilder<ProgressModel, ProgressModel, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ProgressModelQueryWhereDistinct
    on QueryBuilder<ProgressModel, ProgressModel, QDistinct> {
  QueryBuilder<ProgressModel, ProgressModel, QDistinct>
      distinctByDoneActions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doneActions');
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<ProgressModel, ProgressModel, QDistinct>
      distinctByTotalActions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalActions');
    });
  }
}

extension ProgressModelQueryProperty
    on QueryBuilder<ProgressModel, ProgressModel, QQueryProperty> {
  QueryBuilder<ProgressModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProgressModel, List<int>, QQueryOperations>
      doneActionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doneActions');
    });
  }

  QueryBuilder<ProgressModel, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<ProgressModel, List<int>, QQueryOperations>
      totalActionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalActions');
    });
  }
}
