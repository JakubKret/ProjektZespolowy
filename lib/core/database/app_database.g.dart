// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DonorProfileTableTable extends DonorProfileTable
    with TableInfo<$DonorProfileTableTable, DonorProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DonorProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bloodTypeMeta = const VerificationMeta(
    'bloodType',
  );
  @override
  late final GeneratedColumn<String> bloodType = GeneratedColumn<String>(
    'blood_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rhFactorMeta = const VerificationMeta(
    'rhFactor',
  );
  @override
  late final GeneratedColumn<String> rhFactor = GeneratedColumn<String>(
    'rh_factor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    birthDate,
    sex,
    bloodType,
    rhFactor,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'donor_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<DonorProfileTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('blood_type')) {
      context.handle(
        _bloodTypeMeta,
        bloodType.isAcceptableOrUnknown(data['blood_type']!, _bloodTypeMeta),
      );
    }
    if (data.containsKey('rh_factor')) {
      context.handle(
        _rhFactorMeta,
        rhFactor.isAcceptableOrUnknown(data['rh_factor']!, _rhFactorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DonorProfileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DonorProfileTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      bloodType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_type'],
      ),
      rhFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rh_factor'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DonorProfileTableTable createAlias(String alias) {
    return $DonorProfileTableTable(attachedDatabase, alias);
  }
}

