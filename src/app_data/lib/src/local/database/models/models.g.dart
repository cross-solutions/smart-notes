// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TagDataObject extends DataClass implements Insertable<TagDataObject> {
  final String id;
  final String name;
  TagDataObject({@required this.id, @required this.name});
  factory TagDataObject.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return TagDataObject(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  factory TagDataObject.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TagDataObject(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  @override
  TagsCompanion createCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  TagDataObject copyWith({String id, String name}) => TagDataObject(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('TagDataObject(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is TagDataObject &&
          other.id == this.id &&
          other.name == this.name);
}

class TagsCompanion extends UpdateCompanion<TagDataObject> {
  final Value<String> id;
  final Value<String> name;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TagsCompanion.insert({
    @required String id,
    @required String name,
  })  : id = Value(id),
        name = Value(name);
  TagsCompanion copyWith({Value<String> id, Value<String> name}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, TagDataObject> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(TagsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagDataObject map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TagDataObject.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    return map;
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class AccountDataObject extends DataClass
    implements Insertable<AccountDataObject> {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  AccountDataObject(
      {@required this.id,
      @required this.name,
      @required this.email,
      @required this.imageUrl});
  factory AccountDataObject.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return AccountDataObject(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      imageUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_url']),
    );
  }
  factory AccountDataObject.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return AccountDataObject(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  @override
  AccountsCompanion createCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
    );
  }

  AccountDataObject copyWith(
          {String id, String name, String email, String imageUrl}) =>
      AccountDataObject(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
      );
  @override
  String toString() {
    return (StringBuffer('AccountDataObject(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(email.hashCode, imageUrl.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is AccountDataObject &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.imageUrl == this.imageUrl);
}

class AccountsCompanion extends UpdateCompanion<AccountDataObject> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> imageUrl;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  AccountsCompanion.insert({
    @required String id,
    @required String name,
    @required String email,
    @required String imageUrl,
  })  : id = Value(id),
        name = Value(name),
        email = Value(email),
        imageUrl = Value(imageUrl);
  AccountsCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> email,
      Value<String> imageUrl}) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class $AccountsTable extends Accounts
    with TableInfo<$AccountsTable, AccountDataObject> {
  final GeneratedDatabase _db;
  final String _alias;
  $AccountsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  GeneratedTextColumn _imageUrl;
  @override
  GeneratedTextColumn get imageUrl => _imageUrl ??= _constructImageUrl();
  GeneratedTextColumn _constructImageUrl() {
    return GeneratedTextColumn(
      'image_url',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, email, imageUrl];
  @override
  $AccountsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'accounts';
  @override
  final String actualTableName = 'accounts';
  @override
  VerificationContext validateIntegrity(AccountsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.email.present) {
      context.handle(
          _emailMeta, email.isAcceptableValue(d.email.value, _emailMeta));
    } else if (email.isRequired && isInserting) {
      context.missing(_emailMeta);
    }
    if (d.imageUrl.present) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableValue(d.imageUrl.value, _imageUrlMeta));
    } else if (imageUrl.isRequired && isInserting) {
      context.missing(_imageUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountDataObject map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AccountDataObject.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AccountsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.email.present) {
      map['email'] = Variable<String, StringType>(d.email.value);
    }
    if (d.imageUrl.present) {
      map['image_url'] = Variable<String, StringType>(d.imageUrl.value);
    }
    return map;
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(_db, alias);
  }
}

abstract class _$ENotesDatabase extends GeneratedDatabase {
  _$ENotesDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  $AccountsTable _accounts;
  $AccountsTable get accounts => _accounts ??= $AccountsTable(this);
  @override
  List<TableInfo> get allTables => [tags, accounts];
}
