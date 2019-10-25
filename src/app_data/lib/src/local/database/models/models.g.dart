// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
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

class TagDataObject extends DataClass implements Insertable<TagDataObject> {
  final String id;
  final String ownedBy;
  final String name;
  final DateTime created;
  TagDataObject(
      {@required this.id,
      this.ownedBy,
      @required this.name,
      @required this.created});
  factory TagDataObject.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TagDataObject(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ownedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}owned_by']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      created: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created']),
    );
  }
  factory TagDataObject.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TagDataObject(
      id: serializer.fromJson<String>(json['id']),
      ownedBy: serializer.fromJson<String>(json['ownedBy']),
      name: serializer.fromJson<String>(json['name']),
      created: serializer.fromJson<DateTime>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'ownedBy': serializer.toJson<String>(ownedBy),
      'name': serializer.toJson<String>(name),
      'created': serializer.toJson<DateTime>(created),
    };
  }

  @override
  TagsCompanion createCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ownedBy: ownedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(ownedBy),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
    );
  }

  TagDataObject copyWith(
          {String id, String ownedBy, String name, DateTime created}) =>
      TagDataObject(
        id: id ?? this.id,
        ownedBy: ownedBy ?? this.ownedBy,
        name: name ?? this.name,
        created: created ?? this.created,
      );
  @override
  String toString() {
    return (StringBuffer('TagDataObject(')
          ..write('id: $id, ')
          ..write('ownedBy: $ownedBy, ')
          ..write('name: $name, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(ownedBy.hashCode, $mrjc(name.hashCode, created.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is TagDataObject &&
          other.id == this.id &&
          other.ownedBy == this.ownedBy &&
          other.name == this.name &&
          other.created == this.created);
}

class TagsCompanion extends UpdateCompanion<TagDataObject> {
  final Value<String> id;
  final Value<String> ownedBy;
  final Value<String> name;
  final Value<DateTime> created;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.ownedBy = const Value.absent(),
    this.name = const Value.absent(),
    this.created = const Value.absent(),
  });
  TagsCompanion.insert({
    @required String id,
    this.ownedBy = const Value.absent(),
    @required String name,
    @required DateTime created,
  })  : id = Value(id),
        name = Value(name),
        created = Value(created);
  TagsCompanion copyWith(
      {Value<String> id,
      Value<String> ownedBy,
      Value<String> name,
      Value<DateTime> created}) {
    return TagsCompanion(
      id: id ?? this.id,
      ownedBy: ownedBy ?? this.ownedBy,
      name: name ?? this.name,
      created: created ?? this.created,
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

  final VerificationMeta _ownedByMeta = const VerificationMeta('ownedBy');
  GeneratedTextColumn _ownedBy;
  @override
  GeneratedTextColumn get ownedBy => _ownedBy ??= _constructOwnedBy();
  GeneratedTextColumn _constructOwnedBy() {
    return GeneratedTextColumn(
      'owned_by',
      $tableName,
      true,
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

  final VerificationMeta _createdMeta = const VerificationMeta('created');
  GeneratedDateTimeColumn _created;
  @override
  GeneratedDateTimeColumn get created => _created ??= _constructCreated();
  GeneratedDateTimeColumn _constructCreated() {
    return GeneratedDateTimeColumn(
      'created',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, ownedBy, name, created];
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
    if (d.ownedBy.present) {
      context.handle(_ownedByMeta,
          ownedBy.isAcceptableValue(d.ownedBy.value, _ownedByMeta));
    } else if (ownedBy.isRequired && isInserting) {
      context.missing(_ownedByMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.created.present) {
      context.handle(_createdMeta,
          created.isAcceptableValue(d.created.value, _createdMeta));
    } else if (created.isRequired && isInserting) {
      context.missing(_createdMeta);
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
    if (d.ownedBy.present) {
      map['owned_by'] = Variable<String, StringType>(d.ownedBy.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.created.present) {
      map['created'] = Variable<DateTime, DateTimeType>(d.created.value);
    }
    return map;
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

class NoteDataObject extends DataClass implements Insertable<NoteDataObject> {
  final String id;
  final String ownedBy;
  final String title;
  final String content;
  final String categoryId;
  final DateTime lastmodified;
  NoteDataObject(
      {@required this.id,
      this.ownedBy,
      @required this.title,
      @required this.content,
      this.categoryId,
      @required this.lastmodified});
  factory NoteDataObject.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return NoteDataObject(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ownedBy: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}owned_by']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}content']),
      categoryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      lastmodified: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}lastmodified']),
    );
  }
  factory NoteDataObject.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return NoteDataObject(
      id: serializer.fromJson<String>(json['id']),
      ownedBy: serializer.fromJson<String>(json['ownedBy']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      lastmodified: serializer.fromJson<DateTime>(json['lastmodified']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'ownedBy': serializer.toJson<String>(ownedBy),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'categoryId': serializer.toJson<String>(categoryId),
      'lastmodified': serializer.toJson<DateTime>(lastmodified),
    };
  }

  @override
  NotesCompanion createCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ownedBy: ownedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(ownedBy),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      lastmodified: lastmodified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastmodified),
    );
  }

  NoteDataObject copyWith(
          {String id,
          String ownedBy,
          String title,
          String content,
          String categoryId,
          DateTime lastmodified}) =>
      NoteDataObject(
        id: id ?? this.id,
        ownedBy: ownedBy ?? this.ownedBy,
        title: title ?? this.title,
        content: content ?? this.content,
        categoryId: categoryId ?? this.categoryId,
        lastmodified: lastmodified ?? this.lastmodified,
      );
  @override
  String toString() {
    return (StringBuffer('NoteDataObject(')
          ..write('id: $id, ')
          ..write('ownedBy: $ownedBy, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('categoryId: $categoryId, ')
          ..write('lastmodified: $lastmodified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          ownedBy.hashCode,
          $mrjc(
              title.hashCode,
              $mrjc(content.hashCode,
                  $mrjc(categoryId.hashCode, lastmodified.hashCode))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is NoteDataObject &&
          other.id == this.id &&
          other.ownedBy == this.ownedBy &&
          other.title == this.title &&
          other.content == this.content &&
          other.categoryId == this.categoryId &&
          other.lastmodified == this.lastmodified);
}

class NotesCompanion extends UpdateCompanion<NoteDataObject> {
  final Value<String> id;
  final Value<String> ownedBy;
  final Value<String> title;
  final Value<String> content;
  final Value<String> categoryId;
  final Value<DateTime> lastmodified;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.ownedBy = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.lastmodified = const Value.absent(),
  });
  NotesCompanion.insert({
    @required String id,
    this.ownedBy = const Value.absent(),
    @required String title,
    @required String content,
    this.categoryId = const Value.absent(),
    @required DateTime lastmodified,
  })  : id = Value(id),
        title = Value(title),
        content = Value(content),
        lastmodified = Value(lastmodified);
  NotesCompanion copyWith(
      {Value<String> id,
      Value<String> ownedBy,
      Value<String> title,
      Value<String> content,
      Value<String> categoryId,
      Value<DateTime> lastmodified}) {
    return NotesCompanion(
      id: id ?? this.id,
      ownedBy: ownedBy ?? this.ownedBy,
      title: title ?? this.title,
      content: content ?? this.content,
      categoryId: categoryId ?? this.categoryId,
      lastmodified: lastmodified ?? this.lastmodified,
    );
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, NoteDataObject> {
  final GeneratedDatabase _db;
  final String _alias;
  $NotesTable(this._db, [this._alias]);
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

  final VerificationMeta _ownedByMeta = const VerificationMeta('ownedBy');
  GeneratedTextColumn _ownedBy;
  @override
  GeneratedTextColumn get ownedBy => _ownedBy ??= _constructOwnedBy();
  GeneratedTextColumn _constructOwnedBy() {
    return GeneratedTextColumn(
      'owned_by',
      $tableName,
      true,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;
  @override
  GeneratedTextColumn get content => _content ??= _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'content',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedTextColumn _categoryId;
  @override
  GeneratedTextColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedTextColumn _constructCategoryId() {
    return GeneratedTextColumn(
      'category_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _lastmodifiedMeta =
      const VerificationMeta('lastmodified');
  GeneratedDateTimeColumn _lastmodified;
  @override
  GeneratedDateTimeColumn get lastmodified =>
      _lastmodified ??= _constructLastmodified();
  GeneratedDateTimeColumn _constructLastmodified() {
    return GeneratedDateTimeColumn(
      'lastmodified',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, ownedBy, title, content, categoryId, lastmodified];
  @override
  $NotesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notes';
  @override
  final String actualTableName = 'notes';
  @override
  VerificationContext validateIntegrity(NotesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.ownedBy.present) {
      context.handle(_ownedByMeta,
          ownedBy.isAcceptableValue(d.ownedBy.value, _ownedByMeta));
    } else if (ownedBy.isRequired && isInserting) {
      context.missing(_ownedByMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.content.present) {
      context.handle(_contentMeta,
          content.isAcceptableValue(d.content.value, _contentMeta));
    } else if (content.isRequired && isInserting) {
      context.missing(_contentMeta);
    }
    if (d.categoryId.present) {
      context.handle(_categoryIdMeta,
          categoryId.isAcceptableValue(d.categoryId.value, _categoryIdMeta));
    } else if (categoryId.isRequired && isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (d.lastmodified.present) {
      context.handle(
          _lastmodifiedMeta,
          lastmodified.isAcceptableValue(
              d.lastmodified.value, _lastmodifiedMeta));
    } else if (lastmodified.isRequired && isInserting) {
      context.missing(_lastmodifiedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteDataObject map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return NoteDataObject.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NotesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.ownedBy.present) {
      map['owned_by'] = Variable<String, StringType>(d.ownedBy.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.content.present) {
      map['content'] = Variable<String, StringType>(d.content.value);
    }
    if (d.categoryId.present) {
      map['category_id'] = Variable<String, StringType>(d.categoryId.value);
    }
    if (d.lastmodified.present) {
      map['lastmodified'] =
          Variable<DateTime, DateTimeType>(d.lastmodified.value);
    }
    return map;
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

abstract class _$ENotesDatabase extends GeneratedDatabase {
  _$ENotesDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $AccountsTable _accounts;
  $AccountsTable get accounts => _accounts ??= $AccountsTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  @override
  List<TableInfo> get allTables => [accounts, tags, notes];
}