class DonorProfileTableData extends DataClass
    implements Insertable<DonorProfileTableData> {
  final int id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String sex;
  final String? bloodType;
  final String? rhFactor;
  final DateTime createdAt;
  const DonorProfileTableData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.sex,
    this.bloodType,
    this.rhFactor,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['birth_date'] = Variable<DateTime>(birthDate);
    map['sex'] = Variable<String>(sex);
    if (!nullToAbsent || bloodType != null) {
      map['blood_type'] = Variable<String>(bloodType);
    }
    if (!nullToAbsent || rhFactor != null) {
      map['rh_factor'] = Variable<String>(rhFactor);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DonorProfileTableCompanion toCompanion(bool nullToAbsent) {
    return DonorProfileTableCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      birthDate: Value(birthDate),
      sex: Value(sex),
      bloodType: bloodType == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodType),
      rhFactor: rhFactor == null && nullToAbsent
          ? const Value.absent()
          : Value(rhFactor),
      createdAt: Value(createdAt),
    );
  }

  factory DonorProfileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DonorProfileTableData(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      birthDate: serializer.fromJson<DateTime>(json['birthDate']),
      sex: serializer.fromJson<String>(json['sex']),
      bloodType: serializer.fromJson<String?>(json['bloodType']),
      rhFactor: serializer.fromJson<String?>(json['rhFactor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'birthDate': serializer.toJson<DateTime>(birthDate),
      'sex': serializer.toJson<String>(sex),
      'bloodType': serializer.toJson<String?>(bloodType),
      'rhFactor': serializer.toJson<String?>(rhFactor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DonorProfileTableData copyWith({
    int? id,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    String? sex,
    Value<String?> bloodType = const Value.absent(),
    Value<String?> rhFactor = const Value.absent(),
    DateTime? createdAt,
  }) => DonorProfileTableData(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    birthDate: birthDate ?? this.birthDate,
    sex: sex ?? this.sex,
    bloodType: bloodType.present ? bloodType.value : this.bloodType,
    rhFactor: rhFactor.present ? rhFactor.value : this.rhFactor,
    createdAt: createdAt ?? this.createdAt,
  );
  DonorProfileTableData copyWithCompanion(DonorProfileTableCompanion data) {
    return DonorProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      sex: data.sex.present ? data.sex.value : this.sex,
      bloodType: data.bloodType.present ? data.bloodType.value : this.bloodType,
      rhFactor: data.rhFactor.present ? data.rhFactor.value : this.rhFactor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DonorProfileTableData(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('birthDate: $birthDate, ')
          ..write('sex: $sex, ')
          ..write('bloodType: $bloodType, ')
          ..write('rhFactor: $rhFactor, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firstName,
    lastName,
    birthDate,
    sex,
    bloodType,
    rhFactor,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DonorProfileTableData &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.birthDate == this.birthDate &&
          other.sex == this.sex &&
          other.bloodType == this.bloodType &&
          other.rhFactor == this.rhFactor &&
          other.createdAt == this.createdAt);
}

class DonorProfileTableCompanion
    extends UpdateCompanion<DonorProfileTableData> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<DateTime> birthDate;
  final Value<String> sex;
  final Value<String?> bloodType;
  final Value<String?> rhFactor;
  final Value<DateTime> createdAt;
  const DonorProfileTableCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.sex = const Value.absent(),
    this.bloodType = const Value.absent(),
    this.rhFactor = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DonorProfileTableCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String sex,
    this.bloodType = const Value.absent(),
    this.rhFactor = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       birthDate = Value(birthDate),
       sex = Value(sex);
  static Insertable<DonorProfileTableData> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<DateTime>? birthDate,
    Expression<String>? sex,
    Expression<String>? bloodType,
    Expression<String>? rhFactor,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (birthDate != null) 'birth_date': birthDate,
      if (sex != null) 'sex': sex,
      if (bloodType != null) 'blood_type': bloodType,
      if (rhFactor != null) 'rh_factor': rhFactor,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DonorProfileTableCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<DateTime>? birthDate,
    Value<String>? sex,
    Value<String?>? bloodType,
    Value<String?>? rhFactor,
    Value<DateTime>? createdAt,
  }) {
    return DonorProfileTableCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      bloodType: bloodType ?? this.bloodType,
      rhFactor: rhFactor ?? this.rhFactor,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (bloodType.present) {
      map['blood_type'] = Variable<String>(bloodType.value);
    }
    if (rhFactor.present) {
      map['rh_factor'] = Variable<String>(rhFactor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DonorProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('birthDate: $birthDate, ')
          ..write('sex: $sex, ')
          ..write('bloodType: $bloodType, ')
          ..write('rhFactor: $rhFactor, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DonationsTableTable extends DonationsTable
    with TableInfo<$DonationsTableTable, DonationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DonationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _donorProfileIdMeta = const VerificationMeta(
    'donorProfileId',
  );
  @override
  late final GeneratedColumn<int> donorProfileId = GeneratedColumn<int>(
    'donor_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bloodCenterIdMeta = const VerificationMeta(
    'bloodCenterId',
  );
  @override
  late final GeneratedColumn<int> bloodCenterId = GeneratedColumn<int>(
    'blood_center_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _donationTypeMeta = const VerificationMeta(
    'donationType',
  );
  @override
  late final GeneratedColumn<String> donationType = GeneratedColumn<String>(
    'donation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _donationDateMeta = const VerificationMeta(
    'donationDate',
  );
  @override
  late final GeneratedColumn<DateTime> donationDate = GeneratedColumn<DateTime>(
    'donation_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeMlMeta = const VerificationMeta(
    'volumeMl',
  );
  @override
  late final GeneratedColumn<int> volumeMl = GeneratedColumn<int>(
    'volume_ml',
    aliasedName,
    false,
    check: () => ComparableExpr(volumeMl).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRejectedMeta = const VerificationMeta(
    'isRejected',
  );
  @override
  late final GeneratedColumn<bool> isRejected = GeneratedColumn<bool>(
    'is_rejected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_rejected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _rejectionReasonMeta = const VerificationMeta(
    'rejectionReason',
  );
  @override
  late final GeneratedColumn<String> rejectionReason = GeneratedColumn<String>(
    'rejection_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    donorProfileId,
    bloodCenterId,
    donationType,
    donationDate,
    volumeMl,
    isRejected,
    rejectionReason,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'donations';
  @override
  VerificationContext validateIntegrity(
    Insertable<DonationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('donor_profile_id')) {
      context.handle(
        _donorProfileIdMeta,
        donorProfileId.isAcceptableOrUnknown(
          data['donor_profile_id']!,
          _donorProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_donorProfileIdMeta);
    }
    if (data.containsKey('blood_center_id')) {
      context.handle(
        _bloodCenterIdMeta,
        bloodCenterId.isAcceptableOrUnknown(
          data['blood_center_id']!,
          _bloodCenterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bloodCenterIdMeta);
    }
    if (data.containsKey('donation_type')) {
      context.handle(
        _donationTypeMeta,
        donationType.isAcceptableOrUnknown(
          data['donation_type']!,
          _donationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_donationTypeMeta);
    }
    if (data.containsKey('donation_date')) {
      context.handle(
        _donationDateMeta,
        donationDate.isAcceptableOrUnknown(
          data['donation_date']!,
          _donationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_donationDateMeta);
    }
    if (data.containsKey('volume_ml')) {
      context.handle(
        _volumeMlMeta,
        volumeMl.isAcceptableOrUnknown(data['volume_ml']!, _volumeMlMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeMlMeta);
    }
    if (data.containsKey('is_rejected')) {
      context.handle(
        _isRejectedMeta,
        isRejected.isAcceptableOrUnknown(data['is_rejected']!, _isRejectedMeta),
      );
    }
    if (data.containsKey('rejection_reason')) {
      context.handle(
        _rejectionReasonMeta,
        rejectionReason.isAcceptableOrUnknown(
          data['rejection_reason']!,
          _rejectionReasonMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DonationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DonationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      donorProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}donor_profile_id'],
      )!,
      bloodCenterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}blood_center_id'],
      )!,
      donationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}donation_type'],
      )!,
      donationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}donation_date'],
      )!,
      volumeMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume_ml'],
      )!,
      isRejected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_rejected'],
      )!,
      rejectionReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rejection_reason'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DonationsTableTable createAlias(String alias) {
    return $DonationsTableTable(attachedDatabase, alias);
  }
}

class DonationsTableData extends DataClass
    implements Insertable<DonationsTableData> {
  final int id;
  final int donorProfileId;
  final int bloodCenterId;
  final String donationType;
  final DateTime donationDate;
  final int volumeMl;
  final bool isRejected;
  final String? rejectionReason;
  final String? notes;
  final DateTime createdAt;
  const DonationsTableData({
    required this.id,
    required this.donorProfileId,
    required this.bloodCenterId,
    required this.donationType,
    required this.donationDate,
    required this.volumeMl,
    required this.isRejected,
    this.rejectionReason,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['donor_profile_id'] = Variable<int>(donorProfileId);
    map['blood_center_id'] = Variable<int>(bloodCenterId);
    map['donation_type'] = Variable<String>(donationType);
    map['donation_date'] = Variable<DateTime>(donationDate);
    map['volume_ml'] = Variable<int>(volumeMl);
    map['is_rejected'] = Variable<bool>(isRejected);
    if (!nullToAbsent || rejectionReason != null) {
      map['rejection_reason'] = Variable<String>(rejectionReason);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DonationsTableCompanion toCompanion(bool nullToAbsent) {
    return DonationsTableCompanion(
      id: Value(id),
      donorProfileId: Value(donorProfileId),
      bloodCenterId: Value(bloodCenterId),
      donationType: Value(donationType),
      donationDate: Value(donationDate),
      volumeMl: Value(volumeMl),
      isRejected: Value(isRejected),
      rejectionReason: rejectionReason == null && nullToAbsent
          ? const Value.absent()
          : Value(rejectionReason),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory DonationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DonationsTableData(
      id: serializer.fromJson<int>(json['id']),
      donorProfileId: serializer.fromJson<int>(json['donorProfileId']),
      bloodCenterId: serializer.fromJson<int>(json['bloodCenterId']),
      donationType: serializer.fromJson<String>(json['donationType']),
      donationDate: serializer.fromJson<DateTime>(json['donationDate']),
      volumeMl: serializer.fromJson<int>(json['volumeMl']),
      isRejected: serializer.fromJson<bool>(json['isRejected']),
      rejectionReason: serializer.fromJson<String?>(json['rejectionReason']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'donorProfileId': serializer.toJson<int>(donorProfileId),
      'bloodCenterId': serializer.toJson<int>(bloodCenterId),
      'donationType': serializer.toJson<String>(donationType),
      'donationDate': serializer.toJson<DateTime>(donationDate),
      'volumeMl': serializer.toJson<int>(volumeMl),
      'isRejected': serializer.toJson<bool>(isRejected),
      'rejectionReason': serializer.toJson<String?>(rejectionReason),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DonationsTableData copyWith({
    int? id,
    int? donorProfileId,
    int? bloodCenterId,
    String? donationType,
    DateTime? donationDate,
    int? volumeMl,
    bool? isRejected,
    Value<String?> rejectionReason = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => DonationsTableData(
    id: id ?? this.id,
    donorProfileId: donorProfileId ?? this.donorProfileId,
    bloodCenterId: bloodCenterId ?? this.bloodCenterId,
    donationType: donationType ?? this.donationType,
    donationDate: donationDate ?? this.donationDate,
    volumeMl: volumeMl ?? this.volumeMl,
    isRejected: isRejected ?? this.isRejected,
    rejectionReason: rejectionReason.present
        ? rejectionReason.value
        : this.rejectionReason,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  DonationsTableData copyWithCompanion(DonationsTableCompanion data) {
    return DonationsTableData(
      id: data.id.present ? data.id.value : this.id,
      donorProfileId: data.donorProfileId.present
          ? data.donorProfileId.value
          : this.donorProfileId,
      bloodCenterId: data.bloodCenterId.present
          ? data.bloodCenterId.value
          : this.bloodCenterId,
      donationType: data.donationType.present
          ? data.donationType.value
          : this.donationType,
      donationDate: data.donationDate.present
          ? data.donationDate.value
          : this.donationDate,
      volumeMl: data.volumeMl.present ? data.volumeMl.value : this.volumeMl,
      isRejected: data.isRejected.present
          ? data.isRejected.value
          : this.isRejected,
      rejectionReason: data.rejectionReason.present
          ? data.rejectionReason.value
          : this.rejectionReason,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DonationsTableData(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('bloodCenterId: $bloodCenterId, ')
          ..write('donationType: $donationType, ')
          ..write('donationDate: $donationDate, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('isRejected: $isRejected, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    donorProfileId,
    bloodCenterId,
    donationType,
    donationDate,
    volumeMl,
    isRejected,
    rejectionReason,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DonationsTableData &&
          other.id == this.id &&
          other.donorProfileId == this.donorProfileId &&
          other.bloodCenterId == this.bloodCenterId &&
          other.donationType == this.donationType &&
          other.donationDate == this.donationDate &&
          other.volumeMl == this.volumeMl &&
          other.isRejected == this.isRejected &&
          other.rejectionReason == this.rejectionReason &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class DonationsTableCompanion extends UpdateCompanion<DonationsTableData> {
  final Value<int> id;
  final Value<int> donorProfileId;
  final Value<int> bloodCenterId;
  final Value<String> donationType;
  final Value<DateTime> donationDate;
  final Value<int> volumeMl;
  final Value<bool> isRejected;
  final Value<String?> rejectionReason;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const DonationsTableCompanion({
    this.id = const Value.absent(),
    this.donorProfileId = const Value.absent(),
    this.bloodCenterId = const Value.absent(),
    this.donationType = const Value.absent(),
    this.donationDate = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.isRejected = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DonationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int donorProfileId,
    required int bloodCenterId,
    required String donationType,
    required DateTime donationDate,
    required int volumeMl,
    this.isRejected = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : donorProfileId = Value(donorProfileId),
       bloodCenterId = Value(bloodCenterId),
       donationType = Value(donationType),
       donationDate = Value(donationDate),
       volumeMl = Value(volumeMl);
  static Insertable<DonationsTableData> custom({
    Expression<int>? id,
    Expression<int>? donorProfileId,
    Expression<int>? bloodCenterId,
    Expression<String>? donationType,
    Expression<DateTime>? donationDate,
    Expression<int>? volumeMl,
    Expression<bool>? isRejected,
    Expression<String>? rejectionReason,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (donorProfileId != null) 'donor_profile_id': donorProfileId,
      if (bloodCenterId != null) 'blood_center_id': bloodCenterId,
      if (donationType != null) 'donation_type': donationType,
      if (donationDate != null) 'donation_date': donationDate,
      if (volumeMl != null) 'volume_ml': volumeMl,
      if (isRejected != null) 'is_rejected': isRejected,
      if (rejectionReason != null) 'rejection_reason': rejectionReason,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DonationsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? donorProfileId,
    Value<int>? bloodCenterId,
    Value<String>? donationType,
    Value<DateTime>? donationDate,
    Value<int>? volumeMl,
    Value<bool>? isRejected,
    Value<String?>? rejectionReason,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return DonationsTableCompanion(
      id: id ?? this.id,
      donorProfileId: donorProfileId ?? this.donorProfileId,
      bloodCenterId: bloodCenterId ?? this.bloodCenterId,
      donationType: donationType ?? this.donationType,
      donationDate: donationDate ?? this.donationDate,
      volumeMl: volumeMl ?? this.volumeMl,
      isRejected: isRejected ?? this.isRejected,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (donorProfileId.present) {
      map['donor_profile_id'] = Variable<int>(donorProfileId.value);
    }
    if (bloodCenterId.present) {
      map['blood_center_id'] = Variable<int>(bloodCenterId.value);
    }
    if (donationType.present) {
      map['donation_type'] = Variable<String>(donationType.value);
    }
    if (donationDate.present) {
      map['donation_date'] = Variable<DateTime>(donationDate.value);
    }
    if (volumeMl.present) {
      map['volume_ml'] = Variable<int>(volumeMl.value);
    }
    if (isRejected.present) {
      map['is_rejected'] = Variable<bool>(isRejected.value);
    }
    if (rejectionReason.present) {
      map['rejection_reason'] = Variable<String>(rejectionReason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DonationsTableCompanion(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('bloodCenterId: $bloodCenterId, ')
          ..write('donationType: $donationType, ')
          ..write('donationDate: $donationDate, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('isRejected: $isRejected, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MenstrualCyclesTableTable extends MenstrualCyclesTable
    with TableInfo<$MenstrualCyclesTableTable, MenstrualCyclesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenstrualCyclesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _donorProfileIdMeta = const VerificationMeta(
    'donorProfileId',
  );
  @override
  late final GeneratedColumn<int> donorProfileId = GeneratedColumn<int>(
    'donor_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    donorProfileId,
    startDate,
    endDate,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menstrual_cycles';
  @override
  VerificationContext validateIntegrity(
    Insertable<MenstrualCyclesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('donor_profile_id')) {
      context.handle(
        _donorProfileIdMeta,
        donorProfileId.isAcceptableOrUnknown(
          data['donor_profile_id']!,
          _donorProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_donorProfileIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenstrualCyclesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenstrualCyclesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      donorProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}donor_profile_id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MenstrualCyclesTableTable createAlias(String alias) {
    return $MenstrualCyclesTableTable(attachedDatabase, alias);
  }
}

class MenstrualCyclesTableData extends DataClass
    implements Insertable<MenstrualCyclesTableData> {
  final int id;
  final int donorProfileId;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final DateTime createdAt;
  const MenstrualCyclesTableData({
    required this.id,
    required this.donorProfileId,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['donor_profile_id'] = Variable<int>(donorProfileId);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MenstrualCyclesTableCompanion toCompanion(bool nullToAbsent) {
    return MenstrualCyclesTableCompanion(
      id: Value(id),
      donorProfileId: Value(donorProfileId),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory MenstrualCyclesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenstrualCyclesTableData(
      id: serializer.fromJson<int>(json['id']),
      donorProfileId: serializer.fromJson<int>(json['donorProfileId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'donorProfileId': serializer.toJson<int>(donorProfileId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MenstrualCyclesTableData copyWith({
    int? id,
    int? donorProfileId,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
  }) => MenstrualCyclesTableData(
    id: id ?? this.id,
    donorProfileId: donorProfileId ?? this.donorProfileId,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  MenstrualCyclesTableData copyWithCompanion(
    MenstrualCyclesTableCompanion data,
  ) {
    return MenstrualCyclesTableData(
      id: data.id.present ? data.id.value : this.id,
      donorProfileId: data.donorProfileId.present
          ? data.donorProfileId.value
          : this.donorProfileId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenstrualCyclesTableData(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, donorProfileId, startDate, endDate, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenstrualCyclesTableData &&
          other.id == this.id &&
          other.donorProfileId == this.donorProfileId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class MenstrualCyclesTableCompanion
    extends UpdateCompanion<MenstrualCyclesTableData> {
  final Value<int> id;
  final Value<int> donorProfileId;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const MenstrualCyclesTableCompanion({
    this.id = const Value.absent(),
    this.donorProfileId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MenstrualCyclesTableCompanion.insert({
    this.id = const Value.absent(),
    required int donorProfileId,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : donorProfileId = Value(donorProfileId),
       startDate = Value(startDate);
  static Insertable<MenstrualCyclesTableData> custom({
    Expression<int>? id,
    Expression<int>? donorProfileId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (donorProfileId != null) 'donor_profile_id': donorProfileId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MenstrualCyclesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? donorProfileId,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return MenstrualCyclesTableCompanion(
      id: id ?? this.id,
      donorProfileId: donorProfileId ?? this.donorProfileId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (donorProfileId.present) {
      map['donor_profile_id'] = Variable<int>(donorProfileId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenstrualCyclesTableCompanion(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MorphologyResultsTableTable extends MorphologyResultsTable
    with TableInfo<$MorphologyResultsTableTable, MorphologyResultsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MorphologyResultsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _donorIdMeta = const VerificationMeta(
    'donorId',
  );
  @override
  late final GeneratedColumn<int> donorId = GeneratedColumn<int>(
    'donor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _donationIdMeta = const VerificationMeta(
    'donationId',
  );
  @override
  late final GeneratedColumn<int> donationId = GeneratedColumn<int>(
    'donation_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultDateMeta = const VerificationMeta(
    'resultDate',
  );
  @override
  late final GeneratedColumn<DateTime> resultDate = GeneratedColumn<DateTime>(
    'result_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ocrConfidenceMeta = const VerificationMeta(
    'ocrConfidence',
  );
  @override
  late final GeneratedColumn<double> ocrConfidence = GeneratedColumn<double>(
    'ocr_confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hgbGDlMeta = const VerificationMeta('hgbGDl');
  @override
  late final GeneratedColumn<double> hgbGDl = GeneratedColumn<double>(
    'hgb_g_dl',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hctPctMeta = const VerificationMeta('hctPct');
  @override
  late final GeneratedColumn<double> hctPct = GeneratedColumn<double>(
    'hct_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rbcMlnUlMeta = const VerificationMeta(
    'rbcMlnUl',
  );
  @override
  late final GeneratedColumn<double> rbcMlnUl = GeneratedColumn<double>(
    'rbc_mln_ul',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mcvFlMeta = const VerificationMeta('mcvFl');
  @override
  late final GeneratedColumn<double> mcvFl = GeneratedColumn<double>(
    'mcv_fl',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mchPgMeta = const VerificationMeta('mchPg');
  @override
  late final GeneratedColumn<double> mchPg = GeneratedColumn<double>(
    'mch_pg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mchcGDlMeta = const VerificationMeta(
    'mchcGDl',
  );
  @override
  late final GeneratedColumn<double> mchcGDl = GeneratedColumn<double>(
    'mchc_g_dl',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rdwPctMeta = const VerificationMeta('rdwPct');
  @override
  late final GeneratedColumn<double> rdwPct = GeneratedColumn<double>(
    'rdw_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wbcTysUlMeta = const VerificationMeta(
    'wbcTysUl',
  );
  @override
  late final GeneratedColumn<double> wbcTysUl = GeneratedColumn<double>(
    'wbc_tys_ul',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _neutPctMeta = const VerificationMeta(
    'neutPct',
  );
  @override
  late final GeneratedColumn<double> neutPct = GeneratedColumn<double>(
    'neut_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lymphPctMeta = const VerificationMeta(
    'lymphPct',
  );
  @override
  late final GeneratedColumn<double> lymphPct = GeneratedColumn<double>(
    'lymph_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monoPctMeta = const VerificationMeta(
    'monoPct',
  );
  @override
  late final GeneratedColumn<double> monoPct = GeneratedColumn<double>(
    'mono_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _eosPctMeta = const VerificationMeta('eosPct');
  @override
  late final GeneratedColumn<double> eosPct = GeneratedColumn<double>(
    'eos_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _basoPctMeta = const VerificationMeta(
    'basoPct',
  );
  @override
  late final GeneratedColumn<double> basoPct = GeneratedColumn<double>(
    'baso_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pltTysUlMeta = const VerificationMeta(
    'pltTysUl',
  );
  @override
  late final GeneratedColumn<double> pltTysUl = GeneratedColumn<double>(
    'plt_tys_ul',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mpvFlMeta = const VerificationMeta('mpvFl');
  @override
  late final GeneratedColumn<double> mpvFl = GeneratedColumn<double>(
    'mpv_fl',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feUgDlMeta = const VerificationMeta('feUgDl');
  @override
  late final GeneratedColumn<double> feUgDl = GeneratedColumn<double>(
    'fe_ug_dl',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ferritinNgMlMeta = const VerificationMeta(
    'ferritinNgMl',
  );
  @override
  late final GeneratedColumn<double> ferritinNgMl = GeneratedColumn<double>(
    'ferritin_ng_ml',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labNameMeta = const VerificationMeta(
    'labName',
  );
  @override
  late final GeneratedColumn<String> labName = GeneratedColumn<String>(
    'lab_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    donorId,
    donationId,
    resultDate,
    imagePath,
    ocrConfidence,
    isVerified,
    hgbGDl,
    hctPct,
    rbcMlnUl,
    mcvFl,
    mchPg,
    mchcGDl,
    rdwPct,
    wbcTysUl,
    neutPct,
    lymphPct,
    monoPct,
    eosPct,
    basoPct,
    pltTysUl,
    mpvFl,
    feUgDl,
    ferritinNgMl,
    labName,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'morphology_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<MorphologyResultsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('donor_id')) {
      context.handle(
        _donorIdMeta,
        donorId.isAcceptableOrUnknown(data['donor_id']!, _donorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_donorIdMeta);
    }
    if (data.containsKey('donation_id')) {
      context.handle(
        _donationIdMeta,
        donationId.isAcceptableOrUnknown(data['donation_id']!, _donationIdMeta),
      );
    }
    if (data.containsKey('result_date')) {
      context.handle(
        _resultDateMeta,
        resultDate.isAcceptableOrUnknown(data['result_date']!, _resultDateMeta),
      );
    } else if (isInserting) {
      context.missing(_resultDateMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('ocr_confidence')) {
      context.handle(
        _ocrConfidenceMeta,
        ocrConfidence.isAcceptableOrUnknown(
          data['ocr_confidence']!,
          _ocrConfidenceMeta,
        ),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('hgb_g_dl')) {
      context.handle(
        _hgbGDlMeta,
        hgbGDl.isAcceptableOrUnknown(data['hgb_g_dl']!, _hgbGDlMeta),
      );
    }
    if (data.containsKey('hct_pct')) {
      context.handle(
        _hctPctMeta,
        hctPct.isAcceptableOrUnknown(data['hct_pct']!, _hctPctMeta),
      );
    }
    if (data.containsKey('rbc_mln_ul')) {
      context.handle(
        _rbcMlnUlMeta,
        rbcMlnUl.isAcceptableOrUnknown(data['rbc_mln_ul']!, _rbcMlnUlMeta),
      );
    }
    if (data.containsKey('mcv_fl')) {
      context.handle(
        _mcvFlMeta,
        mcvFl.isAcceptableOrUnknown(data['mcv_fl']!, _mcvFlMeta),
      );
    }
    if (data.containsKey('mch_pg')) {
      context.handle(
        _mchPgMeta,
        mchPg.isAcceptableOrUnknown(data['mch_pg']!, _mchPgMeta),
      );
    }
    if (data.containsKey('mchc_g_dl')) {
      context.handle(
        _mchcGDlMeta,
        mchcGDl.isAcceptableOrUnknown(data['mchc_g_dl']!, _mchcGDlMeta),
      );
    }
    if (data.containsKey('rdw_pct')) {
      context.handle(
        _rdwPctMeta,
        rdwPct.isAcceptableOrUnknown(data['rdw_pct']!, _rdwPctMeta),
      );
    }
    if (data.containsKey('wbc_tys_ul')) {
      context.handle(
        _wbcTysUlMeta,
        wbcTysUl.isAcceptableOrUnknown(data['wbc_tys_ul']!, _wbcTysUlMeta),
      );
    }
    if (data.containsKey('neut_pct')) {
      context.handle(
        _neutPctMeta,
        neutPct.isAcceptableOrUnknown(data['neut_pct']!, _neutPctMeta),
      );
    }
    if (data.containsKey('lymph_pct')) {
      context.handle(
        _lymphPctMeta,
        lymphPct.isAcceptableOrUnknown(data['lymph_pct']!, _lymphPctMeta),
      );
    }
    if (data.containsKey('mono_pct')) {
      context.handle(
        _monoPctMeta,
        monoPct.isAcceptableOrUnknown(data['mono_pct']!, _monoPctMeta),
      );
    }
    if (data.containsKey('eos_pct')) {
      context.handle(
        _eosPctMeta,
        eosPct.isAcceptableOrUnknown(data['eos_pct']!, _eosPctMeta),
      );
    }
    if (data.containsKey('baso_pct')) {
      context.handle(
        _basoPctMeta,
        basoPct.isAcceptableOrUnknown(data['baso_pct']!, _basoPctMeta),
      );
    }
    if (data.containsKey('plt_tys_ul')) {
      context.handle(
        _pltTysUlMeta,
        pltTysUl.isAcceptableOrUnknown(data['plt_tys_ul']!, _pltTysUlMeta),
      );
    }
    if (data.containsKey('mpv_fl')) {
      context.handle(
        _mpvFlMeta,
        mpvFl.isAcceptableOrUnknown(data['mpv_fl']!, _mpvFlMeta),
      );
    }
    if (data.containsKey('fe_ug_dl')) {
      context.handle(
        _feUgDlMeta,
        feUgDl.isAcceptableOrUnknown(data['fe_ug_dl']!, _feUgDlMeta),
      );
    }
    if (data.containsKey('ferritin_ng_ml')) {
      context.handle(
        _ferritinNgMlMeta,
        ferritinNgMl.isAcceptableOrUnknown(
          data['ferritin_ng_ml']!,
          _ferritinNgMlMeta,
        ),
      );
    }
    if (data.containsKey('lab_name')) {
      context.handle(
        _labNameMeta,
        labName.isAcceptableOrUnknown(data['lab_name']!, _labNameMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MorphologyResultsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MorphologyResultsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      donorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}donor_id'],
      )!,
      donationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}donation_id'],
      ),
      resultDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}result_date'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      ocrConfidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ocr_confidence'],
      ),
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      hgbGDl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hgb_g_dl'],
      ),
      hctPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hct_pct'],
      ),
      rbcMlnUl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rbc_mln_ul'],
      ),
      mcvFl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mcv_fl'],
      ),
      mchPg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mch_pg'],
      ),
      mchcGDl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mchc_g_dl'],
      ),
      rdwPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rdw_pct'],
      ),
      wbcTysUl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wbc_tys_ul'],
      ),
      neutPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}neut_pct'],
      ),
      lymphPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lymph_pct'],
      ),
      monoPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mono_pct'],
      ),
      eosPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}eos_pct'],
      ),
      basoPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}baso_pct'],
      ),
      pltTysUl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}plt_tys_ul'],
      ),
      mpvFl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mpv_fl'],
      ),
      feUgDl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fe_ug_dl'],
      ),
      ferritinNgMl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ferritin_ng_ml'],
      ),
      labName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lab_name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MorphologyResultsTableTable createAlias(String alias) {
    return $MorphologyResultsTableTable(attachedDatabase, alias);
  }
}

class MorphologyResultsTableData extends DataClass
    implements Insertable<MorphologyResultsTableData> {
  final int id;
  final int donorId;
  final int? donationId;
  final DateTime resultDate;
  final String? imagePath;
  final double? ocrConfidence;
  final bool isVerified;
  final double? hgbGDl;
  final double? hctPct;
  final double? rbcMlnUl;
  final double? mcvFl;
  final double? mchPg;
  final double? mchcGDl;
  final double? rdwPct;
  final double? wbcTysUl;
  final double? neutPct;
  final double? lymphPct;
  final double? monoPct;
  final double? eosPct;
  final double? basoPct;
  final double? pltTysUl;
  final double? mpvFl;
  final double? feUgDl;
  final double? ferritinNgMl;
  final String? labName;
  final DateTime createdAt;
  const MorphologyResultsTableData({
    required this.id,
    required this.donorId,
    this.donationId,
    required this.resultDate,
    this.imagePath,
    this.ocrConfidence,
    required this.isVerified,
    this.hgbGDl,
    this.hctPct,
    this.rbcMlnUl,
    this.mcvFl,
    this.mchPg,
    this.mchcGDl,
    this.rdwPct,
    this.wbcTysUl,
    this.neutPct,
    this.lymphPct,
    this.monoPct,
    this.eosPct,
    this.basoPct,
    this.pltTysUl,
    this.mpvFl,
    this.feUgDl,
    this.ferritinNgMl,
    this.labName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['donor_id'] = Variable<int>(donorId);
    if (!nullToAbsent || donationId != null) {
      map['donation_id'] = Variable<int>(donationId);
    }
    map['result_date'] = Variable<DateTime>(resultDate);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || ocrConfidence != null) {
      map['ocr_confidence'] = Variable<double>(ocrConfidence);
    }
    map['is_verified'] = Variable<bool>(isVerified);
    if (!nullToAbsent || hgbGDl != null) {
      map['hgb_g_dl'] = Variable<double>(hgbGDl);
    }
    if (!nullToAbsent || hctPct != null) {
      map['hct_pct'] = Variable<double>(hctPct);
    }
    if (!nullToAbsent || rbcMlnUl != null) {
      map['rbc_mln_ul'] = Variable<double>(rbcMlnUl);
    }
    if (!nullToAbsent || mcvFl != null) {
      map['mcv_fl'] = Variable<double>(mcvFl);
    }
    if (!nullToAbsent || mchPg != null) {
      map['mch_pg'] = Variable<double>(mchPg);
    }
    if (!nullToAbsent || mchcGDl != null) {
      map['mchc_g_dl'] = Variable<double>(mchcGDl);
    }
    if (!nullToAbsent || rdwPct != null) {
      map['rdw_pct'] = Variable<double>(rdwPct);
    }
    if (!nullToAbsent || wbcTysUl != null) {
      map['wbc_tys_ul'] = Variable<double>(wbcTysUl);
    }
    if (!nullToAbsent || neutPct != null) {
      map['neut_pct'] = Variable<double>(neutPct);
    }
    if (!nullToAbsent || lymphPct != null) {
      map['lymph_pct'] = Variable<double>(lymphPct);
    }
    if (!nullToAbsent || monoPct != null) {
      map['mono_pct'] = Variable<double>(monoPct);
    }
    if (!nullToAbsent || eosPct != null) {
      map['eos_pct'] = Variable<double>(eosPct);
    }
    if (!nullToAbsent || basoPct != null) {
      map['baso_pct'] = Variable<double>(basoPct);
    }
    if (!nullToAbsent || pltTysUl != null) {
      map['plt_tys_ul'] = Variable<double>(pltTysUl);
    }
    if (!nullToAbsent || mpvFl != null) {
      map['mpv_fl'] = Variable<double>(mpvFl);
    }
    if (!nullToAbsent || feUgDl != null) {
      map['fe_ug_dl'] = Variable<double>(feUgDl);
    }
    if (!nullToAbsent || ferritinNgMl != null) {
      map['ferritin_ng_ml'] = Variable<double>(ferritinNgMl);
    }
    if (!nullToAbsent || labName != null) {
      map['lab_name'] = Variable<String>(labName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MorphologyResultsTableCompanion toCompanion(bool nullToAbsent) {
    return MorphologyResultsTableCompanion(
      id: Value(id),
      donorId: Value(donorId),
      donationId: donationId == null && nullToAbsent
          ? const Value.absent()
          : Value(donationId),
      resultDate: Value(resultDate),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      ocrConfidence: ocrConfidence == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrConfidence),
      isVerified: Value(isVerified),
      hgbGDl: hgbGDl == null && nullToAbsent
          ? const Value.absent()
          : Value(hgbGDl),
      hctPct: hctPct == null && nullToAbsent
          ? const Value.absent()
          : Value(hctPct),
      rbcMlnUl: rbcMlnUl == null && nullToAbsent
          ? const Value.absent()
          : Value(rbcMlnUl),
      mcvFl: mcvFl == null && nullToAbsent
          ? const Value.absent()
          : Value(mcvFl),
      mchPg: mchPg == null && nullToAbsent
          ? const Value.absent()
          : Value(mchPg),
      mchcGDl: mchcGDl == null && nullToAbsent
          ? const Value.absent()
          : Value(mchcGDl),
      rdwPct: rdwPct == null && nullToAbsent
          ? const Value.absent()
          : Value(rdwPct),
      wbcTysUl: wbcTysUl == null && nullToAbsent
          ? const Value.absent()
          : Value(wbcTysUl),
      neutPct: neutPct == null && nullToAbsent
          ? const Value.absent()
          : Value(neutPct),
      lymphPct: lymphPct == null && nullToAbsent
          ? const Value.absent()
          : Value(lymphPct),
      monoPct: monoPct == null && nullToAbsent
          ? const Value.absent()
          : Value(monoPct),
      eosPct: eosPct == null && nullToAbsent
          ? const Value.absent()
          : Value(eosPct),
      basoPct: basoPct == null && nullToAbsent
          ? const Value.absent()
          : Value(basoPct),
      pltTysUl: pltTysUl == null && nullToAbsent
          ? const Value.absent()
          : Value(pltTysUl),
      mpvFl: mpvFl == null && nullToAbsent
          ? const Value.absent()
          : Value(mpvFl),
      feUgDl: feUgDl == null && nullToAbsent
          ? const Value.absent()
          : Value(feUgDl),
      ferritinNgMl: ferritinNgMl == null && nullToAbsent
          ? const Value.absent()
          : Value(ferritinNgMl),
      labName: labName == null && nullToAbsent
          ? const Value.absent()
          : Value(labName),
      createdAt: Value(createdAt),
    );
  }

  factory MorphologyResultsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MorphologyResultsTableData(
      id: serializer.fromJson<int>(json['id']),
      donorId: serializer.fromJson<int>(json['donorId']),
      donationId: serializer.fromJson<int?>(json['donationId']),
      resultDate: serializer.fromJson<DateTime>(json['resultDate']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      ocrConfidence: serializer.fromJson<double?>(json['ocrConfidence']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      hgbGDl: serializer.fromJson<double?>(json['hgbGDl']),
      hctPct: serializer.fromJson<double?>(json['hctPct']),
      rbcMlnUl: serializer.fromJson<double?>(json['rbcMlnUl']),
      mcvFl: serializer.fromJson<double?>(json['mcvFl']),
      mchPg: serializer.fromJson<double?>(json['mchPg']),
      mchcGDl: serializer.fromJson<double?>(json['mchcGDl']),
      rdwPct: serializer.fromJson<double?>(json['rdwPct']),
      wbcTysUl: serializer.fromJson<double?>(json['wbcTysUl']),
      neutPct: serializer.fromJson<double?>(json['neutPct']),
      lymphPct: serializer.fromJson<double?>(json['lymphPct']),
      monoPct: serializer.fromJson<double?>(json['monoPct']),
      eosPct: serializer.fromJson<double?>(json['eosPct']),
      basoPct: serializer.fromJson<double?>(json['basoPct']),
      pltTysUl: serializer.fromJson<double?>(json['pltTysUl']),
      mpvFl: serializer.fromJson<double?>(json['mpvFl']),
      feUgDl: serializer.fromJson<double?>(json['feUgDl']),
      ferritinNgMl: serializer.fromJson<double?>(json['ferritinNgMl']),
      labName: serializer.fromJson<String?>(json['labName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'donorId': serializer.toJson<int>(donorId),
      'donationId': serializer.toJson<int?>(donationId),
      'resultDate': serializer.toJson<DateTime>(resultDate),
      'imagePath': serializer.toJson<String?>(imagePath),
      'ocrConfidence': serializer.toJson<double?>(ocrConfidence),
      'isVerified': serializer.toJson<bool>(isVerified),
      'hgbGDl': serializer.toJson<double?>(hgbGDl),
      'hctPct': serializer.toJson<double?>(hctPct),
      'rbcMlnUl': serializer.toJson<double?>(rbcMlnUl),
      'mcvFl': serializer.toJson<double?>(mcvFl),
      'mchPg': serializer.toJson<double?>(mchPg),
      'mchcGDl': serializer.toJson<double?>(mchcGDl),
      'rdwPct': serializer.toJson<double?>(rdwPct),
      'wbcTysUl': serializer.toJson<double?>(wbcTysUl),
      'neutPct': serializer.toJson<double?>(neutPct),
      'lymphPct': serializer.toJson<double?>(lymphPct),
      'monoPct': serializer.toJson<double?>(monoPct),
      'eosPct': serializer.toJson<double?>(eosPct),
      'basoPct': serializer.toJson<double?>(basoPct),
      'pltTysUl': serializer.toJson<double?>(pltTysUl),
      'mpvFl': serializer.toJson<double?>(mpvFl),
      'feUgDl': serializer.toJson<double?>(feUgDl),
      'ferritinNgMl': serializer.toJson<double?>(ferritinNgMl),
      'labName': serializer.toJson<String?>(labName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MorphologyResultsTableData copyWith({
    int? id,
    int? donorId,
    Value<int?> donationId = const Value.absent(),
    DateTime? resultDate,
    Value<String?> imagePath = const Value.absent(),
    Value<double?> ocrConfidence = const Value.absent(),
    bool? isVerified,
    Value<double?> hgbGDl = const Value.absent(),
    Value<double?> hctPct = const Value.absent(),
    Value<double?> rbcMlnUl = const Value.absent(),
    Value<double?> mcvFl = const Value.absent(),
    Value<double?> mchPg = const Value.absent(),
    Value<double?> mchcGDl = const Value.absent(),
    Value<double?> rdwPct = const Value.absent(),
    Value<double?> wbcTysUl = const Value.absent(),
    Value<double?> neutPct = const Value.absent(),
    Value<double?> lymphPct = const Value.absent(),
    Value<double?> monoPct = const Value.absent(),
    Value<double?> eosPct = const Value.absent(),
    Value<double?> basoPct = const Value.absent(),
    Value<double?> pltTysUl = const Value.absent(),
    Value<double?> mpvFl = const Value.absent(),
    Value<double?> feUgDl = const Value.absent(),
    Value<double?> ferritinNgMl = const Value.absent(),
    Value<String?> labName = const Value.absent(),
    DateTime? createdAt,
  }) => MorphologyResultsTableData(
    id: id ?? this.id,
    donorId: donorId ?? this.donorId,
    donationId: donationId.present ? donationId.value : this.donationId,
    resultDate: resultDate ?? this.resultDate,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    ocrConfidence: ocrConfidence.present
        ? ocrConfidence.value
        : this.ocrConfidence,
    isVerified: isVerified ?? this.isVerified,
    hgbGDl: hgbGDl.present ? hgbGDl.value : this.hgbGDl,
    hctPct: hctPct.present ? hctPct.value : this.hctPct,
    rbcMlnUl: rbcMlnUl.present ? rbcMlnUl.value : this.rbcMlnUl,
    mcvFl: mcvFl.present ? mcvFl.value : this.mcvFl,
    mchPg: mchPg.present ? mchPg.value : this.mchPg,
    mchcGDl: mchcGDl.present ? mchcGDl.value : this.mchcGDl,
    rdwPct: rdwPct.present ? rdwPct.value : this.rdwPct,
    wbcTysUl: wbcTysUl.present ? wbcTysUl.value : this.wbcTysUl,
    neutPct: neutPct.present ? neutPct.value : this.neutPct,
    lymphPct: lymphPct.present ? lymphPct.value : this.lymphPct,
    monoPct: monoPct.present ? monoPct.value : this.monoPct,
    eosPct: eosPct.present ? eosPct.value : this.eosPct,
    basoPct: basoPct.present ? basoPct.value : this.basoPct,
    pltTysUl: pltTysUl.present ? pltTysUl.value : this.pltTysUl,
    mpvFl: mpvFl.present ? mpvFl.value : this.mpvFl,
    feUgDl: feUgDl.present ? feUgDl.value : this.feUgDl,
    ferritinNgMl: ferritinNgMl.present ? ferritinNgMl.value : this.ferritinNgMl,
    labName: labName.present ? labName.value : this.labName,
    createdAt: createdAt ?? this.createdAt,
  );
  MorphologyResultsTableData copyWithCompanion(
    MorphologyResultsTableCompanion data,
  ) {
    return MorphologyResultsTableData(
      id: data.id.present ? data.id.value : this.id,
      donorId: data.donorId.present ? data.donorId.value : this.donorId,
      donationId: data.donationId.present
          ? data.donationId.value
          : this.donationId,
      resultDate: data.resultDate.present
          ? data.resultDate.value
          : this.resultDate,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      ocrConfidence: data.ocrConfidence.present
          ? data.ocrConfidence.value
          : this.ocrConfidence,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      hgbGDl: data.hgbGDl.present ? data.hgbGDl.value : this.hgbGDl,
      hctPct: data.hctPct.present ? data.hctPct.value : this.hctPct,
      rbcMlnUl: data.rbcMlnUl.present ? data.rbcMlnUl.value : this.rbcMlnUl,
      mcvFl: data.mcvFl.present ? data.mcvFl.value : this.mcvFl,
      mchPg: data.mchPg.present ? data.mchPg.value : this.mchPg,
      mchcGDl: data.mchcGDl.present ? data.mchcGDl.value : this.mchcGDl,
      rdwPct: data.rdwPct.present ? data.rdwPct.value : this.rdwPct,
      wbcTysUl: data.wbcTysUl.present ? data.wbcTysUl.value : this.wbcTysUl,
      neutPct: data.neutPct.present ? data.neutPct.value : this.neutPct,
      lymphPct: data.lymphPct.present ? data.lymphPct.value : this.lymphPct,
      monoPct: data.monoPct.present ? data.monoPct.value : this.monoPct,
      eosPct: data.eosPct.present ? data.eosPct.value : this.eosPct,
      basoPct: data.basoPct.present ? data.basoPct.value : this.basoPct,
      pltTysUl: data.pltTysUl.present ? data.pltTysUl.value : this.pltTysUl,
      mpvFl: data.mpvFl.present ? data.mpvFl.value : this.mpvFl,
      feUgDl: data.feUgDl.present ? data.feUgDl.value : this.feUgDl,
      ferritinNgMl: data.ferritinNgMl.present
          ? data.ferritinNgMl.value
          : this.ferritinNgMl,
      labName: data.labName.present ? data.labName.value : this.labName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MorphologyResultsTableData(')
          ..write('id: $id, ')
          ..write('donorId: $donorId, ')
          ..write('donationId: $donationId, ')
          ..write('resultDate: $resultDate, ')
          ..write('imagePath: $imagePath, ')
          ..write('ocrConfidence: $ocrConfidence, ')
          ..write('isVerified: $isVerified, ')
          ..write('hgbGDl: $hgbGDl, ')
          ..write('hctPct: $hctPct, ')
          ..write('rbcMlnUl: $rbcMlnUl, ')
          ..write('mcvFl: $mcvFl, ')
          ..write('mchPg: $mchPg, ')
          ..write('mchcGDl: $mchcGDl, ')
          ..write('rdwPct: $rdwPct, ')
          ..write('wbcTysUl: $wbcTysUl, ')
          ..write('neutPct: $neutPct, ')
          ..write('lymphPct: $lymphPct, ')
          ..write('monoPct: $monoPct, ')
          ..write('eosPct: $eosPct, ')
          ..write('basoPct: $basoPct, ')
          ..write('pltTysUl: $pltTysUl, ')
          ..write('mpvFl: $mpvFl, ')
          ..write('feUgDl: $feUgDl, ')
          ..write('ferritinNgMl: $ferritinNgMl, ')
          ..write('labName: $labName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    donorId,
    donationId,
    resultDate,
    imagePath,
    ocrConfidence,
    isVerified,
    hgbGDl,
    hctPct,
    rbcMlnUl,
    mcvFl,
    mchPg,
    mchcGDl,
    rdwPct,
    wbcTysUl,
    neutPct,
    lymphPct,
    monoPct,
    eosPct,
    basoPct,
    pltTysUl,
    mpvFl,
    feUgDl,
    ferritinNgMl,
    labName,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MorphologyResultsTableData &&
          other.id == this.id &&
          other.donorId == this.donorId &&
          other.donationId == this.donationId &&
          other.resultDate == this.resultDate &&
          other.imagePath == this.imagePath &&
          other.ocrConfidence == this.ocrConfidence &&
          other.isVerified == this.isVerified &&
          other.hgbGDl == this.hgbGDl &&
          other.hctPct == this.hctPct &&
          other.rbcMlnUl == this.rbcMlnUl &&
          other.mcvFl == this.mcvFl &&
          other.mchPg == this.mchPg &&
          other.mchcGDl == this.mchcGDl &&
          other.rdwPct == this.rdwPct &&
          other.wbcTysUl == this.wbcTysUl &&
          other.neutPct == this.neutPct &&
          other.lymphPct == this.lymphPct &&
          other.monoPct == this.monoPct &&
          other.eosPct == this.eosPct &&
          other.basoPct == this.basoPct &&
          other.pltTysUl == this.pltTysUl &&
          other.mpvFl == this.mpvFl &&
          other.feUgDl == this.feUgDl &&
          other.ferritinNgMl == this.ferritinNgMl &&
          other.labName == this.labName &&
          other.createdAt == this.createdAt);
}

class MorphologyResultsTableCompanion
    extends UpdateCompanion<MorphologyResultsTableData> {
  final Value<int> id;
  final Value<int> donorId;
  final Value<int?> donationId;
  final Value<DateTime> resultDate;
  final Value<String?> imagePath;
  final Value<double?> ocrConfidence;
  final Value<bool> isVerified;
  final Value<double?> hgbGDl;
  final Value<double?> hctPct;
  final Value<double?> rbcMlnUl;
  final Value<double?> mcvFl;
  final Value<double?> mchPg;
  final Value<double?> mchcGDl;
  final Value<double?> rdwPct;
  final Value<double?> wbcTysUl;
  final Value<double?> neutPct;
  final Value<double?> lymphPct;
  final Value<double?> monoPct;
  final Value<double?> eosPct;
  final Value<double?> basoPct;
  final Value<double?> pltTysUl;
  final Value<double?> mpvFl;
  final Value<double?> feUgDl;
  final Value<double?> ferritinNgMl;
  final Value<String?> labName;
  final Value<DateTime> createdAt;
  const MorphologyResultsTableCompanion({
    this.id = const Value.absent(),
    this.donorId = const Value.absent(),
    this.donationId = const Value.absent(),
    this.resultDate = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.ocrConfidence = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.hgbGDl = const Value.absent(),
    this.hctPct = const Value.absent(),
    this.rbcMlnUl = const Value.absent(),
    this.mcvFl = const Value.absent(),
    this.mchPg = const Value.absent(),
    this.mchcGDl = const Value.absent(),
    this.rdwPct = const Value.absent(),
    this.wbcTysUl = const Value.absent(),
    this.neutPct = const Value.absent(),
    this.lymphPct = const Value.absent(),
    this.monoPct = const Value.absent(),
    this.eosPct = const Value.absent(),
    this.basoPct = const Value.absent(),
    this.pltTysUl = const Value.absent(),
    this.mpvFl = const Value.absent(),
    this.feUgDl = const Value.absent(),
    this.ferritinNgMl = const Value.absent(),
    this.labName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MorphologyResultsTableCompanion.insert({
    this.id = const Value.absent(),
    required int donorId,
    this.donationId = const Value.absent(),
    required DateTime resultDate,
    this.imagePath = const Value.absent(),
    this.ocrConfidence = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.hgbGDl = const Value.absent(),
    this.hctPct = const Value.absent(),
    this.rbcMlnUl = const Value.absent(),
    this.mcvFl = const Value.absent(),
    this.mchPg = const Value.absent(),
    this.mchcGDl = const Value.absent(),
    this.rdwPct = const Value.absent(),
    this.wbcTysUl = const Value.absent(),
    this.neutPct = const Value.absent(),
    this.lymphPct = const Value.absent(),
    this.monoPct = const Value.absent(),
    this.eosPct = const Value.absent(),
    this.basoPct = const Value.absent(),
    this.pltTysUl = const Value.absent(),
    this.mpvFl = const Value.absent(),
    this.feUgDl = const Value.absent(),
    this.ferritinNgMl = const Value.absent(),
    this.labName = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : donorId = Value(donorId),
       resultDate = Value(resultDate);
  static Insertable<MorphologyResultsTableData> custom({
    Expression<int>? id,
    Expression<int>? donorId,
    Expression<int>? donationId,
    Expression<DateTime>? resultDate,
    Expression<String>? imagePath,
    Expression<double>? ocrConfidence,
    Expression<bool>? isVerified,
    Expression<double>? hgbGDl,
    Expression<double>? hctPct,
    Expression<double>? rbcMlnUl,
    Expression<double>? mcvFl,
    Expression<double>? mchPg,
    Expression<double>? mchcGDl,
    Expression<double>? rdwPct,
    Expression<double>? wbcTysUl,
    Expression<double>? neutPct,
    Expression<double>? lymphPct,
    Expression<double>? monoPct,
    Expression<double>? eosPct,
    Expression<double>? basoPct,
    Expression<double>? pltTysUl,
    Expression<double>? mpvFl,
    Expression<double>? feUgDl,
    Expression<double>? ferritinNgMl,
    Expression<String>? labName,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (donorId != null) 'donor_id': donorId,
      if (donationId != null) 'donation_id': donationId,
      if (resultDate != null) 'result_date': resultDate,
      if (imagePath != null) 'image_path': imagePath,
      if (ocrConfidence != null) 'ocr_confidence': ocrConfidence,
      if (isVerified != null) 'is_verified': isVerified,
      if (hgbGDl != null) 'hgb_g_dl': hgbGDl,
      if (hctPct != null) 'hct_pct': hctPct,
      if (rbcMlnUl != null) 'rbc_mln_ul': rbcMlnUl,
      if (mcvFl != null) 'mcv_fl': mcvFl,
      if (mchPg != null) 'mch_pg': mchPg,
      if (mchcGDl != null) 'mchc_g_dl': mchcGDl,
      if (rdwPct != null) 'rdw_pct': rdwPct,
      if (wbcTysUl != null) 'wbc_tys_ul': wbcTysUl,
      if (neutPct != null) 'neut_pct': neutPct,
      if (lymphPct != null) 'lymph_pct': lymphPct,
      if (monoPct != null) 'mono_pct': monoPct,
      if (eosPct != null) 'eos_pct': eosPct,
      if (basoPct != null) 'baso_pct': basoPct,
      if (pltTysUl != null) 'plt_tys_ul': pltTysUl,
      if (mpvFl != null) 'mpv_fl': mpvFl,
      if (feUgDl != null) 'fe_ug_dl': feUgDl,
      if (ferritinNgMl != null) 'ferritin_ng_ml': ferritinNgMl,
      if (labName != null) 'lab_name': labName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MorphologyResultsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? donorId,
    Value<int?>? donationId,
    Value<DateTime>? resultDate,
    Value<String?>? imagePath,
    Value<double?>? ocrConfidence,
    Value<bool>? isVerified,
    Value<double?>? hgbGDl,
    Value<double?>? hctPct,
    Value<double?>? rbcMlnUl,
    Value<double?>? mcvFl,
    Value<double?>? mchPg,
    Value<double?>? mchcGDl,
    Value<double?>? rdwPct,
    Value<double?>? wbcTysUl,
    Value<double?>? neutPct,
    Value<double?>? lymphPct,
    Value<double?>? monoPct,
    Value<double?>? eosPct,
    Value<double?>? basoPct,
    Value<double?>? pltTysUl,
    Value<double?>? mpvFl,
    Value<double?>? feUgDl,
    Value<double?>? ferritinNgMl,
    Value<String?>? labName,
    Value<DateTime>? createdAt,
  }) {
    return MorphologyResultsTableCompanion(
      id: id ?? this.id,
      donorId: donorId ?? this.donorId,
      donationId: donationId ?? this.donationId,
      resultDate: resultDate ?? this.resultDate,
      imagePath: imagePath ?? this.imagePath,
      ocrConfidence: ocrConfidence ?? this.ocrConfidence,
      isVerified: isVerified ?? this.isVerified,
      hgbGDl: hgbGDl ?? this.hgbGDl,
      hctPct: hctPct ?? this.hctPct,
      rbcMlnUl: rbcMlnUl ?? this.rbcMlnUl,
      mcvFl: mcvFl ?? this.mcvFl,
      mchPg: mchPg ?? this.mchPg,
      mchcGDl: mchcGDl ?? this.mchcGDl,
      rdwPct: rdwPct ?? this.rdwPct,
      wbcTysUl: wbcTysUl ?? this.wbcTysUl,
      neutPct: neutPct ?? this.neutPct,
      lymphPct: lymphPct ?? this.lymphPct,
      monoPct: monoPct ?? this.monoPct,
      eosPct: eosPct ?? this.eosPct,
      basoPct: basoPct ?? this.basoPct,
      pltTysUl: pltTysUl ?? this.pltTysUl,
      mpvFl: mpvFl ?? this.mpvFl,
      feUgDl: feUgDl ?? this.feUgDl,
      ferritinNgMl: ferritinNgMl ?? this.ferritinNgMl,
      labName: labName ?? this.labName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (donorId.present) {
      map['donor_id'] = Variable<int>(donorId.value);
    }
    if (donationId.present) {
      map['donation_id'] = Variable<int>(donationId.value);
    }
    if (resultDate.present) {
      map['result_date'] = Variable<DateTime>(resultDate.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (ocrConfidence.present) {
      map['ocr_confidence'] = Variable<double>(ocrConfidence.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (hgbGDl.present) {
      map['hgb_g_dl'] = Variable<double>(hgbGDl.value);
    }
    if (hctPct.present) {
      map['hct_pct'] = Variable<double>(hctPct.value);
    }
    if (rbcMlnUl.present) {
      map['rbc_mln_ul'] = Variable<double>(rbcMlnUl.value);
    }
    if (mcvFl.present) {
      map['mcv_fl'] = Variable<double>(mcvFl.value);
    }
    if (mchPg.present) {
      map['mch_pg'] = Variable<double>(mchPg.value);
    }
    if (mchcGDl.present) {
      map['mchc_g_dl'] = Variable<double>(mchcGDl.value);
    }
    if (rdwPct.present) {
      map['rdw_pct'] = Variable<double>(rdwPct.value);
    }
    if (wbcTysUl.present) {
      map['wbc_tys_ul'] = Variable<double>(wbcTysUl.value);
    }
    if (neutPct.present) {
      map['neut_pct'] = Variable<double>(neutPct.value);
    }
    if (lymphPct.present) {
      map['lymph_pct'] = Variable<double>(lymphPct.value);
    }
    if (monoPct.present) {
      map['mono_pct'] = Variable<double>(monoPct.value);
    }
    if (eosPct.present) {
      map['eos_pct'] = Variable<double>(eosPct.value);
    }
    if (basoPct.present) {
      map['baso_pct'] = Variable<double>(basoPct.value);
    }
    if (pltTysUl.present) {
      map['plt_tys_ul'] = Variable<double>(pltTysUl.value);
    }
    if (mpvFl.present) {
      map['mpv_fl'] = Variable<double>(mpvFl.value);
    }
    if (feUgDl.present) {
      map['fe_ug_dl'] = Variable<double>(feUgDl.value);
    }
    if (ferritinNgMl.present) {
      map['ferritin_ng_ml'] = Variable<double>(ferritinNgMl.value);
    }
    if (labName.present) {
      map['lab_name'] = Variable<String>(labName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MorphologyResultsTableCompanion(')
          ..write('id: $id, ')
          ..write('donorId: $donorId, ')
          ..write('donationId: $donationId, ')
          ..write('resultDate: $resultDate, ')
          ..write('imagePath: $imagePath, ')
          ..write('ocrConfidence: $ocrConfidence, ')
          ..write('isVerified: $isVerified, ')
          ..write('hgbGDl: $hgbGDl, ')
          ..write('hctPct: $hctPct, ')
          ..write('rbcMlnUl: $rbcMlnUl, ')
          ..write('mcvFl: $mcvFl, ')
          ..write('mchPg: $mchPg, ')
          ..write('mchcGDl: $mchcGDl, ')
          ..write('rdwPct: $rdwPct, ')
          ..write('wbcTysUl: $wbcTysUl, ')
          ..write('neutPct: $neutPct, ')
          ..write('lymphPct: $lymphPct, ')
          ..write('monoPct: $monoPct, ')
          ..write('eosPct: $eosPct, ')
          ..write('basoPct: $basoPct, ')
          ..write('pltTysUl: $pltTysUl, ')
          ..write('mpvFl: $mpvFl, ')
          ..write('feUgDl: $feUgDl, ')
          ..write('ferritinNgMl: $ferritinNgMl, ')
          ..write('labName: $labName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BloodCentersTableTable extends BloodCentersTable
    with TableInfo<$BloodCentersTableTable, BloodCentersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodCentersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isMobileMeta = const VerificationMeta(
    'isMobile',
  );
  @override
  late final GeneratedColumn<bool> isMobile = GeneratedColumn<bool>(
    'is_mobile',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_mobile" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _operatingHoursJsonMeta =
      const VerificationMeta('operatingHoursJson');
  @override
  late final GeneratedColumn<String> operatingHoursJson =
      GeneratedColumn<String>(
        'operating_hours_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    city,
    address,
    latitude,
    longitude,
    isMobile,
    phone,
    operatingHoursJson,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_centers';
  @override
  VerificationContext validateIntegrity(
    Insertable<BloodCentersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('is_mobile')) {
      context.handle(
        _isMobileMeta,
        isMobile.isAcceptableOrUnknown(data['is_mobile']!, _isMobileMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('operating_hours_json')) {
      context.handle(
        _operatingHoursJsonMeta,
        operatingHoursJson.isAcceptableOrUnknown(
          data['operating_hours_json']!,
          _operatingHoursJsonMeta,
        ),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BloodCentersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodCentersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      isMobile: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_mobile'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      operatingHoursJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operating_hours_json'],
      ),
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $BloodCentersTableTable createAlias(String alias) {
    return $BloodCentersTableTable(attachedDatabase, alias);
  }
}

class BloodCentersTableData extends DataClass
    implements Insertable<BloodCentersTableData> {
  final int id;
  final String name;
  final String city;
  final String? address;
  final double? latitude;
  final double? longitude;
  final bool isMobile;
  final String? phone;
  final String? operatingHoursJson;
  final DateTime lastUpdated;
  const BloodCentersTableData({
    required this.id,
    required this.name,
    required this.city,
    this.address,
    this.latitude,
    this.longitude,
    required this.isMobile,
    this.phone,
    this.operatingHoursJson,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['is_mobile'] = Variable<bool>(isMobile);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || operatingHoursJson != null) {
      map['operating_hours_json'] = Variable<String>(operatingHoursJson);
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  BloodCentersTableCompanion toCompanion(bool nullToAbsent) {
    return BloodCentersTableCompanion(
      id: Value(id),
      name: Value(name),
      city: Value(city),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      isMobile: Value(isMobile),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      operatingHoursJson: operatingHoursJson == null && nullToAbsent
          ? const Value.absent()
          : Value(operatingHoursJson),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory BloodCentersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodCentersTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      city: serializer.fromJson<String>(json['city']),
      address: serializer.fromJson<String?>(json['address']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      isMobile: serializer.fromJson<bool>(json['isMobile']),
      phone: serializer.fromJson<String?>(json['phone']),
      operatingHoursJson: serializer.fromJson<String?>(
        json['operatingHoursJson'],
      ),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'city': serializer.toJson<String>(city),
      'address': serializer.toJson<String?>(address),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'isMobile': serializer.toJson<bool>(isMobile),
      'phone': serializer.toJson<String?>(phone),
      'operatingHoursJson': serializer.toJson<String?>(operatingHoursJson),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  BloodCentersTableData copyWith({
    int? id,
    String? name,
    String? city,
    Value<String?> address = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    bool? isMobile,
    Value<String?> phone = const Value.absent(),
    Value<String?> operatingHoursJson = const Value.absent(),
    DateTime? lastUpdated,
  }) => BloodCentersTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    city: city ?? this.city,
    address: address.present ? address.value : this.address,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    isMobile: isMobile ?? this.isMobile,
    phone: phone.present ? phone.value : this.phone,
    operatingHoursJson: operatingHoursJson.present
        ? operatingHoursJson.value
        : this.operatingHoursJson,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  BloodCentersTableData copyWithCompanion(BloodCentersTableCompanion data) {
    return BloodCentersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      city: data.city.present ? data.city.value : this.city,
      address: data.address.present ? data.address.value : this.address,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      isMobile: data.isMobile.present ? data.isMobile.value : this.isMobile,
      phone: data.phone.present ? data.phone.value : this.phone,
      operatingHoursJson: data.operatingHoursJson.present
          ? data.operatingHoursJson.value
          : this.operatingHoursJson,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BloodCentersTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isMobile: $isMobile, ')
          ..write('phone: $phone, ')
          ..write('operatingHoursJson: $operatingHoursJson, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    city,
    address,
    latitude,
    longitude,
    isMobile,
    phone,
    operatingHoursJson,
    lastUpdated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodCentersTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.city == this.city &&
          other.address == this.address &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.isMobile == this.isMobile &&
          other.phone == this.phone &&
          other.operatingHoursJson == this.operatingHoursJson &&
          other.lastUpdated == this.lastUpdated);
}

class BloodCentersTableCompanion
    extends UpdateCompanion<BloodCentersTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> city;
  final Value<String?> address;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<bool> isMobile;
  final Value<String?> phone;
  final Value<String?> operatingHoursJson;
  final Value<DateTime> lastUpdated;
  const BloodCentersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.city = const Value.absent(),
    this.address = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isMobile = const Value.absent(),
    this.phone = const Value.absent(),
    this.operatingHoursJson = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  BloodCentersTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String city,
    this.address = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isMobile = const Value.absent(),
    this.phone = const Value.absent(),
    this.operatingHoursJson = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  }) : name = Value(name),
       city = Value(city);
  static Insertable<BloodCentersTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? city,
    Expression<String>? address,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? isMobile,
    Expression<String>? phone,
    Expression<String>? operatingHoursJson,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (city != null) 'city': city,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (isMobile != null) 'is_mobile': isMobile,
      if (phone != null) 'phone': phone,
      if (operatingHoursJson != null)
        'operating_hours_json': operatingHoursJson,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  BloodCentersTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? city,
    Value<String?>? address,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<bool>? isMobile,
    Value<String?>? phone,
    Value<String?>? operatingHoursJson,
    Value<DateTime>? lastUpdated,
  }) {
    return BloodCentersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isMobile: isMobile ?? this.isMobile,
      phone: phone ?? this.phone,
      operatingHoursJson: operatingHoursJson ?? this.operatingHoursJson,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (isMobile.present) {
      map['is_mobile'] = Variable<bool>(isMobile.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (operatingHoursJson.present) {
      map['operating_hours_json'] = Variable<String>(operatingHoursJson.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BloodCentersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isMobile: $isMobile, ')
          ..write('phone: $phone, ')
          ..write('operatingHoursJson: $operatingHoursJson, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $ZhdkBadgeDefinitionsTableTable extends ZhdkBadgeDefinitionsTable
    with
        TableInfo<
          $ZhdkBadgeDefinitionsTableTable,
          ZhdkBadgeDefinitionsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZhdkBadgeDefinitionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _badgeCodeMeta = const VerificationMeta(
    'badgeCode',
  );
  @override
  late final GeneratedColumn<String> badgeCode = GeneratedColumn<String>(
    'badge_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thresholdLitersMaleMeta =
      const VerificationMeta('thresholdLitersMale');
  @override
  late final GeneratedColumn<double> thresholdLitersMale =
      GeneratedColumn<double>(
        'threshold_liters_male',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _thresholdLitersFemaleMeta =
      const VerificationMeta('thresholdLitersFemale');
  @override
  late final GeneratedColumn<double> thresholdLitersFemale =
      GeneratedColumn<double>(
        'threshold_liters_female',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _issuingBodyMeta = const VerificationMeta(
    'issuingBody',
  );
  @override
  late final GeneratedColumn<String> issuingBody = GeneratedColumn<String>(
    'issuing_body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _privilegesJsonMeta = const VerificationMeta(
    'privilegesJson',
  );
  @override
  late final GeneratedColumn<String> privilegesJson = GeneratedColumn<String>(
    'privileges_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    badgeCode,
    name,
    thresholdLitersMale,
    thresholdLitersFemale,
    issuingBody,
    privilegesJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'zhdk_badge_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ZhdkBadgeDefinitionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('badge_code')) {
      context.handle(
        _badgeCodeMeta,
        badgeCode.isAcceptableOrUnknown(data['badge_code']!, _badgeCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_badgeCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('threshold_liters_male')) {
      context.handle(
        _thresholdLitersMaleMeta,
        thresholdLitersMale.isAcceptableOrUnknown(
          data['threshold_liters_male']!,
          _thresholdLitersMaleMeta,
        ),
      );
    }
    if (data.containsKey('threshold_liters_female')) {
      context.handle(
        _thresholdLitersFemaleMeta,
        thresholdLitersFemale.isAcceptableOrUnknown(
          data['threshold_liters_female']!,
          _thresholdLitersFemaleMeta,
        ),
      );
    }
    if (data.containsKey('issuing_body')) {
      context.handle(
        _issuingBodyMeta,
        issuingBody.isAcceptableOrUnknown(
          data['issuing_body']!,
          _issuingBodyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_issuingBodyMeta);
    }
    if (data.containsKey('privileges_json')) {
      context.handle(
        _privilegesJsonMeta,
        privilegesJson.isAcceptableOrUnknown(
          data['privileges_json']!,
          _privilegesJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ZhdkBadgeDefinitionsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ZhdkBadgeDefinitionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      badgeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}badge_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      thresholdLitersMale: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}threshold_liters_male'],
      ),
      thresholdLitersFemale: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}threshold_liters_female'],
      ),
      issuingBody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}issuing_body'],
      )!,
      privilegesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}privileges_json'],
      ),
    );
  }

  @override
  $ZhdkBadgeDefinitionsTableTable createAlias(String alias) {
    return $ZhdkBadgeDefinitionsTableTable(attachedDatabase, alias);
  }
}

class ZhdkBadgeDefinitionsTableData extends DataClass
    implements Insertable<ZhdkBadgeDefinitionsTableData> {
  final int id;
  final String badgeCode;
  final String name;
  final double? thresholdLitersMale;
  final double? thresholdLitersFemale;
  final String issuingBody;
  final String? privilegesJson;
  const ZhdkBadgeDefinitionsTableData({
    required this.id,
    required this.badgeCode,
    required this.name,
    this.thresholdLitersMale,
    this.thresholdLitersFemale,
    required this.issuingBody,
    this.privilegesJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['badge_code'] = Variable<String>(badgeCode);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || thresholdLitersMale != null) {
      map['threshold_liters_male'] = Variable<double>(thresholdLitersMale);
    }
    if (!nullToAbsent || thresholdLitersFemale != null) {
      map['threshold_liters_female'] = Variable<double>(thresholdLitersFemale);
    }
    map['issuing_body'] = Variable<String>(issuingBody);
    if (!nullToAbsent || privilegesJson != null) {
      map['privileges_json'] = Variable<String>(privilegesJson);
    }
    return map;
  }

  ZhdkBadgeDefinitionsTableCompanion toCompanion(bool nullToAbsent) {
    return ZhdkBadgeDefinitionsTableCompanion(
      id: Value(id),
      badgeCode: Value(badgeCode),
      name: Value(name),
      thresholdLitersMale: thresholdLitersMale == null && nullToAbsent
          ? const Value.absent()
          : Value(thresholdLitersMale),
      thresholdLitersFemale: thresholdLitersFemale == null && nullToAbsent
          ? const Value.absent()
          : Value(thresholdLitersFemale),
      issuingBody: Value(issuingBody),
      privilegesJson: privilegesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(privilegesJson),
    );
  }

  factory ZhdkBadgeDefinitionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ZhdkBadgeDefinitionsTableData(
      id: serializer.fromJson<int>(json['id']),
      badgeCode: serializer.fromJson<String>(json['badgeCode']),
      name: serializer.fromJson<String>(json['name']),
      thresholdLitersMale: serializer.fromJson<double?>(
        json['thresholdLitersMale'],
      ),
      thresholdLitersFemale: serializer.fromJson<double?>(
        json['thresholdLitersFemale'],
      ),
      issuingBody: serializer.fromJson<String>(json['issuingBody']),
      privilegesJson: serializer.fromJson<String?>(json['privilegesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'badgeCode': serializer.toJson<String>(badgeCode),
      'name': serializer.toJson<String>(name),
      'thresholdLitersMale': serializer.toJson<double?>(thresholdLitersMale),
      'thresholdLitersFemale': serializer.toJson<double?>(
        thresholdLitersFemale,
      ),
      'issuingBody': serializer.toJson<String>(issuingBody),
      'privilegesJson': serializer.toJson<String?>(privilegesJson),
    };
  }

  ZhdkBadgeDefinitionsTableData copyWith({
    int? id,
    String? badgeCode,
    String? name,
    Value<double?> thresholdLitersMale = const Value.absent(),
    Value<double?> thresholdLitersFemale = const Value.absent(),
    String? issuingBody,
    Value<String?> privilegesJson = const Value.absent(),
  }) => ZhdkBadgeDefinitionsTableData(
    id: id ?? this.id,
    badgeCode: badgeCode ?? this.badgeCode,
    name: name ?? this.name,
    thresholdLitersMale: thresholdLitersMale.present
        ? thresholdLitersMale.value
        : this.thresholdLitersMale,
    thresholdLitersFemale: thresholdLitersFemale.present
        ? thresholdLitersFemale.value
        : this.thresholdLitersFemale,
    issuingBody: issuingBody ?? this.issuingBody,
    privilegesJson: privilegesJson.present
        ? privilegesJson.value
        : this.privilegesJson,
  );
  ZhdkBadgeDefinitionsTableData copyWithCompanion(
    ZhdkBadgeDefinitionsTableCompanion data,
  ) {
    return ZhdkBadgeDefinitionsTableData(
      id: data.id.present ? data.id.value : this.id,
      badgeCode: data.badgeCode.present ? data.badgeCode.value : this.badgeCode,
      name: data.name.present ? data.name.value : this.name,
      thresholdLitersMale: data.thresholdLitersMale.present
          ? data.thresholdLitersMale.value
          : this.thresholdLitersMale,
      thresholdLitersFemale: data.thresholdLitersFemale.present
          ? data.thresholdLitersFemale.value
          : this.thresholdLitersFemale,
      issuingBody: data.issuingBody.present
          ? data.issuingBody.value
          : this.issuingBody,
      privilegesJson: data.privilegesJson.present
          ? data.privilegesJson.value
          : this.privilegesJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ZhdkBadgeDefinitionsTableData(')
          ..write('id: $id, ')
          ..write('badgeCode: $badgeCode, ')
          ..write('name: $name, ')
          ..write('thresholdLitersMale: $thresholdLitersMale, ')
          ..write('thresholdLitersFemale: $thresholdLitersFemale, ')
          ..write('issuingBody: $issuingBody, ')
          ..write('privilegesJson: $privilegesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    badgeCode,
    name,
    thresholdLitersMale,
    thresholdLitersFemale,
    issuingBody,
    privilegesJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZhdkBadgeDefinitionsTableData &&
          other.id == this.id &&
          other.badgeCode == this.badgeCode &&
          other.name == this.name &&
          other.thresholdLitersMale == this.thresholdLitersMale &&
          other.thresholdLitersFemale == this.thresholdLitersFemale &&
          other.issuingBody == this.issuingBody &&
          other.privilegesJson == this.privilegesJson);
}

class ZhdkBadgeDefinitionsTableCompanion
    extends UpdateCompanion<ZhdkBadgeDefinitionsTableData> {
  final Value<int> id;
  final Value<String> badgeCode;
  final Value<String> name;
  final Value<double?> thresholdLitersMale;
  final Value<double?> thresholdLitersFemale;
  final Value<String> issuingBody;
  final Value<String?> privilegesJson;
  const ZhdkBadgeDefinitionsTableCompanion({
    this.id = const Value.absent(),
    this.badgeCode = const Value.absent(),
    this.name = const Value.absent(),
    this.thresholdLitersMale = const Value.absent(),
    this.thresholdLitersFemale = const Value.absent(),
    this.issuingBody = const Value.absent(),
    this.privilegesJson = const Value.absent(),
  });
  ZhdkBadgeDefinitionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String badgeCode,
    required String name,
    this.thresholdLitersMale = const Value.absent(),
    this.thresholdLitersFemale = const Value.absent(),
    required String issuingBody,
    this.privilegesJson = const Value.absent(),
  }) : badgeCode = Value(badgeCode),
       name = Value(name),
       issuingBody = Value(issuingBody);
  static Insertable<ZhdkBadgeDefinitionsTableData> custom({
    Expression<int>? id,
    Expression<String>? badgeCode,
    Expression<String>? name,
    Expression<double>? thresholdLitersMale,
    Expression<double>? thresholdLitersFemale,
    Expression<String>? issuingBody,
    Expression<String>? privilegesJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (badgeCode != null) 'badge_code': badgeCode,
      if (name != null) 'name': name,
      if (thresholdLitersMale != null)
        'threshold_liters_male': thresholdLitersMale,
      if (thresholdLitersFemale != null)
        'threshold_liters_female': thresholdLitersFemale,
      if (issuingBody != null) 'issuing_body': issuingBody,
      if (privilegesJson != null) 'privileges_json': privilegesJson,
    });
  }

  ZhdkBadgeDefinitionsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? badgeCode,
    Value<String>? name,
    Value<double?>? thresholdLitersMale,
    Value<double?>? thresholdLitersFemale,
    Value<String>? issuingBody,
    Value<String?>? privilegesJson,
  }) {
    return ZhdkBadgeDefinitionsTableCompanion(
      id: id ?? this.id,
      badgeCode: badgeCode ?? this.badgeCode,
      name: name ?? this.name,
      thresholdLitersMale: thresholdLitersMale ?? this.thresholdLitersMale,
      thresholdLitersFemale:
          thresholdLitersFemale ?? this.thresholdLitersFemale,
      issuingBody: issuingBody ?? this.issuingBody,
      privilegesJson: privilegesJson ?? this.privilegesJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (badgeCode.present) {
      map['badge_code'] = Variable<String>(badgeCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (thresholdLitersMale.present) {
      map['threshold_liters_male'] = Variable<double>(
        thresholdLitersMale.value,
      );
    }
    if (thresholdLitersFemale.present) {
      map['threshold_liters_female'] = Variable<double>(
        thresholdLitersFemale.value,
      );
    }
    if (issuingBody.present) {
      map['issuing_body'] = Variable<String>(issuingBody.value);
    }
    if (privilegesJson.present) {
      map['privileges_json'] = Variable<String>(privilegesJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZhdkBadgeDefinitionsTableCompanion(')
          ..write('id: $id, ')
          ..write('badgeCode: $badgeCode, ')
          ..write('name: $name, ')
          ..write('thresholdLitersMale: $thresholdLitersMale, ')
          ..write('thresholdLitersFemale: $thresholdLitersFemale, ')
          ..write('issuingBody: $issuingBody, ')
          ..write('privilegesJson: $privilegesJson')
          ..write(')'))
        .toString();
  }
}

class $DonorBadgesEarnedTableTable extends DonorBadgesEarnedTable
    with TableInfo<$DonorBadgesEarnedTableTable, DonorBadgesEarnedTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DonorBadgesEarnedTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _donorProfileIdMeta = const VerificationMeta(
    'donorProfileId',
  );
  @override
  late final GeneratedColumn<int> donorProfileId = GeneratedColumn<int>(
    'donor_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _badgeIdMeta = const VerificationMeta(
    'badgeId',
  );
  @override
  late final GeneratedColumn<int> badgeId = GeneratedColumn<int>(
    'badge_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _earnedDateMeta = const VerificationMeta(
    'earnedDate',
  );
  @override
  late final GeneratedColumn<DateTime> earnedDate = GeneratedColumn<DateTime>(
    'earned_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLitersAtEarnMeta = const VerificationMeta(
    'totalLitersAtEarn',
  );
  @override
  late final GeneratedColumn<double> totalLitersAtEarn =
      GeneratedColumn<double>(
        'total_liters_at_earn',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    donorProfileId,
    badgeId,
    earnedDate,
    totalLitersAtEarn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'donor_badges_earned';
  @override
  VerificationContext validateIntegrity(
    Insertable<DonorBadgesEarnedTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('donor_profile_id')) {
      context.handle(
        _donorProfileIdMeta,
        donorProfileId.isAcceptableOrUnknown(
          data['donor_profile_id']!,
          _donorProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_donorProfileIdMeta);
    }
    if (data.containsKey('badge_id')) {
      context.handle(
        _badgeIdMeta,
        badgeId.isAcceptableOrUnknown(data['badge_id']!, _badgeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_badgeIdMeta);
    }
    if (data.containsKey('earned_date')) {
      context.handle(
        _earnedDateMeta,
        earnedDate.isAcceptableOrUnknown(data['earned_date']!, _earnedDateMeta),
      );
    } else if (isInserting) {
      context.missing(_earnedDateMeta);
    }
    if (data.containsKey('total_liters_at_earn')) {
      context.handle(
        _totalLitersAtEarnMeta,
        totalLitersAtEarn.isAcceptableOrUnknown(
          data['total_liters_at_earn']!,
          _totalLitersAtEarnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLitersAtEarnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DonorBadgesEarnedTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DonorBadgesEarnedTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      donorProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}donor_profile_id'],
      )!,
      badgeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}badge_id'],
      )!,
      earnedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}earned_date'],
      )!,
      totalLitersAtEarn: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_liters_at_earn'],
      )!,
    );
  }

  @override
  $DonorBadgesEarnedTableTable createAlias(String alias) {
    return $DonorBadgesEarnedTableTable(attachedDatabase, alias);
  }
}

class DonorBadgesEarnedTableData extends DataClass
    implements Insertable<DonorBadgesEarnedTableData> {
  final int id;
  final int donorProfileId;
  final int badgeId;
  final DateTime earnedDate;
  final double totalLitersAtEarn;
  const DonorBadgesEarnedTableData({
    required this.id,
    required this.donorProfileId,
    required this.badgeId,
    required this.earnedDate,
    required this.totalLitersAtEarn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['donor_profile_id'] = Variable<int>(donorProfileId);
    map['badge_id'] = Variable<int>(badgeId);
    map['earned_date'] = Variable<DateTime>(earnedDate);
    map['total_liters_at_earn'] = Variable<double>(totalLitersAtEarn);
    return map;
  }

  DonorBadgesEarnedTableCompanion toCompanion(bool nullToAbsent) {
    return DonorBadgesEarnedTableCompanion(
      id: Value(id),
      donorProfileId: Value(donorProfileId),
      badgeId: Value(badgeId),
      earnedDate: Value(earnedDate),
      totalLitersAtEarn: Value(totalLitersAtEarn),
    );
  }

  factory DonorBadgesEarnedTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DonorBadgesEarnedTableData(
      id: serializer.fromJson<int>(json['id']),
      donorProfileId: serializer.fromJson<int>(json['donorProfileId']),
      badgeId: serializer.fromJson<int>(json['badgeId']),
      earnedDate: serializer.fromJson<DateTime>(json['earnedDate']),
      totalLitersAtEarn: serializer.fromJson<double>(json['totalLitersAtEarn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'donorProfileId': serializer.toJson<int>(donorProfileId),
      'badgeId': serializer.toJson<int>(badgeId),
      'earnedDate': serializer.toJson<DateTime>(earnedDate),
      'totalLitersAtEarn': serializer.toJson<double>(totalLitersAtEarn),
    };
  }

  DonorBadgesEarnedTableData copyWith({
    int? id,
    int? donorProfileId,
    int? badgeId,
    DateTime? earnedDate,
    double? totalLitersAtEarn,
  }) => DonorBadgesEarnedTableData(
    id: id ?? this.id,
    donorProfileId: donorProfileId ?? this.donorProfileId,
    badgeId: badgeId ?? this.badgeId,
    earnedDate: earnedDate ?? this.earnedDate,
    totalLitersAtEarn: totalLitersAtEarn ?? this.totalLitersAtEarn,
  );
  DonorBadgesEarnedTableData copyWithCompanion(
    DonorBadgesEarnedTableCompanion data,
  ) {
    return DonorBadgesEarnedTableData(
      id: data.id.present ? data.id.value : this.id,
      donorProfileId: data.donorProfileId.present
          ? data.donorProfileId.value
          : this.donorProfileId,
      badgeId: data.badgeId.present ? data.badgeId.value : this.badgeId,
      earnedDate: data.earnedDate.present
          ? data.earnedDate.value
          : this.earnedDate,
      totalLitersAtEarn: data.totalLitersAtEarn.present
          ? data.totalLitersAtEarn.value
          : this.totalLitersAtEarn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DonorBadgesEarnedTableData(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('badgeId: $badgeId, ')
          ..write('earnedDate: $earnedDate, ')
          ..write('totalLitersAtEarn: $totalLitersAtEarn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, donorProfileId, badgeId, earnedDate, totalLitersAtEarn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DonorBadgesEarnedTableData &&
          other.id == this.id &&
          other.donorProfileId == this.donorProfileId &&
          other.badgeId == this.badgeId &&
          other.earnedDate == this.earnedDate &&
          other.totalLitersAtEarn == this.totalLitersAtEarn);
}

class DonorBadgesEarnedTableCompanion
    extends UpdateCompanion<DonorBadgesEarnedTableData> {
  final Value<int> id;
  final Value<int> donorProfileId;
  final Value<int> badgeId;
  final Value<DateTime> earnedDate;
  final Value<double> totalLitersAtEarn;
  const DonorBadgesEarnedTableCompanion({
    this.id = const Value.absent(),
    this.donorProfileId = const Value.absent(),
    this.badgeId = const Value.absent(),
    this.earnedDate = const Value.absent(),
    this.totalLitersAtEarn = const Value.absent(),
  });
  DonorBadgesEarnedTableCompanion.insert({
    this.id = const Value.absent(),
    required int donorProfileId,
    required int badgeId,
    required DateTime earnedDate,
    required double totalLitersAtEarn,
  }) : donorProfileId = Value(donorProfileId),
       badgeId = Value(badgeId),
       earnedDate = Value(earnedDate),
       totalLitersAtEarn = Value(totalLitersAtEarn);
  static Insertable<DonorBadgesEarnedTableData> custom({
    Expression<int>? id,
    Expression<int>? donorProfileId,
    Expression<int>? badgeId,
    Expression<DateTime>? earnedDate,
    Expression<double>? totalLitersAtEarn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (donorProfileId != null) 'donor_profile_id': donorProfileId,
      if (badgeId != null) 'badge_id': badgeId,
      if (earnedDate != null) 'earned_date': earnedDate,
      if (totalLitersAtEarn != null) 'total_liters_at_earn': totalLitersAtEarn,
    });
  }

  DonorBadgesEarnedTableCompanion copyWith({
    Value<int>? id,
    Value<int>? donorProfileId,
    Value<int>? badgeId,
    Value<DateTime>? earnedDate,
    Value<double>? totalLitersAtEarn,
  }) {
    return DonorBadgesEarnedTableCompanion(
      id: id ?? this.id,
      donorProfileId: donorProfileId ?? this.donorProfileId,
      badgeId: badgeId ?? this.badgeId,
      earnedDate: earnedDate ?? this.earnedDate,
      totalLitersAtEarn: totalLitersAtEarn ?? this.totalLitersAtEarn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (donorProfileId.present) {
      map['donor_profile_id'] = Variable<int>(donorProfileId.value);
    }
    if (badgeId.present) {
      map['badge_id'] = Variable<int>(badgeId.value);
    }
    if (earnedDate.present) {
      map['earned_date'] = Variable<DateTime>(earnedDate.value);
    }
    if (totalLitersAtEarn.present) {
      map['total_liters_at_earn'] = Variable<double>(totalLitersAtEarn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DonorBadgesEarnedTableCompanion(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('badgeId: $badgeId, ')
          ..write('earnedDate: $earnedDate, ')
          ..write('totalLitersAtEarn: $totalLitersAtEarn')
          ..write(')'))
        .toString();
  }
}

class $NotificationLogTableTable extends NotificationLogTable
    with TableInfo<$NotificationLogTableTable, NotificationLogTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationLogTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _donorProfileIdMeta = const VerificationMeta(
    'donorProfileId',
  );
  @override
  late final GeneratedColumn<int> donorProfileId = GeneratedColumn<int>(
    'donor_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notificationTypeMeta = const VerificationMeta(
    'notificationType',
  );
  @override
  late final GeneratedColumn<String> notificationType = GeneratedColumn<String>(
    'notification_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDismissedMeta = const VerificationMeta(
    'isDismissed',
  );
  @override
  late final GeneratedColumn<bool> isDismissed = GeneratedColumn<bool>(
    'is_dismissed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dismissed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    donorProfileId,
    notificationType,
    scheduledAt,
    sentAt,
    isDismissed,
    payloadJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationLogTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('donor_profile_id')) {
      context.handle(
        _donorProfileIdMeta,
        donorProfileId.isAcceptableOrUnknown(
          data['donor_profile_id']!,
          _donorProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_donorProfileIdMeta);
    }
    if (data.containsKey('notification_type')) {
      context.handle(
        _notificationTypeMeta,
        notificationType.isAcceptableOrUnknown(
          data['notification_type']!,
          _notificationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationTypeMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    }
    if (data.containsKey('is_dismissed')) {
      context.handle(
        _isDismissedMeta,
        isDismissed.isAcceptableOrUnknown(
          data['is_dismissed']!,
          _isDismissedMeta,
        ),
      );
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationLogTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationLogTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      donorProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}donor_profile_id'],
      )!,
      notificationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notification_type'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      ),
      isDismissed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dismissed'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      ),
    );
  }

  @override
  $NotificationLogTableTable createAlias(String alias) {
    return $NotificationLogTableTable(attachedDatabase, alias);
  }
}

class NotificationLogTableData extends DataClass
    implements Insertable<NotificationLogTableData> {
  final int id;
  final int donorProfileId;
  final String notificationType;
  final DateTime scheduledAt;
  final DateTime? sentAt;
  final bool isDismissed;
  final String? payloadJson;
  const NotificationLogTableData({
    required this.id,
    required this.donorProfileId,
    required this.notificationType,
    required this.scheduledAt,
    this.sentAt,
    required this.isDismissed,
    this.payloadJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['donor_profile_id'] = Variable<int>(donorProfileId);
    map['notification_type'] = Variable<String>(notificationType);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<DateTime>(sentAt);
    }
    map['is_dismissed'] = Variable<bool>(isDismissed);
    if (!nullToAbsent || payloadJson != null) {
      map['payload_json'] = Variable<String>(payloadJson);
    }
    return map;
  }

  NotificationLogTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationLogTableCompanion(
      id: Value(id),
      donorProfileId: Value(donorProfileId),
      notificationType: Value(notificationType),
      scheduledAt: Value(scheduledAt),
      sentAt: sentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentAt),
      isDismissed: Value(isDismissed),
      payloadJson: payloadJson == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadJson),
    );
  }

  factory NotificationLogTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationLogTableData(
      id: serializer.fromJson<int>(json['id']),
      donorProfileId: serializer.fromJson<int>(json['donorProfileId']),
      notificationType: serializer.fromJson<String>(json['notificationType']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      sentAt: serializer.fromJson<DateTime?>(json['sentAt']),
      isDismissed: serializer.fromJson<bool>(json['isDismissed']),
      payloadJson: serializer.fromJson<String?>(json['payloadJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'donorProfileId': serializer.toJson<int>(donorProfileId),
      'notificationType': serializer.toJson<String>(notificationType),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'sentAt': serializer.toJson<DateTime?>(sentAt),
      'isDismissed': serializer.toJson<bool>(isDismissed),
      'payloadJson': serializer.toJson<String?>(payloadJson),
    };
  }

  NotificationLogTableData copyWith({
    int? id,
    int? donorProfileId,
    String? notificationType,
    DateTime? scheduledAt,
    Value<DateTime?> sentAt = const Value.absent(),
    bool? isDismissed,
    Value<String?> payloadJson = const Value.absent(),
  }) => NotificationLogTableData(
    id: id ?? this.id,
    donorProfileId: donorProfileId ?? this.donorProfileId,
    notificationType: notificationType ?? this.notificationType,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    sentAt: sentAt.present ? sentAt.value : this.sentAt,
    isDismissed: isDismissed ?? this.isDismissed,
    payloadJson: payloadJson.present ? payloadJson.value : this.payloadJson,
  );
  NotificationLogTableData copyWithCompanion(
    NotificationLogTableCompanion data,
  ) {
    return NotificationLogTableData(
      id: data.id.present ? data.id.value : this.id,
      donorProfileId: data.donorProfileId.present
          ? data.donorProfileId.value
          : this.donorProfileId,
      notificationType: data.notificationType.present
          ? data.notificationType.value
          : this.notificationType,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      isDismissed: data.isDismissed.present
          ? data.isDismissed.value
          : this.isDismissed,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationLogTableData(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('notificationType: $notificationType, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('sentAt: $sentAt, ')
          ..write('isDismissed: $isDismissed, ')
          ..write('payloadJson: $payloadJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    donorProfileId,
    notificationType,
    scheduledAt,
    sentAt,
    isDismissed,
    payloadJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationLogTableData &&
          other.id == this.id &&
          other.donorProfileId == this.donorProfileId &&
          other.notificationType == this.notificationType &&
          other.scheduledAt == this.scheduledAt &&
          other.sentAt == this.sentAt &&
          other.isDismissed == this.isDismissed &&
          other.payloadJson == this.payloadJson);
}

class NotificationLogTableCompanion
    extends UpdateCompanion<NotificationLogTableData> {
  final Value<int> id;
  final Value<int> donorProfileId;
  final Value<String> notificationType;
  final Value<DateTime> scheduledAt;
  final Value<DateTime?> sentAt;
  final Value<bool> isDismissed;
  final Value<String?> payloadJson;
  const NotificationLogTableCompanion({
    this.id = const Value.absent(),
    this.donorProfileId = const Value.absent(),
    this.notificationType = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.payloadJson = const Value.absent(),
  });
  NotificationLogTableCompanion.insert({
    this.id = const Value.absent(),
    required int donorProfileId,
    required String notificationType,
    required DateTime scheduledAt,
    this.sentAt = const Value.absent(),
    this.isDismissed = const Value.absent(),
    this.payloadJson = const Value.absent(),
  }) : donorProfileId = Value(donorProfileId),
       notificationType = Value(notificationType),
       scheduledAt = Value(scheduledAt);
  static Insertable<NotificationLogTableData> custom({
    Expression<int>? id,
    Expression<int>? donorProfileId,
    Expression<String>? notificationType,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? sentAt,
    Expression<bool>? isDismissed,
    Expression<String>? payloadJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (donorProfileId != null) 'donor_profile_id': donorProfileId,
      if (notificationType != null) 'notification_type': notificationType,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (sentAt != null) 'sent_at': sentAt,
      if (isDismissed != null) 'is_dismissed': isDismissed,
      if (payloadJson != null) 'payload_json': payloadJson,
    });
  }

  NotificationLogTableCompanion copyWith({
    Value<int>? id,
    Value<int>? donorProfileId,
    Value<String>? notificationType,
    Value<DateTime>? scheduledAt,
    Value<DateTime?>? sentAt,
    Value<bool>? isDismissed,
    Value<String?>? payloadJson,
  }) {
    return NotificationLogTableCompanion(
      id: id ?? this.id,
      donorProfileId: donorProfileId ?? this.donorProfileId,
      notificationType: notificationType ?? this.notificationType,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      sentAt: sentAt ?? this.sentAt,
      isDismissed: isDismissed ?? this.isDismissed,
      payloadJson: payloadJson ?? this.payloadJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (donorProfileId.present) {
      map['donor_profile_id'] = Variable<int>(donorProfileId.value);
    }
    if (notificationType.present) {
      map['notification_type'] = Variable<String>(notificationType.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (isDismissed.present) {
      map['is_dismissed'] = Variable<bool>(isDismissed.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationLogTableCompanion(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('notificationType: $notificationType, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('sentAt: $sentAt, ')
          ..write('isDismissed: $isDismissed, ')
          ..write('payloadJson: $payloadJson')
          ..write(')'))
        .toString();
  }
}

class $PitAnnualSummaryTableTable extends PitAnnualSummaryTable
    with TableInfo<$PitAnnualSummaryTableTable, PitAnnualSummaryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PitAnnualSummaryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _donorProfileIdMeta = const VerificationMeta(
    'donorProfileId',
  );
  @override
  late final GeneratedColumn<int> donorProfileId = GeneratedColumn<int>(
    'donor_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxYearMeta = const VerificationMeta(
    'taxYear',
  );
  @override
  late final GeneratedColumn<int> taxYear = GeneratedColumn<int>(
    'tax_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalVolumeMlMeta = const VerificationMeta(
    'totalVolumeMl',
  );
  @override
  late final GeneratedColumn<int> totalVolumeMl = GeneratedColumn<int>(
    'total_volume_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratePlnPerLiterMeta = const VerificationMeta(
    'ratePlnPerLiter',
  );
  @override
  late final GeneratedColumn<double> ratePlnPerLiter = GeneratedColumn<double>(
    'rate_pln_per_liter',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grossDeductionPlnMeta = const VerificationMeta(
    'grossDeductionPln',
  );
  @override
  late final GeneratedColumn<double> grossDeductionPln =
      GeneratedColumn<double>(
        'gross_deduction_pln',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _income6PctCapMeta = const VerificationMeta(
    'income6PctCap',
  );
  @override
  late final GeneratedColumn<double> income6PctCap = GeneratedColumn<double>(
    'income6_pct_cap',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _netDeductionPlnMeta = const VerificationMeta(
    'netDeductionPln',
  );
  @override
  late final GeneratedColumn<double> netDeductionPln = GeneratedColumn<double>(
    'net_deduction_pln',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastCalculatedAtMeta = const VerificationMeta(
    'lastCalculatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastCalculatedAt =
      GeneratedColumn<DateTime>(
        'last_calculated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    donorProfileId,
    taxYear,
    totalVolumeMl,
    ratePlnPerLiter,
    grossDeductionPln,
    income6PctCap,
    netDeductionPln,
    lastCalculatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pit_annual_summary';
  @override
  VerificationContext validateIntegrity(
    Insertable<PitAnnualSummaryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('donor_profile_id')) {
      context.handle(
        _donorProfileIdMeta,
        donorProfileId.isAcceptableOrUnknown(
          data['donor_profile_id']!,
          _donorProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_donorProfileIdMeta);
    }
    if (data.containsKey('tax_year')) {
      context.handle(
        _taxYearMeta,
        taxYear.isAcceptableOrUnknown(data['tax_year']!, _taxYearMeta),
      );
    } else if (isInserting) {
      context.missing(_taxYearMeta);
    }
    if (data.containsKey('total_volume_ml')) {
      context.handle(
        _totalVolumeMlMeta,
        totalVolumeMl.isAcceptableOrUnknown(
          data['total_volume_ml']!,
          _totalVolumeMlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalVolumeMlMeta);
    }
    if (data.containsKey('rate_pln_per_liter')) {
      context.handle(
        _ratePlnPerLiterMeta,
        ratePlnPerLiter.isAcceptableOrUnknown(
          data['rate_pln_per_liter']!,
          _ratePlnPerLiterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ratePlnPerLiterMeta);
    }
    if (data.containsKey('gross_deduction_pln')) {
      context.handle(
        _grossDeductionPlnMeta,
        grossDeductionPln.isAcceptableOrUnknown(
          data['gross_deduction_pln']!,
          _grossDeductionPlnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_grossDeductionPlnMeta);
    }
    if (data.containsKey('income6_pct_cap')) {
      context.handle(
        _income6PctCapMeta,
        income6PctCap.isAcceptableOrUnknown(
          data['income6_pct_cap']!,
          _income6PctCapMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_income6PctCapMeta);
    }
    if (data.containsKey('net_deduction_pln')) {
      context.handle(
        _netDeductionPlnMeta,
        netDeductionPln.isAcceptableOrUnknown(
          data['net_deduction_pln']!,
          _netDeductionPlnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_netDeductionPlnMeta);
    }
    if (data.containsKey('last_calculated_at')) {
      context.handle(
        _lastCalculatedAtMeta,
        lastCalculatedAt.isAcceptableOrUnknown(
          data['last_calculated_at']!,
          _lastCalculatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PitAnnualSummaryTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PitAnnualSummaryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      donorProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}donor_profile_id'],
      )!,
      taxYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_year'],
      )!,
      totalVolumeMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_volume_ml'],
      )!,
      ratePlnPerLiter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate_pln_per_liter'],
      )!,
      grossDeductionPln: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gross_deduction_pln'],
      )!,
      income6PctCap: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}income6_pct_cap'],
      )!,
      netDeductionPln: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_deduction_pln'],
      )!,
      lastCalculatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_calculated_at'],
      )!,
    );
  }

  @override
  $PitAnnualSummaryTableTable createAlias(String alias) {
    return $PitAnnualSummaryTableTable(attachedDatabase, alias);
  }
}

class PitAnnualSummaryTableData extends DataClass
    implements Insertable<PitAnnualSummaryTableData> {
  final int id;
  final int donorProfileId;
  final int taxYear;
  final int totalVolumeMl;
  final double ratePlnPerLiter;
  final double grossDeductionPln;
  final double income6PctCap;
  final double netDeductionPln;
  final DateTime lastCalculatedAt;
  const PitAnnualSummaryTableData({
    required this.id,
    required this.donorProfileId,
    required this.taxYear,
    required this.totalVolumeMl,
    required this.ratePlnPerLiter,
    required this.grossDeductionPln,
    required this.income6PctCap,
    required this.netDeductionPln,
    required this.lastCalculatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['donor_profile_id'] = Variable<int>(donorProfileId);
    map['tax_year'] = Variable<int>(taxYear);
    map['total_volume_ml'] = Variable<int>(totalVolumeMl);
    map['rate_pln_per_liter'] = Variable<double>(ratePlnPerLiter);
    map['gross_deduction_pln'] = Variable<double>(grossDeductionPln);
    map['income6_pct_cap'] = Variable<double>(income6PctCap);
    map['net_deduction_pln'] = Variable<double>(netDeductionPln);
    map['last_calculated_at'] = Variable<DateTime>(lastCalculatedAt);
    return map;
  }

  PitAnnualSummaryTableCompanion toCompanion(bool nullToAbsent) {
    return PitAnnualSummaryTableCompanion(
      id: Value(id),
      donorProfileId: Value(donorProfileId),
      taxYear: Value(taxYear),
      totalVolumeMl: Value(totalVolumeMl),
      ratePlnPerLiter: Value(ratePlnPerLiter),
      grossDeductionPln: Value(grossDeductionPln),
      income6PctCap: Value(income6PctCap),
      netDeductionPln: Value(netDeductionPln),
      lastCalculatedAt: Value(lastCalculatedAt),
    );
  }

  factory PitAnnualSummaryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PitAnnualSummaryTableData(
      id: serializer.fromJson<int>(json['id']),
      donorProfileId: serializer.fromJson<int>(json['donorProfileId']),
      taxYear: serializer.fromJson<int>(json['taxYear']),
      totalVolumeMl: serializer.fromJson<int>(json['totalVolumeMl']),
      ratePlnPerLiter: serializer.fromJson<double>(json['ratePlnPerLiter']),
      grossDeductionPln: serializer.fromJson<double>(json['grossDeductionPln']),
      income6PctCap: serializer.fromJson<double>(json['income6PctCap']),
      netDeductionPln: serializer.fromJson<double>(json['netDeductionPln']),
      lastCalculatedAt: serializer.fromJson<DateTime>(json['lastCalculatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'donorProfileId': serializer.toJson<int>(donorProfileId),
      'taxYear': serializer.toJson<int>(taxYear),
      'totalVolumeMl': serializer.toJson<int>(totalVolumeMl),
      'ratePlnPerLiter': serializer.toJson<double>(ratePlnPerLiter),
      'grossDeductionPln': serializer.toJson<double>(grossDeductionPln),
      'income6PctCap': serializer.toJson<double>(income6PctCap),
      'netDeductionPln': serializer.toJson<double>(netDeductionPln),
      'lastCalculatedAt': serializer.toJson<DateTime>(lastCalculatedAt),
    };
  }

  PitAnnualSummaryTableData copyWith({
    int? id,
    int? donorProfileId,
    int? taxYear,
    int? totalVolumeMl,
    double? ratePlnPerLiter,
    double? grossDeductionPln,
    double? income6PctCap,
    double? netDeductionPln,
    DateTime? lastCalculatedAt,
  }) => PitAnnualSummaryTableData(
    id: id ?? this.id,
    donorProfileId: donorProfileId ?? this.donorProfileId,
    taxYear: taxYear ?? this.taxYear,
    totalVolumeMl: totalVolumeMl ?? this.totalVolumeMl,
    ratePlnPerLiter: ratePlnPerLiter ?? this.ratePlnPerLiter,
    grossDeductionPln: grossDeductionPln ?? this.grossDeductionPln,
    income6PctCap: income6PctCap ?? this.income6PctCap,
    netDeductionPln: netDeductionPln ?? this.netDeductionPln,
    lastCalculatedAt: lastCalculatedAt ?? this.lastCalculatedAt,
  );
  PitAnnualSummaryTableData copyWithCompanion(
    PitAnnualSummaryTableCompanion data,
  ) {
    return PitAnnualSummaryTableData(
      id: data.id.present ? data.id.value : this.id,
      donorProfileId: data.donorProfileId.present
          ? data.donorProfileId.value
          : this.donorProfileId,
      taxYear: data.taxYear.present ? data.taxYear.value : this.taxYear,
      totalVolumeMl: data.totalVolumeMl.present
          ? data.totalVolumeMl.value
          : this.totalVolumeMl,
      ratePlnPerLiter: data.ratePlnPerLiter.present
          ? data.ratePlnPerLiter.value
          : this.ratePlnPerLiter,
      grossDeductionPln: data.grossDeductionPln.present
          ? data.grossDeductionPln.value
          : this.grossDeductionPln,
      income6PctCap: data.income6PctCap.present
          ? data.income6PctCap.value
          : this.income6PctCap,
      netDeductionPln: data.netDeductionPln.present
          ? data.netDeductionPln.value
          : this.netDeductionPln,
      lastCalculatedAt: data.lastCalculatedAt.present
          ? data.lastCalculatedAt.value
          : this.lastCalculatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PitAnnualSummaryTableData(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('taxYear: $taxYear, ')
          ..write('totalVolumeMl: $totalVolumeMl, ')
          ..write('ratePlnPerLiter: $ratePlnPerLiter, ')
          ..write('grossDeductionPln: $grossDeductionPln, ')
          ..write('income6PctCap: $income6PctCap, ')
          ..write('netDeductionPln: $netDeductionPln, ')
          ..write('lastCalculatedAt: $lastCalculatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    donorProfileId,
    taxYear,
    totalVolumeMl,
    ratePlnPerLiter,
    grossDeductionPln,
    income6PctCap,
    netDeductionPln,
    lastCalculatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PitAnnualSummaryTableData &&
          other.id == this.id &&
          other.donorProfileId == this.donorProfileId &&
          other.taxYear == this.taxYear &&
          other.totalVolumeMl == this.totalVolumeMl &&
          other.ratePlnPerLiter == this.ratePlnPerLiter &&
          other.grossDeductionPln == this.grossDeductionPln &&
          other.income6PctCap == this.income6PctCap &&
          other.netDeductionPln == this.netDeductionPln &&
          other.lastCalculatedAt == this.lastCalculatedAt);
}

class PitAnnualSummaryTableCompanion
    extends UpdateCompanion<PitAnnualSummaryTableData> {
  final Value<int> id;
  final Value<int> donorProfileId;
  final Value<int> taxYear;
  final Value<int> totalVolumeMl;
  final Value<double> ratePlnPerLiter;
  final Value<double> grossDeductionPln;
  final Value<double> income6PctCap;
  final Value<double> netDeductionPln;
  final Value<DateTime> lastCalculatedAt;
  const PitAnnualSummaryTableCompanion({
    this.id = const Value.absent(),
    this.donorProfileId = const Value.absent(),
    this.taxYear = const Value.absent(),
    this.totalVolumeMl = const Value.absent(),
    this.ratePlnPerLiter = const Value.absent(),
    this.grossDeductionPln = const Value.absent(),
    this.income6PctCap = const Value.absent(),
    this.netDeductionPln = const Value.absent(),
    this.lastCalculatedAt = const Value.absent(),
  });
  PitAnnualSummaryTableCompanion.insert({
    this.id = const Value.absent(),
    required int donorProfileId,
    required int taxYear,
    required int totalVolumeMl,
    required double ratePlnPerLiter,
    required double grossDeductionPln,
    required double income6PctCap,
    required double netDeductionPln,
    this.lastCalculatedAt = const Value.absent(),
  }) : donorProfileId = Value(donorProfileId),
       taxYear = Value(taxYear),
       totalVolumeMl = Value(totalVolumeMl),
       ratePlnPerLiter = Value(ratePlnPerLiter),
       grossDeductionPln = Value(grossDeductionPln),
       income6PctCap = Value(income6PctCap),
       netDeductionPln = Value(netDeductionPln);
  static Insertable<PitAnnualSummaryTableData> custom({
    Expression<int>? id,
    Expression<int>? donorProfileId,
    Expression<int>? taxYear,
    Expression<int>? totalVolumeMl,
    Expression<double>? ratePlnPerLiter,
    Expression<double>? grossDeductionPln,
    Expression<double>? income6PctCap,
    Expression<double>? netDeductionPln,
    Expression<DateTime>? lastCalculatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (donorProfileId != null) 'donor_profile_id': donorProfileId,
      if (taxYear != null) 'tax_year': taxYear,
      if (totalVolumeMl != null) 'total_volume_ml': totalVolumeMl,
      if (ratePlnPerLiter != null) 'rate_pln_per_liter': ratePlnPerLiter,
      if (grossDeductionPln != null) 'gross_deduction_pln': grossDeductionPln,
      if (income6PctCap != null) 'income6_pct_cap': income6PctCap,
      if (netDeductionPln != null) 'net_deduction_pln': netDeductionPln,
      if (lastCalculatedAt != null) 'last_calculated_at': lastCalculatedAt,
    });
  }

  PitAnnualSummaryTableCompanion copyWith({
    Value<int>? id,
    Value<int>? donorProfileId,
    Value<int>? taxYear,
    Value<int>? totalVolumeMl,
    Value<double>? ratePlnPerLiter,
    Value<double>? grossDeductionPln,
    Value<double>? income6PctCap,
    Value<double>? netDeductionPln,
    Value<DateTime>? lastCalculatedAt,
  }) {
    return PitAnnualSummaryTableCompanion(
      id: id ?? this.id,
      donorProfileId: donorProfileId ?? this.donorProfileId,
      taxYear: taxYear ?? this.taxYear,
      totalVolumeMl: totalVolumeMl ?? this.totalVolumeMl,
      ratePlnPerLiter: ratePlnPerLiter ?? this.ratePlnPerLiter,
      grossDeductionPln: grossDeductionPln ?? this.grossDeductionPln,
      income6PctCap: income6PctCap ?? this.income6PctCap,
      netDeductionPln: netDeductionPln ?? this.netDeductionPln,
      lastCalculatedAt: lastCalculatedAt ?? this.lastCalculatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (donorProfileId.present) {
      map['donor_profile_id'] = Variable<int>(donorProfileId.value);
    }
    if (taxYear.present) {
      map['tax_year'] = Variable<int>(taxYear.value);
    }
    if (totalVolumeMl.present) {
      map['total_volume_ml'] = Variable<int>(totalVolumeMl.value);
    }
    if (ratePlnPerLiter.present) {
      map['rate_pln_per_liter'] = Variable<double>(ratePlnPerLiter.value);
    }
    if (grossDeductionPln.present) {
      map['gross_deduction_pln'] = Variable<double>(grossDeductionPln.value);
    }
    if (income6PctCap.present) {
      map['income6_pct_cap'] = Variable<double>(income6PctCap.value);
    }
    if (netDeductionPln.present) {
      map['net_deduction_pln'] = Variable<double>(netDeductionPln.value);
    }
    if (lastCalculatedAt.present) {
      map['last_calculated_at'] = Variable<DateTime>(lastCalculatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PitAnnualSummaryTableCompanion(')
          ..write('id: $id, ')
          ..write('donorProfileId: $donorProfileId, ')
          ..write('taxYear: $taxYear, ')
          ..write('totalVolumeMl: $totalVolumeMl, ')
          ..write('ratePlnPerLiter: $ratePlnPerLiter, ')
          ..write('grossDeductionPln: $grossDeductionPln, ')
          ..write('income6PctCap: $income6PctCap, ')
          ..write('netDeductionPln: $netDeductionPln, ')
          ..write('lastCalculatedAt: $lastCalculatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DonorProfileTableTable donorProfileTable =
      $DonorProfileTableTable(this);
  late final $DonationsTableTable donationsTable = $DonationsTableTable(this);
  late final $MenstrualCyclesTableTable menstrualCyclesTable =
      $MenstrualCyclesTableTable(this);
  late final $MorphologyResultsTableTable morphologyResultsTable =
      $MorphologyResultsTableTable(this);
  late final $BloodCentersTableTable bloodCentersTable =
      $BloodCentersTableTable(this);
  late final $ZhdkBadgeDefinitionsTableTable zhdkBadgeDefinitionsTable =
      $ZhdkBadgeDefinitionsTableTable(this);
  late final $DonorBadgesEarnedTableTable donorBadgesEarnedTable =
      $DonorBadgesEarnedTableTable(this);
  late final $NotificationLogTableTable notificationLogTable =
      $NotificationLogTableTable(this);
  late final $PitAnnualSummaryTableTable pitAnnualSummaryTable =
      $PitAnnualSummaryTableTable(this);
  late final DonorProfileDao donorProfileDao = DonorProfileDao(
    this as AppDatabase,
  );
  late final DonationsDao donationsDao = DonationsDao(this as AppDatabase);
  late final MenstrualCyclesDao menstrualCyclesDao = MenstrualCyclesDao(
    this as AppDatabase,
  );
  late final MorphologyResultsDao morphologyResultsDao = MorphologyResultsDao(
    this as AppDatabase,
  );
  late final BloodCentersDao bloodCentersDao = BloodCentersDao(
    this as AppDatabase,
  );
  late final ZhdkBadgeDefinitionsDao zhdkBadgeDefinitionsDao =
      ZhdkBadgeDefinitionsDao(this as AppDatabase);
  late final DonorBadgesEarnedDao donorBadgesEarnedDao = DonorBadgesEarnedDao(
    this as AppDatabase,
  );
  late final NotificationLogDao notificationLogDao = NotificationLogDao(
    this as AppDatabase,
  );
  late final PitAnnualSummaryDao pitAnnualSummaryDao = PitAnnualSummaryDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    donorProfileTable,
    donationsTable,
    menstrualCyclesTable,
    morphologyResultsTable,
    bloodCentersTable,
    zhdkBadgeDefinitionsTable,
    donorBadgesEarnedTable,
    notificationLogTable,
    pitAnnualSummaryTable,
  ];
}

typedef $$DonorProfileTableTableCreateCompanionBuilder =
    DonorProfileTableCompanion Function({
      Value<int> id,
      required String firstName,
      required String lastName,
      required DateTime birthDate,
      required String sex,
      Value<String?> bloodType,
      Value<String?> rhFactor,
      Value<DateTime> createdAt,
    });
typedef $$DonorProfileTableTableUpdateCompanionBuilder =
    DonorProfileTableCompanion Function({
      Value<int> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<DateTime> birthDate,
      Value<String> sex,
      Value<String?> bloodType,
      Value<String?> rhFactor,
      Value<DateTime> createdAt,
    });

class $$DonorProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $DonorProfileTableTable> {
  $$DonorProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodType => $composableBuilder(
    column: $table.bloodType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rhFactor => $composableBuilder(
    column: $table.rhFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DonorProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DonorProfileTableTable> {
  $$DonorProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bloodType => $composableBuilder(
    column: $table.bloodType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rhFactor => $composableBuilder(
    column: $table.rhFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DonorProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DonorProfileTableTable> {
  $$DonorProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get bloodType =>
      $composableBuilder(column: $table.bloodType, builder: (column) => column);

  GeneratedColumn<String> get rhFactor =>
      $composableBuilder(column: $table.rhFactor, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DonorProfileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DonorProfileTableTable,
          DonorProfileTableData,
          $$DonorProfileTableTableFilterComposer,
          $$DonorProfileTableTableOrderingComposer,
          $$DonorProfileTableTableAnnotationComposer,
          $$DonorProfileTableTableCreateCompanionBuilder,
          $$DonorProfileTableTableUpdateCompanionBuilder,
          (
            DonorProfileTableData,
            BaseReferences<
              _$AppDatabase,
              $DonorProfileTableTable,
              DonorProfileTableData
            >,
          ),
          DonorProfileTableData,
          PrefetchHooks Function()
        > {
  $$DonorProfileTableTableTableManager(
    _$AppDatabase db,
    $DonorProfileTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DonorProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DonorProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DonorProfileTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<DateTime> birthDate = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String?> bloodType = const Value.absent(),
                Value<String?> rhFactor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DonorProfileTableCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                birthDate: birthDate,
                sex: sex,
                bloodType: bloodType,
                rhFactor: rhFactor,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String firstName,
                required String lastName,
                required DateTime birthDate,
                required String sex,
                Value<String?> bloodType = const Value.absent(),
                Value<String?> rhFactor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DonorProfileTableCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                birthDate: birthDate,
                sex: sex,
                bloodType: bloodType,
                rhFactor: rhFactor,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DonorProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DonorProfileTableTable,
      DonorProfileTableData,
      $$DonorProfileTableTableFilterComposer,
      $$DonorProfileTableTableOrderingComposer,
      $$DonorProfileTableTableAnnotationComposer,
      $$DonorProfileTableTableCreateCompanionBuilder,
      $$DonorProfileTableTableUpdateCompanionBuilder,
      (
        DonorProfileTableData,
        BaseReferences<
          _$AppDatabase,
          $DonorProfileTableTable,
          DonorProfileTableData
        >,
      ),
      DonorProfileTableData,
      PrefetchHooks Function()
    >;
typedef $$DonationsTableTableCreateCompanionBuilder =
    DonationsTableCompanion Function({
      Value<int> id,
      required int donorProfileId,
      required int bloodCenterId,
      required String donationType,
      required DateTime donationDate,
      required int volumeMl,
      Value<bool> isRejected,
      Value<String?> rejectionReason,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$DonationsTableTableUpdateCompanionBuilder =
    DonationsTableCompanion Function({
      Value<int> id,
      Value<int> donorProfileId,
      Value<int> bloodCenterId,
      Value<String> donationType,
      Value<DateTime> donationDate,
      Value<int> volumeMl,
      Value<bool> isRejected,
      Value<String?> rejectionReason,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$DonationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DonationsTableTable> {
  $$DonationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bloodCenterId => $composableBuilder(
    column: $table.bloodCenterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get donationType => $composableBuilder(
    column: $table.donationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get donationDate => $composableBuilder(
    column: $table.donationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get volumeMl => $composableBuilder(
    column: $table.volumeMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRejected => $composableBuilder(
    column: $table.isRejected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DonationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DonationsTableTable> {
  $$DonationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bloodCenterId => $composableBuilder(
    column: $table.bloodCenterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get donationType => $composableBuilder(
    column: $table.donationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get donationDate => $composableBuilder(
    column: $table.donationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get volumeMl => $composableBuilder(
    column: $table.volumeMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRejected => $composableBuilder(
    column: $table.isRejected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DonationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DonationsTableTable> {
  $$DonationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bloodCenterId => $composableBuilder(
    column: $table.bloodCenterId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get donationType => $composableBuilder(
    column: $table.donationType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get donationDate => $composableBuilder(
    column: $table.donationDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get volumeMl =>
      $composableBuilder(column: $table.volumeMl, builder: (column) => column);

  GeneratedColumn<bool> get isRejected => $composableBuilder(
    column: $table.isRejected,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DonationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DonationsTableTable,
          DonationsTableData,
          $$DonationsTableTableFilterComposer,
          $$DonationsTableTableOrderingComposer,
          $$DonationsTableTableAnnotationComposer,
          $$DonationsTableTableCreateCompanionBuilder,
          $$DonationsTableTableUpdateCompanionBuilder,
          (
            DonationsTableData,
            BaseReferences<
              _$AppDatabase,
              $DonationsTableTable,
              DonationsTableData
            >,
          ),
          DonationsTableData,
          PrefetchHooks Function()
        > {
  $$DonationsTableTableTableManager(
    _$AppDatabase db,
    $DonationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DonationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DonationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DonationsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> donorProfileId = const Value.absent(),
                Value<int> bloodCenterId = const Value.absent(),
                Value<String> donationType = const Value.absent(),
                Value<DateTime> donationDate = const Value.absent(),
                Value<int> volumeMl = const Value.absent(),
                Value<bool> isRejected = const Value.absent(),
                Value<String?> rejectionReason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DonationsTableCompanion(
                id: id,
                donorProfileId: donorProfileId,
                bloodCenterId: bloodCenterId,
                donationType: donationType,
                donationDate: donationDate,
                volumeMl: volumeMl,
                isRejected: isRejected,
                rejectionReason: rejectionReason,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int donorProfileId,
                required int bloodCenterId,
                required String donationType,
                required DateTime donationDate,
                required int volumeMl,
                Value<bool> isRejected = const Value.absent(),
                Value<String?> rejectionReason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DonationsTableCompanion.insert(
                id: id,
                donorProfileId: donorProfileId,
                bloodCenterId: bloodCenterId,
                donationType: donationType,
                donationDate: donationDate,
                volumeMl: volumeMl,
                isRejected: isRejected,
                rejectionReason: rejectionReason,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DonationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DonationsTableTable,
      DonationsTableData,
      $$DonationsTableTableFilterComposer,
      $$DonationsTableTableOrderingComposer,
      $$DonationsTableTableAnnotationComposer,
      $$DonationsTableTableCreateCompanionBuilder,
      $$DonationsTableTableUpdateCompanionBuilder,
      (
        DonationsTableData,
        BaseReferences<_$AppDatabase, $DonationsTableTable, DonationsTableData>,
      ),
      DonationsTableData,
      PrefetchHooks Function()
    >;
typedef $$MenstrualCyclesTableTableCreateCompanionBuilder =
    MenstrualCyclesTableCompanion Function({
      Value<int> id,
      required int donorProfileId,
      required DateTime startDate,
      Value<DateTime?> endDate,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$MenstrualCyclesTableTableUpdateCompanionBuilder =
    MenstrualCyclesTableCompanion Function({
      Value<int> id,
      Value<int> donorProfileId,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

class $$MenstrualCyclesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MenstrualCyclesTableTable> {
  $$MenstrualCyclesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MenstrualCyclesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MenstrualCyclesTableTable> {
  $$MenstrualCyclesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MenstrualCyclesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenstrualCyclesTableTable> {
  $$MenstrualCyclesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MenstrualCyclesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MenstrualCyclesTableTable,
          MenstrualCyclesTableData,
          $$MenstrualCyclesTableTableFilterComposer,
          $$MenstrualCyclesTableTableOrderingComposer,
          $$MenstrualCyclesTableTableAnnotationComposer,
          $$MenstrualCyclesTableTableCreateCompanionBuilder,
          $$MenstrualCyclesTableTableUpdateCompanionBuilder,
          (
            MenstrualCyclesTableData,
            BaseReferences<
              _$AppDatabase,
              $MenstrualCyclesTableTable,
              MenstrualCyclesTableData
            >,
          ),
          MenstrualCyclesTableData,
          PrefetchHooks Function()
        > {
  $$MenstrualCyclesTableTableTableManager(
    _$AppDatabase db,
    $MenstrualCyclesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenstrualCyclesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenstrualCyclesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MenstrualCyclesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> donorProfileId = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenstrualCyclesTableCompanion(
                id: id,
                donorProfileId: donorProfileId,
                startDate: startDate,
                endDate: endDate,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int donorProfileId,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MenstrualCyclesTableCompanion.insert(
                id: id,
                donorProfileId: donorProfileId,
                startDate: startDate,
                endDate: endDate,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MenstrualCyclesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MenstrualCyclesTableTable,
      MenstrualCyclesTableData,
      $$MenstrualCyclesTableTableFilterComposer,
      $$MenstrualCyclesTableTableOrderingComposer,
      $$MenstrualCyclesTableTableAnnotationComposer,
      $$MenstrualCyclesTableTableCreateCompanionBuilder,
      $$MenstrualCyclesTableTableUpdateCompanionBuilder,
      (
        MenstrualCyclesTableData,
        BaseReferences<
          _$AppDatabase,
          $MenstrualCyclesTableTable,
          MenstrualCyclesTableData
        >,
      ),
      MenstrualCyclesTableData,
      PrefetchHooks Function()
    >;
typedef $$MorphologyResultsTableTableCreateCompanionBuilder =
    MorphologyResultsTableCompanion Function({
      Value<int> id,
      required int donorId,
      Value<int?> donationId,
      required DateTime resultDate,
      Value<String?> imagePath,
      Value<double?> ocrConfidence,
      Value<bool> isVerified,
      Value<double?> hgbGDl,
      Value<double?> hctPct,
      Value<double?> rbcMlnUl,
      Value<double?> mcvFl,
      Value<double?> mchPg,
      Value<double?> mchcGDl,
      Value<double?> rdwPct,
      Value<double?> wbcTysUl,
      Value<double?> neutPct,
      Value<double?> lymphPct,
      Value<double?> monoPct,
      Value<double?> eosPct,
      Value<double?> basoPct,
      Value<double?> pltTysUl,
      Value<double?> mpvFl,
      Value<double?> feUgDl,
      Value<double?> ferritinNgMl,
      Value<String?> labName,
      Value<DateTime> createdAt,
    });
typedef $$MorphologyResultsTableTableUpdateCompanionBuilder =
    MorphologyResultsTableCompanion Function({
      Value<int> id,
      Value<int> donorId,
      Value<int?> donationId,
      Value<DateTime> resultDate,
      Value<String?> imagePath,
      Value<double?> ocrConfidence,
      Value<bool> isVerified,
      Value<double?> hgbGDl,
      Value<double?> hctPct,
      Value<double?> rbcMlnUl,
      Value<double?> mcvFl,
      Value<double?> mchPg,
      Value<double?> mchcGDl,
      Value<double?> rdwPct,
      Value<double?> wbcTysUl,
      Value<double?> neutPct,
      Value<double?> lymphPct,
      Value<double?> monoPct,
      Value<double?> eosPct,
      Value<double?> basoPct,
      Value<double?> pltTysUl,
      Value<double?> mpvFl,
      Value<double?> feUgDl,
      Value<double?> ferritinNgMl,
      Value<String?> labName,
      Value<DateTime> createdAt,
    });

class $$MorphologyResultsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MorphologyResultsTableTable> {
  $$MorphologyResultsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get donorId => $composableBuilder(
    column: $table.donorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get donationId => $composableBuilder(
    column: $table.donationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resultDate => $composableBuilder(
    column: $table.resultDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ocrConfidence => $composableBuilder(
    column: $table.ocrConfidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hgbGDl => $composableBuilder(
    column: $table.hgbGDl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hctPct => $composableBuilder(
    column: $table.hctPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rbcMlnUl => $composableBuilder(
    column: $table.rbcMlnUl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mcvFl => $composableBuilder(
    column: $table.mcvFl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mchPg => $composableBuilder(
    column: $table.mchPg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mchcGDl => $composableBuilder(
    column: $table.mchcGDl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rdwPct => $composableBuilder(
    column: $table.rdwPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wbcTysUl => $composableBuilder(
    column: $table.wbcTysUl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get neutPct => $composableBuilder(
    column: $table.neutPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lymphPct => $composableBuilder(
    column: $table.lymphPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monoPct => $composableBuilder(
    column: $table.monoPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get eosPct => $composableBuilder(
    column: $table.eosPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get basoPct => $composableBuilder(
    column: $table.basoPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pltTysUl => $composableBuilder(
    column: $table.pltTysUl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mpvFl => $composableBuilder(
    column: $table.mpvFl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get feUgDl => $composableBuilder(
    column: $table.feUgDl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ferritinNgMl => $composableBuilder(
    column: $table.ferritinNgMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labName => $composableBuilder(
    column: $table.labName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MorphologyResultsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MorphologyResultsTableTable> {
  $$MorphologyResultsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get donorId => $composableBuilder(
    column: $table.donorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get donationId => $composableBuilder(
    column: $table.donationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resultDate => $composableBuilder(
    column: $table.resultDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ocrConfidence => $composableBuilder(
    column: $table.ocrConfidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hgbGDl => $composableBuilder(
    column: $table.hgbGDl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hctPct => $composableBuilder(
    column: $table.hctPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rbcMlnUl => $composableBuilder(
    column: $table.rbcMlnUl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mcvFl => $composableBuilder(
    column: $table.mcvFl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mchPg => $composableBuilder(
    column: $table.mchPg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mchcGDl => $composableBuilder(
    column: $table.mchcGDl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rdwPct => $composableBuilder(
    column: $table.rdwPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wbcTysUl => $composableBuilder(
    column: $table.wbcTysUl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get neutPct => $composableBuilder(
    column: $table.neutPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lymphPct => $composableBuilder(
    column: $table.lymphPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monoPct => $composableBuilder(
    column: $table.monoPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get eosPct => $composableBuilder(
    column: $table.eosPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get basoPct => $composableBuilder(
    column: $table.basoPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pltTysUl => $composableBuilder(
    column: $table.pltTysUl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mpvFl => $composableBuilder(
    column: $table.mpvFl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get feUgDl => $composableBuilder(
    column: $table.feUgDl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ferritinNgMl => $composableBuilder(
    column: $table.ferritinNgMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labName => $composableBuilder(
    column: $table.labName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MorphologyResultsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MorphologyResultsTableTable> {
  $$MorphologyResultsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get donorId =>
      $composableBuilder(column: $table.donorId, builder: (column) => column);

  GeneratedColumn<int> get donationId => $composableBuilder(
    column: $table.donationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get resultDate => $composableBuilder(
    column: $table.resultDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<double> get ocrConfidence => $composableBuilder(
    column: $table.ocrConfidence,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<double> get hgbGDl =>
      $composableBuilder(column: $table.hgbGDl, builder: (column) => column);

  GeneratedColumn<double> get hctPct =>
      $composableBuilder(column: $table.hctPct, builder: (column) => column);

  GeneratedColumn<double> get rbcMlnUl =>
      $composableBuilder(column: $table.rbcMlnUl, builder: (column) => column);

  GeneratedColumn<double> get mcvFl =>
      $composableBuilder(column: $table.mcvFl, builder: (column) => column);

  GeneratedColumn<double> get mchPg =>
      $composableBuilder(column: $table.mchPg, builder: (column) => column);

  GeneratedColumn<double> get mchcGDl =>
      $composableBuilder(column: $table.mchcGDl, builder: (column) => column);

  GeneratedColumn<double> get rdwPct =>
      $composableBuilder(column: $table.rdwPct, builder: (column) => column);

  GeneratedColumn<double> get wbcTysUl =>
      $composableBuilder(column: $table.wbcTysUl, builder: (column) => column);

  GeneratedColumn<double> get neutPct =>
      $composableBuilder(column: $table.neutPct, builder: (column) => column);

  GeneratedColumn<double> get lymphPct =>
      $composableBuilder(column: $table.lymphPct, builder: (column) => column);

  GeneratedColumn<double> get monoPct =>
      $composableBuilder(column: $table.monoPct, builder: (column) => column);

  GeneratedColumn<double> get eosPct =>
      $composableBuilder(column: $table.eosPct, builder: (column) => column);

  GeneratedColumn<double> get basoPct =>
      $composableBuilder(column: $table.basoPct, builder: (column) => column);

  GeneratedColumn<double> get pltTysUl =>
      $composableBuilder(column: $table.pltTysUl, builder: (column) => column);

  GeneratedColumn<double> get mpvFl =>
      $composableBuilder(column: $table.mpvFl, builder: (column) => column);

  GeneratedColumn<double> get feUgDl =>
      $composableBuilder(column: $table.feUgDl, builder: (column) => column);

  GeneratedColumn<double> get ferritinNgMl => $composableBuilder(
    column: $table.ferritinNgMl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labName =>
      $composableBuilder(column: $table.labName, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MorphologyResultsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MorphologyResultsTableTable,
          MorphologyResultsTableData,
          $$MorphologyResultsTableTableFilterComposer,
          $$MorphologyResultsTableTableOrderingComposer,
          $$MorphologyResultsTableTableAnnotationComposer,
          $$MorphologyResultsTableTableCreateCompanionBuilder,
          $$MorphologyResultsTableTableUpdateCompanionBuilder,
          (
            MorphologyResultsTableData,
            BaseReferences<
              _$AppDatabase,
              $MorphologyResultsTableTable,
              MorphologyResultsTableData
            >,
          ),
          MorphologyResultsTableData,
          PrefetchHooks Function()
        > {
  $$MorphologyResultsTableTableTableManager(
    _$AppDatabase db,
    $MorphologyResultsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MorphologyResultsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MorphologyResultsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MorphologyResultsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> donorId = const Value.absent(),
                Value<int?> donationId = const Value.absent(),
                Value<DateTime> resultDate = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<double?> ocrConfidence = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<double?> hgbGDl = const Value.absent(),
                Value<double?> hctPct = const Value.absent(),
                Value<double?> rbcMlnUl = const Value.absent(),
                Value<double?> mcvFl = const Value.absent(),
                Value<double?> mchPg = const Value.absent(),
                Value<double?> mchcGDl = const Value.absent(),
                Value<double?> rdwPct = const Value.absent(),
                Value<double?> wbcTysUl = const Value.absent(),
                Value<double?> neutPct = const Value.absent(),
                Value<double?> lymphPct = const Value.absent(),
                Value<double?> monoPct = const Value.absent(),
                Value<double?> eosPct = const Value.absent(),
                Value<double?> basoPct = const Value.absent(),
                Value<double?> pltTysUl = const Value.absent(),
                Value<double?> mpvFl = const Value.absent(),
                Value<double?> feUgDl = const Value.absent(),
                Value<double?> ferritinNgMl = const Value.absent(),
                Value<String?> labName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MorphologyResultsTableCompanion(
                id: id,
                donorId: donorId,
                donationId: donationId,
                resultDate: resultDate,
                imagePath: imagePath,
                ocrConfidence: ocrConfidence,
                isVerified: isVerified,
                hgbGDl: hgbGDl,
                hctPct: hctPct,
                rbcMlnUl: rbcMlnUl,
                mcvFl: mcvFl,
                mchPg: mchPg,
                mchcGDl: mchcGDl,
                rdwPct: rdwPct,
                wbcTysUl: wbcTysUl,
                neutPct: neutPct,
                lymphPct: lymphPct,
                monoPct: monoPct,
                eosPct: eosPct,
                basoPct: basoPct,
                pltTysUl: pltTysUl,
                mpvFl: mpvFl,
                feUgDl: feUgDl,
                ferritinNgMl: ferritinNgMl,
                labName: labName,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int donorId,
                Value<int?> donationId = const Value.absent(),
                required DateTime resultDate,
                Value<String?> imagePath = const Value.absent(),
                Value<double?> ocrConfidence = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<double?> hgbGDl = const Value.absent(),
                Value<double?> hctPct = const Value.absent(),
                Value<double?> rbcMlnUl = const Value.absent(),
                Value<double?> mcvFl = const Value.absent(),
                Value<double?> mchPg = const Value.absent(),
                Value<double?> mchcGDl = const Value.absent(),
                Value<double?> rdwPct = const Value.absent(),
                Value<double?> wbcTysUl = const Value.absent(),
                Value<double?> neutPct = const Value.absent(),
                Value<double?> lymphPct = const Value.absent(),
                Value<double?> monoPct = const Value.absent(),
                Value<double?> eosPct = const Value.absent(),
                Value<double?> basoPct = const Value.absent(),
                Value<double?> pltTysUl = const Value.absent(),
                Value<double?> mpvFl = const Value.absent(),
                Value<double?> feUgDl = const Value.absent(),
                Value<double?> ferritinNgMl = const Value.absent(),
                Value<String?> labName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MorphologyResultsTableCompanion.insert(
                id: id,
                donorId: donorId,
                donationId: donationId,
                resultDate: resultDate,
                imagePath: imagePath,
                ocrConfidence: ocrConfidence,
                isVerified: isVerified,
                hgbGDl: hgbGDl,
                hctPct: hctPct,
                rbcMlnUl: rbcMlnUl,
                mcvFl: mcvFl,
                mchPg: mchPg,
                mchcGDl: mchcGDl,
                rdwPct: rdwPct,
                wbcTysUl: wbcTysUl,
                neutPct: neutPct,
                lymphPct: lymphPct,
                monoPct: monoPct,
                eosPct: eosPct,
                basoPct: basoPct,
                pltTysUl: pltTysUl,
                mpvFl: mpvFl,
                feUgDl: feUgDl,
                ferritinNgMl: ferritinNgMl,
                labName: labName,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MorphologyResultsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MorphologyResultsTableTable,
      MorphologyResultsTableData,
      $$MorphologyResultsTableTableFilterComposer,
      $$MorphologyResultsTableTableOrderingComposer,
      $$MorphologyResultsTableTableAnnotationComposer,
      $$MorphologyResultsTableTableCreateCompanionBuilder,
      $$MorphologyResultsTableTableUpdateCompanionBuilder,
      (
        MorphologyResultsTableData,
        BaseReferences<
          _$AppDatabase,
          $MorphologyResultsTableTable,
          MorphologyResultsTableData
        >,
      ),
      MorphologyResultsTableData,
      PrefetchHooks Function()
    >;
typedef $$BloodCentersTableTableCreateCompanionBuilder =
    BloodCentersTableCompanion Function({
      Value<int> id,
      required String name,
      required String city,
      Value<String?> address,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> isMobile,
      Value<String?> phone,
      Value<String?> operatingHoursJson,
      Value<DateTime> lastUpdated,
    });
typedef $$BloodCentersTableTableUpdateCompanionBuilder =
    BloodCentersTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> city,
      Value<String?> address,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> isMobile,
      Value<String?> phone,
      Value<String?> operatingHoursJson,
      Value<DateTime> lastUpdated,
    });

class $$BloodCentersTableTableFilterComposer
    extends Composer<_$AppDatabase, $BloodCentersTableTable> {
  $$BloodCentersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMobile => $composableBuilder(
    column: $table.isMobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operatingHoursJson => $composableBuilder(
    column: $table.operatingHoursJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BloodCentersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BloodCentersTableTable> {
  $$BloodCentersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMobile => $composableBuilder(
    column: $table.isMobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operatingHoursJson => $composableBuilder(
    column: $table.operatingHoursJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BloodCentersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BloodCentersTableTable> {
  $$BloodCentersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get isMobile =>
      $composableBuilder(column: $table.isMobile, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get operatingHoursJson => $composableBuilder(
    column: $table.operatingHoursJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$BloodCentersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BloodCentersTableTable,
          BloodCentersTableData,
          $$BloodCentersTableTableFilterComposer,
          $$BloodCentersTableTableOrderingComposer,
          $$BloodCentersTableTableAnnotationComposer,
          $$BloodCentersTableTableCreateCompanionBuilder,
          $$BloodCentersTableTableUpdateCompanionBuilder,
          (
            BloodCentersTableData,
            BaseReferences<
              _$AppDatabase,
              $BloodCentersTableTable,
              BloodCentersTableData
            >,
          ),
          BloodCentersTableData,
          PrefetchHooks Function()
        > {
  $$BloodCentersTableTableTableManager(
    _$AppDatabase db,
    $BloodCentersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BloodCentersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BloodCentersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BloodCentersTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> isMobile = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> operatingHoursJson = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
              }) => BloodCentersTableCompanion(
                id: id,
                name: name,
                city: city,
                address: address,
                latitude: latitude,
                longitude: longitude,
                isMobile: isMobile,
                phone: phone,
                operatingHoursJson: operatingHoursJson,
                lastUpdated: lastUpdated,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String city,
                Value<String?> address = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> isMobile = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> operatingHoursJson = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
              }) => BloodCentersTableCompanion.insert(
                id: id,
                name: name,
                city: city,
                address: address,
                latitude: latitude,
                longitude: longitude,
                isMobile: isMobile,
                phone: phone,
                operatingHoursJson: operatingHoursJson,
                lastUpdated: lastUpdated,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BloodCentersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BloodCentersTableTable,
      BloodCentersTableData,
      $$BloodCentersTableTableFilterComposer,
      $$BloodCentersTableTableOrderingComposer,
      $$BloodCentersTableTableAnnotationComposer,
      $$BloodCentersTableTableCreateCompanionBuilder,
      $$BloodCentersTableTableUpdateCompanionBuilder,
      (
        BloodCentersTableData,
        BaseReferences<
          _$AppDatabase,
          $BloodCentersTableTable,
          BloodCentersTableData
        >,
      ),
      BloodCentersTableData,
      PrefetchHooks Function()
    >;
typedef $$ZhdkBadgeDefinitionsTableTableCreateCompanionBuilder =
    ZhdkBadgeDefinitionsTableCompanion Function({
      Value<int> id,
      required String badgeCode,
      required String name,
      Value<double?> thresholdLitersMale,
      Value<double?> thresholdLitersFemale,
      required String issuingBody,
      Value<String?> privilegesJson,
    });
typedef $$ZhdkBadgeDefinitionsTableTableUpdateCompanionBuilder =
    ZhdkBadgeDefinitionsTableCompanion Function({
      Value<int> id,
      Value<String> badgeCode,
      Value<String> name,
      Value<double?> thresholdLitersMale,
      Value<double?> thresholdLitersFemale,
      Value<String> issuingBody,
      Value<String?> privilegesJson,
    });

class $$ZhdkBadgeDefinitionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ZhdkBadgeDefinitionsTableTable> {
  $$ZhdkBadgeDefinitionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get badgeCode => $composableBuilder(
    column: $table.badgeCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get thresholdLitersMale => $composableBuilder(
    column: $table.thresholdLitersMale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get thresholdLitersFemale => $composableBuilder(
    column: $table.thresholdLitersFemale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get issuingBody => $composableBuilder(
    column: $table.issuingBody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get privilegesJson => $composableBuilder(
    column: $table.privilegesJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ZhdkBadgeDefinitionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ZhdkBadgeDefinitionsTableTable> {
  $$ZhdkBadgeDefinitionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get badgeCode => $composableBuilder(
    column: $table.badgeCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get thresholdLitersMale => $composableBuilder(
    column: $table.thresholdLitersMale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get thresholdLitersFemale => $composableBuilder(
    column: $table.thresholdLitersFemale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get issuingBody => $composableBuilder(
    column: $table.issuingBody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get privilegesJson => $composableBuilder(
    column: $table.privilegesJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ZhdkBadgeDefinitionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ZhdkBadgeDefinitionsTableTable> {
  $$ZhdkBadgeDefinitionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get badgeCode =>
      $composableBuilder(column: $table.badgeCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get thresholdLitersMale => $composableBuilder(
    column: $table.thresholdLitersMale,
    builder: (column) => column,
  );

  GeneratedColumn<double> get thresholdLitersFemale => $composableBuilder(
    column: $table.thresholdLitersFemale,
    builder: (column) => column,
  );

  GeneratedColumn<String> get issuingBody => $composableBuilder(
    column: $table.issuingBody,
    builder: (column) => column,
  );

  GeneratedColumn<String> get privilegesJson => $composableBuilder(
    column: $table.privilegesJson,
    builder: (column) => column,
  );
}

class $$ZhdkBadgeDefinitionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ZhdkBadgeDefinitionsTableTable,
          ZhdkBadgeDefinitionsTableData,
          $$ZhdkBadgeDefinitionsTableTableFilterComposer,
          $$ZhdkBadgeDefinitionsTableTableOrderingComposer,
          $$ZhdkBadgeDefinitionsTableTableAnnotationComposer,
          $$ZhdkBadgeDefinitionsTableTableCreateCompanionBuilder,
          $$ZhdkBadgeDefinitionsTableTableUpdateCompanionBuilder,
          (
            ZhdkBadgeDefinitionsTableData,
            BaseReferences<
              _$AppDatabase,
              $ZhdkBadgeDefinitionsTableTable,
              ZhdkBadgeDefinitionsTableData
            >,
          ),
          ZhdkBadgeDefinitionsTableData,
          PrefetchHooks Function()
        > {
  $$ZhdkBadgeDefinitionsTableTableTableManager(
    _$AppDatabase db,
    $ZhdkBadgeDefinitionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ZhdkBadgeDefinitionsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ZhdkBadgeDefinitionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ZhdkBadgeDefinitionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> badgeCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double?> thresholdLitersMale = const Value.absent(),
                Value<double?> thresholdLitersFemale = const Value.absent(),
                Value<String> issuingBody = const Value.absent(),
                Value<String?> privilegesJson = const Value.absent(),
              }) => ZhdkBadgeDefinitionsTableCompanion(
                id: id,
                badgeCode: badgeCode,
                name: name,
                thresholdLitersMale: thresholdLitersMale,
                thresholdLitersFemale: thresholdLitersFemale,
                issuingBody: issuingBody,
                privilegesJson: privilegesJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String badgeCode,
                required String name,
                Value<double?> thresholdLitersMale = const Value.absent(),
                Value<double?> thresholdLitersFemale = const Value.absent(),
                required String issuingBody,
                Value<String?> privilegesJson = const Value.absent(),
              }) => ZhdkBadgeDefinitionsTableCompanion.insert(
                id: id,
                badgeCode: badgeCode,
                name: name,
                thresholdLitersMale: thresholdLitersMale,
                thresholdLitersFemale: thresholdLitersFemale,
                issuingBody: issuingBody,
                privilegesJson: privilegesJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ZhdkBadgeDefinitionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ZhdkBadgeDefinitionsTableTable,
      ZhdkBadgeDefinitionsTableData,
      $$ZhdkBadgeDefinitionsTableTableFilterComposer,
      $$ZhdkBadgeDefinitionsTableTableOrderingComposer,
      $$ZhdkBadgeDefinitionsTableTableAnnotationComposer,
      $$ZhdkBadgeDefinitionsTableTableCreateCompanionBuilder,
      $$ZhdkBadgeDefinitionsTableTableUpdateCompanionBuilder,
      (
        ZhdkBadgeDefinitionsTableData,
        BaseReferences<
          _$AppDatabase,
          $ZhdkBadgeDefinitionsTableTable,
          ZhdkBadgeDefinitionsTableData
        >,
      ),
      ZhdkBadgeDefinitionsTableData,
      PrefetchHooks Function()
    >;
typedef $$DonorBadgesEarnedTableTableCreateCompanionBuilder =
    DonorBadgesEarnedTableCompanion Function({
      Value<int> id,
      required int donorProfileId,
      required int badgeId,
      required DateTime earnedDate,
      required double totalLitersAtEarn,
    });
typedef $$DonorBadgesEarnedTableTableUpdateCompanionBuilder =
    DonorBadgesEarnedTableCompanion Function({
      Value<int> id,
      Value<int> donorProfileId,
      Value<int> badgeId,
      Value<DateTime> earnedDate,
      Value<double> totalLitersAtEarn,
    });

class $$DonorBadgesEarnedTableTableFilterComposer
    extends Composer<_$AppDatabase, $DonorBadgesEarnedTableTable> {
  $$DonorBadgesEarnedTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get badgeId => $composableBuilder(
    column: $table.badgeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get earnedDate => $composableBuilder(
    column: $table.earnedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalLitersAtEarn => $composableBuilder(
    column: $table.totalLitersAtEarn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DonorBadgesEarnedTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DonorBadgesEarnedTableTable> {
  $$DonorBadgesEarnedTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get badgeId => $composableBuilder(
    column: $table.badgeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get earnedDate => $composableBuilder(
    column: $table.earnedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalLitersAtEarn => $composableBuilder(
    column: $table.totalLitersAtEarn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DonorBadgesEarnedTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DonorBadgesEarnedTableTable> {
  $$DonorBadgesEarnedTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get badgeId =>
      $composableBuilder(column: $table.badgeId, builder: (column) => column);

  GeneratedColumn<DateTime> get earnedDate => $composableBuilder(
    column: $table.earnedDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalLitersAtEarn => $composableBuilder(
    column: $table.totalLitersAtEarn,
    builder: (column) => column,
  );
}

class $$DonorBadgesEarnedTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DonorBadgesEarnedTableTable,
          DonorBadgesEarnedTableData,
          $$DonorBadgesEarnedTableTableFilterComposer,
          $$DonorBadgesEarnedTableTableOrderingComposer,
          $$DonorBadgesEarnedTableTableAnnotationComposer,
          $$DonorBadgesEarnedTableTableCreateCompanionBuilder,
          $$DonorBadgesEarnedTableTableUpdateCompanionBuilder,
          (
            DonorBadgesEarnedTableData,
            BaseReferences<
              _$AppDatabase,
              $DonorBadgesEarnedTableTable,
              DonorBadgesEarnedTableData
            >,
          ),
          DonorBadgesEarnedTableData,
          PrefetchHooks Function()
        > {
  $$DonorBadgesEarnedTableTableTableManager(
    _$AppDatabase db,
    $DonorBadgesEarnedTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DonorBadgesEarnedTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DonorBadgesEarnedTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DonorBadgesEarnedTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> donorProfileId = const Value.absent(),
                Value<int> badgeId = const Value.absent(),
                Value<DateTime> earnedDate = const Value.absent(),
                Value<double> totalLitersAtEarn = const Value.absent(),
              }) => DonorBadgesEarnedTableCompanion(
                id: id,
                donorProfileId: donorProfileId,
                badgeId: badgeId,
                earnedDate: earnedDate,
                totalLitersAtEarn: totalLitersAtEarn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int donorProfileId,
                required int badgeId,
                required DateTime earnedDate,
                required double totalLitersAtEarn,
              }) => DonorBadgesEarnedTableCompanion.insert(
                id: id,
                donorProfileId: donorProfileId,
                badgeId: badgeId,
                earnedDate: earnedDate,
                totalLitersAtEarn: totalLitersAtEarn,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DonorBadgesEarnedTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DonorBadgesEarnedTableTable,
      DonorBadgesEarnedTableData,
      $$DonorBadgesEarnedTableTableFilterComposer,
      $$DonorBadgesEarnedTableTableOrderingComposer,
      $$DonorBadgesEarnedTableTableAnnotationComposer,
      $$DonorBadgesEarnedTableTableCreateCompanionBuilder,
      $$DonorBadgesEarnedTableTableUpdateCompanionBuilder,
      (
        DonorBadgesEarnedTableData,
        BaseReferences<
          _$AppDatabase,
          $DonorBadgesEarnedTableTable,
          DonorBadgesEarnedTableData
        >,
      ),
      DonorBadgesEarnedTableData,
      PrefetchHooks Function()
    >;
typedef $$NotificationLogTableTableCreateCompanionBuilder =
    NotificationLogTableCompanion Function({
      Value<int> id,
      required int donorProfileId,
      required String notificationType,
      required DateTime scheduledAt,
      Value<DateTime?> sentAt,
      Value<bool> isDismissed,
      Value<String?> payloadJson,
    });
typedef $$NotificationLogTableTableUpdateCompanionBuilder =
    NotificationLogTableCompanion Function({
      Value<int> id,
      Value<int> donorProfileId,
      Value<String> notificationType,
      Value<DateTime> scheduledAt,
      Value<DateTime?> sentAt,
      Value<bool> isDismissed,
      Value<String?> payloadJson,
    });

class $$NotificationLogTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationLogTableTable> {
  $$NotificationLogTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notificationType => $composableBuilder(
    column: $table.notificationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationLogTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationLogTableTable> {
  $$NotificationLogTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notificationType => $composableBuilder(
    column: $table.notificationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationLogTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationLogTableTable> {
  $$NotificationLogTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notificationType => $composableBuilder(
    column: $table.notificationType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<bool> get isDismissed => $composableBuilder(
    column: $table.isDismissed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );
}

class $$NotificationLogTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationLogTableTable,
          NotificationLogTableData,
          $$NotificationLogTableTableFilterComposer,
          $$NotificationLogTableTableOrderingComposer,
          $$NotificationLogTableTableAnnotationComposer,
          $$NotificationLogTableTableCreateCompanionBuilder,
          $$NotificationLogTableTableUpdateCompanionBuilder,
          (
            NotificationLogTableData,
            BaseReferences<
              _$AppDatabase,
              $NotificationLogTableTable,
              NotificationLogTableData
            >,
          ),
          NotificationLogTableData,
          PrefetchHooks Function()
        > {
  $$NotificationLogTableTableTableManager(
    _$AppDatabase db,
    $NotificationLogTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationLogTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationLogTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationLogTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> donorProfileId = const Value.absent(),
                Value<String> notificationType = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
                Value<bool> isDismissed = const Value.absent(),
                Value<String?> payloadJson = const Value.absent(),
              }) => NotificationLogTableCompanion(
                id: id,
                donorProfileId: donorProfileId,
                notificationType: notificationType,
                scheduledAt: scheduledAt,
                sentAt: sentAt,
                isDismissed: isDismissed,
                payloadJson: payloadJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int donorProfileId,
                required String notificationType,
                required DateTime scheduledAt,
                Value<DateTime?> sentAt = const Value.absent(),
                Value<bool> isDismissed = const Value.absent(),
                Value<String?> payloadJson = const Value.absent(),
              }) => NotificationLogTableCompanion.insert(
                id: id,
                donorProfileId: donorProfileId,
                notificationType: notificationType,
                scheduledAt: scheduledAt,
                sentAt: sentAt,
                isDismissed: isDismissed,
                payloadJson: payloadJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationLogTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationLogTableTable,
      NotificationLogTableData,
      $$NotificationLogTableTableFilterComposer,
      $$NotificationLogTableTableOrderingComposer,
      $$NotificationLogTableTableAnnotationComposer,
      $$NotificationLogTableTableCreateCompanionBuilder,
      $$NotificationLogTableTableUpdateCompanionBuilder,
      (
        NotificationLogTableData,
        BaseReferences<
          _$AppDatabase,
          $NotificationLogTableTable,
          NotificationLogTableData
        >,
      ),
      NotificationLogTableData,
      PrefetchHooks Function()
    >;
typedef $$PitAnnualSummaryTableTableCreateCompanionBuilder =
    PitAnnualSummaryTableCompanion Function({
      Value<int> id,
      required int donorProfileId,
      required int taxYear,
      required int totalVolumeMl,
      required double ratePlnPerLiter,
      required double grossDeductionPln,
      required double income6PctCap,
      required double netDeductionPln,
      Value<DateTime> lastCalculatedAt,
    });
typedef $$PitAnnualSummaryTableTableUpdateCompanionBuilder =
    PitAnnualSummaryTableCompanion Function({
      Value<int> id,
      Value<int> donorProfileId,
      Value<int> taxYear,
      Value<int> totalVolumeMl,
      Value<double> ratePlnPerLiter,
      Value<double> grossDeductionPln,
      Value<double> income6PctCap,
      Value<double> netDeductionPln,
      Value<DateTime> lastCalculatedAt,
    });

class $$PitAnnualSummaryTableTableFilterComposer
    extends Composer<_$AppDatabase, $PitAnnualSummaryTableTable> {
  $$PitAnnualSummaryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxYear => $composableBuilder(
    column: $table.taxYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalVolumeMl => $composableBuilder(
    column: $table.totalVolumeMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ratePlnPerLiter => $composableBuilder(
    column: $table.ratePlnPerLiter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grossDeductionPln => $composableBuilder(
    column: $table.grossDeductionPln,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get income6PctCap => $composableBuilder(
    column: $table.income6PctCap,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netDeductionPln => $composableBuilder(
    column: $table.netDeductionPln,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCalculatedAt => $composableBuilder(
    column: $table.lastCalculatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PitAnnualSummaryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PitAnnualSummaryTableTable> {
  $$PitAnnualSummaryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxYear => $composableBuilder(
    column: $table.taxYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalVolumeMl => $composableBuilder(
    column: $table.totalVolumeMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ratePlnPerLiter => $composableBuilder(
    column: $table.ratePlnPerLiter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grossDeductionPln => $composableBuilder(
    column: $table.grossDeductionPln,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get income6PctCap => $composableBuilder(
    column: $table.income6PctCap,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netDeductionPln => $composableBuilder(
    column: $table.netDeductionPln,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCalculatedAt => $composableBuilder(
    column: $table.lastCalculatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PitAnnualSummaryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PitAnnualSummaryTableTable> {
  $$PitAnnualSummaryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get donorProfileId => $composableBuilder(
    column: $table.donorProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxYear =>
      $composableBuilder(column: $table.taxYear, builder: (column) => column);

  GeneratedColumn<int> get totalVolumeMl => $composableBuilder(
    column: $table.totalVolumeMl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ratePlnPerLiter => $composableBuilder(
    column: $table.ratePlnPerLiter,
    builder: (column) => column,
  );

  GeneratedColumn<double> get grossDeductionPln => $composableBuilder(
    column: $table.grossDeductionPln,
    builder: (column) => column,
  );

  GeneratedColumn<double> get income6PctCap => $composableBuilder(
    column: $table.income6PctCap,
    builder: (column) => column,
  );

  GeneratedColumn<double> get netDeductionPln => $composableBuilder(
    column: $table.netDeductionPln,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastCalculatedAt => $composableBuilder(
    column: $table.lastCalculatedAt,
    builder: (column) => column,
  );
}

class $$PitAnnualSummaryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PitAnnualSummaryTableTable,
          PitAnnualSummaryTableData,
          $$PitAnnualSummaryTableTableFilterComposer,
          $$PitAnnualSummaryTableTableOrderingComposer,
          $$PitAnnualSummaryTableTableAnnotationComposer,
          $$PitAnnualSummaryTableTableCreateCompanionBuilder,
          $$PitAnnualSummaryTableTableUpdateCompanionBuilder,
          (
            PitAnnualSummaryTableData,
            BaseReferences<
              _$AppDatabase,
              $PitAnnualSummaryTableTable,
              PitAnnualSummaryTableData
            >,
          ),
          PitAnnualSummaryTableData,
          PrefetchHooks Function()
        > {
  $$PitAnnualSummaryTableTableTableManager(
    _$AppDatabase db,
    $PitAnnualSummaryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PitAnnualSummaryTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PitAnnualSummaryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PitAnnualSummaryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> donorProfileId = const Value.absent(),
                Value<int> taxYear = const Value.absent(),
                Value<int> totalVolumeMl = const Value.absent(),
                Value<double> ratePlnPerLiter = const Value.absent(),
                Value<double> grossDeductionPln = const Value.absent(),
                Value<double> income6PctCap = const Value.absent(),
                Value<double> netDeductionPln = const Value.absent(),
                Value<DateTime> lastCalculatedAt = const Value.absent(),
              }) => PitAnnualSummaryTableCompanion(
                id: id,
                donorProfileId: donorProfileId,
                taxYear: taxYear,
                totalVolumeMl: totalVolumeMl,
                ratePlnPerLiter: ratePlnPerLiter,
                grossDeductionPln: grossDeductionPln,
                income6PctCap: income6PctCap,
                netDeductionPln: netDeductionPln,
                lastCalculatedAt: lastCalculatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int donorProfileId,
                required int taxYear,
                required int totalVolumeMl,
                required double ratePlnPerLiter,
                required double grossDeductionPln,
                required double income6PctCap,
                required double netDeductionPln,
                Value<DateTime> lastCalculatedAt = const Value.absent(),
              }) => PitAnnualSummaryTableCompanion.insert(
                id: id,
                donorProfileId: donorProfileId,
                taxYear: taxYear,
                totalVolumeMl: totalVolumeMl,
                ratePlnPerLiter: ratePlnPerLiter,
                grossDeductionPln: grossDeductionPln,
                income6PctCap: income6PctCap,
                netDeductionPln: netDeductionPln,
                lastCalculatedAt: lastCalculatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PitAnnualSummaryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PitAnnualSummaryTableTable,
      PitAnnualSummaryTableData,
      $$PitAnnualSummaryTableTableFilterComposer,
      $$PitAnnualSummaryTableTableOrderingComposer,
      $$PitAnnualSummaryTableTableAnnotationComposer,
      $$PitAnnualSummaryTableTableCreateCompanionBuilder,
      $$PitAnnualSummaryTableTableUpdateCompanionBuilder,
      (
        PitAnnualSummaryTableData,
        BaseReferences<
          _$AppDatabase,
          $PitAnnualSummaryTableTable,
          PitAnnualSummaryTableData
        >,
      ),
      PitAnnualSummaryTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DonorProfileTableTableTableManager get donorProfileTable =>
      $$DonorProfileTableTableTableManager(_db, _db.donorProfileTable);
  $$DonationsTableTableTableManager get donationsTable =>
      $$DonationsTableTableTableManager(_db, _db.donationsTable);
  $$MenstrualCyclesTableTableTableManager get menstrualCyclesTable =>
      $$MenstrualCyclesTableTableTableManager(_db, _db.menstrualCyclesTable);
  $$MorphologyResultsTableTableTableManager get morphologyResultsTable =>
      $$MorphologyResultsTableTableTableManager(
        _db,
        _db.morphologyResultsTable,
      );
  $$BloodCentersTableTableTableManager get bloodCentersTable =>
      $$BloodCentersTableTableTableManager(_db, _db.bloodCentersTable);
  $$ZhdkBadgeDefinitionsTableTableTableManager get zhdkBadgeDefinitionsTable =>
      $$ZhdkBadgeDefinitionsTableTableTableManager(
        _db,
        _db.zhdkBadgeDefinitionsTable,
      );
  $$DonorBadgesEarnedTableTableTableManager get donorBadgesEarnedTable =>
      $$DonorBadgesEarnedTableTableTableManager(
        _db,
        _db.donorBadgesEarnedTable,
      );
  $$NotificationLogTableTableTableManager get notificationLogTable =>
      $$NotificationLogTableTableTableManager(_db, _db.notificationLogTable);
  $$PitAnnualSummaryTableTableTableManager get pitAnnualSummaryTable =>
      $$PitAnnualSummaryTableTableTableManager(_db, _db.pitAnnualSummaryTable);
}
