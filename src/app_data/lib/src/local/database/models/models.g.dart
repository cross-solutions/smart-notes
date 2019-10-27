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
  final DateTime lastModified;
  TagDataObject(
      {@required this.id,
      this.ownedBy,
      @required this.name,
      @required this.created,
      this.lastModified});
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
      lastModified: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_modified']),
    );
  }
  factory TagDataObject.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return TagDataObject(
      id: serializer.fromJson<String>(json['id']),
      ownedBy: serializer.fromJson<String>(json['ownedBy']),
      name: serializer.fromJson<String>(json['name']),
      created: serializer.fromJson<DateTime>(json['created']),
      lastModified: serializer.fromJson<DateTime>(json['lastModified']),
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
      'lastModified': serializer.toJson<DateTime>(lastModified),
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
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
    );
  }

  TagDataObject copyWith(
          {String id,
          String ownedBy,
          String name,
          DateTime created,
          DateTime lastModified}) =>
      TagDataObject(
        id: id ?? this.id,
        ownedBy: ownedBy ?? this.ownedBy,
        name: name ?? this.name,
        created: created ?? this.created,
        lastModified: lastModified ?? this.lastModified,
      );
  @override
  String toString() {
    return (StringBuffer('TagDataObject(')
          ..write('id: $id, ')
          ..write('ownedBy: $ownedBy, ')
          ..write('name: $name, ')
          ..write('created: $created, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          ownedBy.hashCode,
          $mrjc(
              name.hashCode, $mrjc(created.hashCode, lastModified.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is TagDataObject &&
          other.id == this.id &&
          other.ownedBy == this.ownedBy &&
          other.name == this.name &&
          other.created == this.created &&
          other.lastModified == this.lastModified);
}

class TagsCompanion extends UpdateCompanion<TagDataObject> {
  final Value<String> id;
  final Value<String> ownedBy;
  final Value<String> name;
  final Value<DateTime> created;
  final Value<DateTime> lastModified;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.ownedBy = const Value.absent(),
    this.name = const Value.absent(),
    this.created = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  TagsCompanion.insert({
    @required String id,
    this.ownedBy = const Value.absent(),
    @required String name,
    @required DateTime created,
    this.lastModified = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        created = Value(created);
  TagsCompanion copyWith(
      {Value<String> id,
      Value<String> ownedBy,
      Value<String> name,
      Value<DateTime> created,
      Value<DateTime> lastModified}) {
    return TagsCompanion(
      id: id ?? this.id,
      ownedBy: ownedBy ?? this.ownedBy,
      name: name ?? this.name,
      created: created ?? this.created,
      lastModified: lastModified ?? this.lastModified,
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

  final VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  GeneratedDateTimeColumn _lastModified;
  @override
  GeneratedDateTimeColumn get lastModified =>
      _lastModified ??= _constructLastModified();
  GeneratedDateTimeColumn _constructLastModified() {
    return GeneratedDateTimeColumn(
      'last_modified',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, ownedBy, name, created, lastModified];
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
    if (d.lastModified.present) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableValue(
              d.lastModified.value, _lastModifiedMeta));
    } else if (lastModified.isRequired && isInserting) {
      context.missing(_lastModifiedMeta);
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
    if (d.lastModified.present) {
      map['last_modified'] =
          Variable<DateTime, DateTimeType>(d.lastModified.value);
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
  final String tagId;
  final DateTime created;
  final DateTime lastModified;
  NoteDataObject(
      {@required this.id,
      this.ownedBy,
      @required this.title,
      @required this.content,
      this.tagId,
      @required this.created,
      this.lastModified});
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
      tagId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
      created: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created']),
      lastModified: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_modified']),
    );
  }
  factory NoteDataObject.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return NoteDataObject(
      id: serializer.fromJson<String>(json['id']),
      ownedBy: serializer.fromJson<String>(json['ownedBy']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      tagId: serializer.fromJson<String>(json['tagId']),
      created: serializer.fromJson<DateTime>(json['created']),
      lastModified: serializer.fromJson<DateTime>(json['lastModified']),
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
      'tagId': serializer.toJson<String>(tagId),
      'created': serializer.toJson<DateTime>(created),
      'lastModified': serializer.toJson<DateTime>(lastModified),
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
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
      lastModified: lastModified == null && nullToAbsent
          ? const Value.absent()
          : Value(lastModified),
    );
  }

  NoteDataObject copyWith(
          {String id,
          String ownedBy,
          String title,
          String content,
          String tagId,
          DateTime created,
          DateTime lastModified}) =>
      NoteDataObject(
        id: id ?? this.id,
        ownedBy: ownedBy ?? this.ownedBy,
        title: title ?? this.title,
        content: content ?? this.content,
        tagId: tagId ?? this.tagId,
        created: created ?? this.created,
        lastModified: lastModified ?? this.lastModified,
      );
  @override
  String toString() {
    return (StringBuffer('NoteDataObject(')
          ..write('id: $id, ')
          ..write('ownedBy: $ownedBy, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('tagId: $tagId, ')
          ..write('created: $created, ')
          ..write('lastModified: $lastModified')
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
              $mrjc(
                  content.hashCode,
                  $mrjc(tagId.hashCode,
                      $mrjc(created.hashCode, lastModified.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is NoteDataObject &&
          other.id == this.id &&
          other.ownedBy == this.ownedBy &&
          other.title == this.title &&
          other.content == this.content &&
          other.tagId == this.tagId &&
          other.created == this.created &&
          other.lastModified == this.lastModified);
}

class NotesCompanion extends UpdateCompanion<NoteDataObject> {
  final Value<String> id;
  final Value<String> ownedBy;
  final Value<String> title;
  final Value<String> content;
  final Value<String> tagId;
  final Value<DateTime> created;
  final Value<DateTime> lastModified;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.ownedBy = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.tagId = const Value.absent(),
    this.created = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  NotesCompanion.insert({
    @required String id,
    this.ownedBy = const Value.absent(),
    @required String title,
    @required String content,
    this.tagId = const Value.absent(),
    @required DateTime created,
    this.lastModified = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        content = Value(content),
        created = Value(created);
  NotesCompanion copyWith(
      {Value<String> id,
      Value<String> ownedBy,
      Value<String> title,
      Value<String> content,
      Value<String> tagId,
      Value<DateTime> created,
      Value<DateTime> lastModified}) {
    return NotesCompanion(
      id: id ?? this.id,
      ownedBy: ownedBy ?? this.ownedBy,
      title: title ?? this.title,
      content: content ?? this.content,
      tagId: tagId ?? this.tagId,
      created: created ?? this.created,
      lastModified: lastModified ?? this.lastModified,
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

  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  GeneratedTextColumn _tagId;
  @override
  GeneratedTextColumn get tagId => _tagId ??= _constructTagId();
  GeneratedTextColumn _constructTagId() {
    return GeneratedTextColumn(
      'tag_id',
      $tableName,
      true,
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

  final VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  GeneratedDateTimeColumn _lastModified;
  @override
  GeneratedDateTimeColumn get lastModified =>
      _lastModified ??= _constructLastModified();
  GeneratedDateTimeColumn _constructLastModified() {
    return GeneratedDateTimeColumn(
      'last_modified',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, ownedBy, title, content, tagId, created, lastModified];
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
    if (d.tagId.present) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableValue(d.tagId.value, _tagIdMeta));
    } else if (tagId.isRequired && isInserting) {
      context.missing(_tagIdMeta);
    }
    if (d.created.present) {
      context.handle(_createdMeta,
          created.isAcceptableValue(d.created.value, _createdMeta));
    } else if (created.isRequired && isInserting) {
      context.missing(_createdMeta);
    }
    if (d.lastModified.present) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableValue(
              d.lastModified.value, _lastModifiedMeta));
    } else if (lastModified.isRequired && isInserting) {
      context.missing(_lastModifiedMeta);
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
    if (d.tagId.present) {
      map['tag_id'] = Variable<String, StringType>(d.tagId.value);
    }
    if (d.created.present) {
      map['created'] = Variable<DateTime, DateTimeType>(d.created.value);
    }
    if (d.lastModified.present) {
      map['last_modified'] =
          Variable<DateTime, DateTimeType>(d.lastModified.value);
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
