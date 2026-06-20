// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HistoryEntriesTable extends HistoryEntries
    with TableInfo<$HistoryEntriesTable, HistoryEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _timestampMsMeta = const VerificationMeta(
    'timestampMs',
  );
  @override
  late final GeneratedColumn<int> timestampMs = GeneratedColumn<int>(
    'timestamp_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entryTypeMeta = const VerificationMeta(
    'entryType',
  );
  @override
  late final GeneratedColumn<String> entryType = GeneratedColumn<String>(
    'entry_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taskTitleSnapshotMeta = const VerificationMeta(
    'taskTitleSnapshot',
  );
  @override
  late final GeneratedColumn<String> taskTitleSnapshot =
      GeneratedColumn<String>(
        'task_title_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _focusAreaIdMeta = const VerificationMeta(
    'focusAreaId',
  );
  @override
  late final GeneratedColumn<String> focusAreaId = GeneratedColumn<String>(
    'focus_area_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attemptOutcomeMeta = const VerificationMeta(
    'attemptOutcome',
  );
  @override
  late final GeneratedColumn<String> attemptOutcome = GeneratedColumn<String>(
    'attempt_outcome',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _eventActionMeta = const VerificationMeta(
    'eventAction',
  );
  @override
  late final GeneratedColumn<String> eventAction = GeneratedColumn<String>(
    'event_action',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _eventLabelMeta = const VerificationMeta(
    'eventLabel',
  );
  @override
  late final GeneratedColumn<String> eventLabel = GeneratedColumn<String>(
    'event_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wasEnergiskChainFollowUpMeta =
      const VerificationMeta('wasEnergiskChainFollowUp');
  @override
  late final GeneratedColumn<bool> wasEnergiskChainFollowUp =
      GeneratedColumn<bool>(
        'was_energisk_chain_follow_up',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("was_energisk_chain_follow_up" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestampMs,
    entryType,
    taskId,
    taskTitleSnapshot,
    focusAreaId,
    attemptOutcome,
    mood,
    eventId,
    eventAction,
    eventLabel,
    wasEnergiskChainFollowUp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistoryEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp_ms')) {
      context.handle(
        _timestampMsMeta,
        timestampMs.isAcceptableOrUnknown(
          data['timestamp_ms']!,
          _timestampMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampMsMeta);
    }
    if (data.containsKey('entry_type')) {
      context.handle(
        _entryTypeMeta,
        entryType.isAcceptableOrUnknown(data['entry_type']!, _entryTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entryTypeMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    }
    if (data.containsKey('task_title_snapshot')) {
      context.handle(
        _taskTitleSnapshotMeta,
        taskTitleSnapshot.isAcceptableOrUnknown(
          data['task_title_snapshot']!,
          _taskTitleSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('focus_area_id')) {
      context.handle(
        _focusAreaIdMeta,
        focusAreaId.isAcceptableOrUnknown(
          data['focus_area_id']!,
          _focusAreaIdMeta,
        ),
      );
    }
    if (data.containsKey('attempt_outcome')) {
      context.handle(
        _attemptOutcomeMeta,
        attemptOutcome.isAcceptableOrUnknown(
          data['attempt_outcome']!,
          _attemptOutcomeMeta,
        ),
      );
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    }
    if (data.containsKey('event_action')) {
      context.handle(
        _eventActionMeta,
        eventAction.isAcceptableOrUnknown(
          data['event_action']!,
          _eventActionMeta,
        ),
      );
    }
    if (data.containsKey('event_label')) {
      context.handle(
        _eventLabelMeta,
        eventLabel.isAcceptableOrUnknown(data['event_label']!, _eventLabelMeta),
      );
    }
    if (data.containsKey('was_energisk_chain_follow_up')) {
      context.handle(
        _wasEnergiskChainFollowUpMeta,
        wasEnergiskChainFollowUp.isAcceptableOrUnknown(
          data['was_energisk_chain_follow_up']!,
          _wasEnergiskChainFollowUpMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      timestampMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_ms'],
      )!,
      entryType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_type'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      ),
      taskTitleSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_title_snapshot'],
      ),
      focusAreaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}focus_area_id'],
      ),
      attemptOutcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attempt_outcome'],
      ),
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      ),
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      ),
      eventAction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_action'],
      ),
      eventLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_label'],
      ),
      wasEnergiskChainFollowUp: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_energisk_chain_follow_up'],
      )!,
    );
  }

  @override
  $HistoryEntriesTable createAlias(String alias) {
    return $HistoryEntriesTable(attachedDatabase, alias);
  }
}

class HistoryEntryRow extends DataClass implements Insertable<HistoryEntryRow> {
  final int id;
  final int timestampMs;
  final String entryType;
  final String? taskId;
  final String? taskTitleSnapshot;
  final String? focusAreaId;
  final String? attemptOutcome;
  final String? mood;
  final String? eventId;
  final String? eventAction;
  final String? eventLabel;
  final bool wasEnergiskChainFollowUp;
  const HistoryEntryRow({
    required this.id,
    required this.timestampMs,
    required this.entryType,
    this.taskId,
    this.taskTitleSnapshot,
    this.focusAreaId,
    this.attemptOutcome,
    this.mood,
    this.eventId,
    this.eventAction,
    this.eventLabel,
    required this.wasEnergiskChainFollowUp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['timestamp_ms'] = Variable<int>(timestampMs);
    map['entry_type'] = Variable<String>(entryType);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    if (!nullToAbsent || taskTitleSnapshot != null) {
      map['task_title_snapshot'] = Variable<String>(taskTitleSnapshot);
    }
    if (!nullToAbsent || focusAreaId != null) {
      map['focus_area_id'] = Variable<String>(focusAreaId);
    }
    if (!nullToAbsent || attemptOutcome != null) {
      map['attempt_outcome'] = Variable<String>(attemptOutcome);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<String>(eventId);
    }
    if (!nullToAbsent || eventAction != null) {
      map['event_action'] = Variable<String>(eventAction);
    }
    if (!nullToAbsent || eventLabel != null) {
      map['event_label'] = Variable<String>(eventLabel);
    }
    map['was_energisk_chain_follow_up'] = Variable<bool>(
      wasEnergiskChainFollowUp,
    );
    return map;
  }

  HistoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return HistoryEntriesCompanion(
      id: Value(id),
      timestampMs: Value(timestampMs),
      entryType: Value(entryType),
      taskId: taskId == null && nullToAbsent
          ? const Value.absent()
          : Value(taskId),
      taskTitleSnapshot: taskTitleSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(taskTitleSnapshot),
      focusAreaId: focusAreaId == null && nullToAbsent
          ? const Value.absent()
          : Value(focusAreaId),
      attemptOutcome: attemptOutcome == null && nullToAbsent
          ? const Value.absent()
          : Value(attemptOutcome),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
      eventAction: eventAction == null && nullToAbsent
          ? const Value.absent()
          : Value(eventAction),
      eventLabel: eventLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(eventLabel),
      wasEnergiskChainFollowUp: Value(wasEnergiskChainFollowUp),
    );
  }

  factory HistoryEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryEntryRow(
      id: serializer.fromJson<int>(json['id']),
      timestampMs: serializer.fromJson<int>(json['timestampMs']),
      entryType: serializer.fromJson<String>(json['entryType']),
      taskId: serializer.fromJson<String?>(json['taskId']),
      taskTitleSnapshot: serializer.fromJson<String?>(
        json['taskTitleSnapshot'],
      ),
      focusAreaId: serializer.fromJson<String?>(json['focusAreaId']),
      attemptOutcome: serializer.fromJson<String?>(json['attemptOutcome']),
      mood: serializer.fromJson<String?>(json['mood']),
      eventId: serializer.fromJson<String?>(json['eventId']),
      eventAction: serializer.fromJson<String?>(json['eventAction']),
      eventLabel: serializer.fromJson<String?>(json['eventLabel']),
      wasEnergiskChainFollowUp: serializer.fromJson<bool>(
        json['wasEnergiskChainFollowUp'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timestampMs': serializer.toJson<int>(timestampMs),
      'entryType': serializer.toJson<String>(entryType),
      'taskId': serializer.toJson<String?>(taskId),
      'taskTitleSnapshot': serializer.toJson<String?>(taskTitleSnapshot),
      'focusAreaId': serializer.toJson<String?>(focusAreaId),
      'attemptOutcome': serializer.toJson<String?>(attemptOutcome),
      'mood': serializer.toJson<String?>(mood),
      'eventId': serializer.toJson<String?>(eventId),
      'eventAction': serializer.toJson<String?>(eventAction),
      'eventLabel': serializer.toJson<String?>(eventLabel),
      'wasEnergiskChainFollowUp': serializer.toJson<bool>(
        wasEnergiskChainFollowUp,
      ),
    };
  }

  HistoryEntryRow copyWith({
    int? id,
    int? timestampMs,
    String? entryType,
    Value<String?> taskId = const Value.absent(),
    Value<String?> taskTitleSnapshot = const Value.absent(),
    Value<String?> focusAreaId = const Value.absent(),
    Value<String?> attemptOutcome = const Value.absent(),
    Value<String?> mood = const Value.absent(),
    Value<String?> eventId = const Value.absent(),
    Value<String?> eventAction = const Value.absent(),
    Value<String?> eventLabel = const Value.absent(),
    bool? wasEnergiskChainFollowUp,
  }) => HistoryEntryRow(
    id: id ?? this.id,
    timestampMs: timestampMs ?? this.timestampMs,
    entryType: entryType ?? this.entryType,
    taskId: taskId.present ? taskId.value : this.taskId,
    taskTitleSnapshot: taskTitleSnapshot.present
        ? taskTitleSnapshot.value
        : this.taskTitleSnapshot,
    focusAreaId: focusAreaId.present ? focusAreaId.value : this.focusAreaId,
    attemptOutcome: attemptOutcome.present
        ? attemptOutcome.value
        : this.attemptOutcome,
    mood: mood.present ? mood.value : this.mood,
    eventId: eventId.present ? eventId.value : this.eventId,
    eventAction: eventAction.present ? eventAction.value : this.eventAction,
    eventLabel: eventLabel.present ? eventLabel.value : this.eventLabel,
    wasEnergiskChainFollowUp:
        wasEnergiskChainFollowUp ?? this.wasEnergiskChainFollowUp,
  );
  HistoryEntryRow copyWithCompanion(HistoryEntriesCompanion data) {
    return HistoryEntryRow(
      id: data.id.present ? data.id.value : this.id,
      timestampMs: data.timestampMs.present
          ? data.timestampMs.value
          : this.timestampMs,
      entryType: data.entryType.present ? data.entryType.value : this.entryType,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      taskTitleSnapshot: data.taskTitleSnapshot.present
          ? data.taskTitleSnapshot.value
          : this.taskTitleSnapshot,
      focusAreaId: data.focusAreaId.present
          ? data.focusAreaId.value
          : this.focusAreaId,
      attemptOutcome: data.attemptOutcome.present
          ? data.attemptOutcome.value
          : this.attemptOutcome,
      mood: data.mood.present ? data.mood.value : this.mood,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      eventAction: data.eventAction.present
          ? data.eventAction.value
          : this.eventAction,
      eventLabel: data.eventLabel.present
          ? data.eventLabel.value
          : this.eventLabel,
      wasEnergiskChainFollowUp: data.wasEnergiskChainFollowUp.present
          ? data.wasEnergiskChainFollowUp.value
          : this.wasEnergiskChainFollowUp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntryRow(')
          ..write('id: $id, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('entryType: $entryType, ')
          ..write('taskId: $taskId, ')
          ..write('taskTitleSnapshot: $taskTitleSnapshot, ')
          ..write('focusAreaId: $focusAreaId, ')
          ..write('attemptOutcome: $attemptOutcome, ')
          ..write('mood: $mood, ')
          ..write('eventId: $eventId, ')
          ..write('eventAction: $eventAction, ')
          ..write('eventLabel: $eventLabel, ')
          ..write('wasEnergiskChainFollowUp: $wasEnergiskChainFollowUp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timestampMs,
    entryType,
    taskId,
    taskTitleSnapshot,
    focusAreaId,
    attemptOutcome,
    mood,
    eventId,
    eventAction,
    eventLabel,
    wasEnergiskChainFollowUp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryEntryRow &&
          other.id == this.id &&
          other.timestampMs == this.timestampMs &&
          other.entryType == this.entryType &&
          other.taskId == this.taskId &&
          other.taskTitleSnapshot == this.taskTitleSnapshot &&
          other.focusAreaId == this.focusAreaId &&
          other.attemptOutcome == this.attemptOutcome &&
          other.mood == this.mood &&
          other.eventId == this.eventId &&
          other.eventAction == this.eventAction &&
          other.eventLabel == this.eventLabel &&
          other.wasEnergiskChainFollowUp == this.wasEnergiskChainFollowUp);
}

class HistoryEntriesCompanion extends UpdateCompanion<HistoryEntryRow> {
  final Value<int> id;
  final Value<int> timestampMs;
  final Value<String> entryType;
  final Value<String?> taskId;
  final Value<String?> taskTitleSnapshot;
  final Value<String?> focusAreaId;
  final Value<String?> attemptOutcome;
  final Value<String?> mood;
  final Value<String?> eventId;
  final Value<String?> eventAction;
  final Value<String?> eventLabel;
  final Value<bool> wasEnergiskChainFollowUp;
  const HistoryEntriesCompanion({
    this.id = const Value.absent(),
    this.timestampMs = const Value.absent(),
    this.entryType = const Value.absent(),
    this.taskId = const Value.absent(),
    this.taskTitleSnapshot = const Value.absent(),
    this.focusAreaId = const Value.absent(),
    this.attemptOutcome = const Value.absent(),
    this.mood = const Value.absent(),
    this.eventId = const Value.absent(),
    this.eventAction = const Value.absent(),
    this.eventLabel = const Value.absent(),
    this.wasEnergiskChainFollowUp = const Value.absent(),
  });
  HistoryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int timestampMs,
    required String entryType,
    this.taskId = const Value.absent(),
    this.taskTitleSnapshot = const Value.absent(),
    this.focusAreaId = const Value.absent(),
    this.attemptOutcome = const Value.absent(),
    this.mood = const Value.absent(),
    this.eventId = const Value.absent(),
    this.eventAction = const Value.absent(),
    this.eventLabel = const Value.absent(),
    this.wasEnergiskChainFollowUp = const Value.absent(),
  }) : timestampMs = Value(timestampMs),
       entryType = Value(entryType);
  static Insertable<HistoryEntryRow> custom({
    Expression<int>? id,
    Expression<int>? timestampMs,
    Expression<String>? entryType,
    Expression<String>? taskId,
    Expression<String>? taskTitleSnapshot,
    Expression<String>? focusAreaId,
    Expression<String>? attemptOutcome,
    Expression<String>? mood,
    Expression<String>? eventId,
    Expression<String>? eventAction,
    Expression<String>? eventLabel,
    Expression<bool>? wasEnergiskChainFollowUp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestampMs != null) 'timestamp_ms': timestampMs,
      if (entryType != null) 'entry_type': entryType,
      if (taskId != null) 'task_id': taskId,
      if (taskTitleSnapshot != null) 'task_title_snapshot': taskTitleSnapshot,
      if (focusAreaId != null) 'focus_area_id': focusAreaId,
      if (attemptOutcome != null) 'attempt_outcome': attemptOutcome,
      if (mood != null) 'mood': mood,
      if (eventId != null) 'event_id': eventId,
      if (eventAction != null) 'event_action': eventAction,
      if (eventLabel != null) 'event_label': eventLabel,
      if (wasEnergiskChainFollowUp != null)
        'was_energisk_chain_follow_up': wasEnergiskChainFollowUp,
    });
  }

  HistoryEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? timestampMs,
    Value<String>? entryType,
    Value<String?>? taskId,
    Value<String?>? taskTitleSnapshot,
    Value<String?>? focusAreaId,
    Value<String?>? attemptOutcome,
    Value<String?>? mood,
    Value<String?>? eventId,
    Value<String?>? eventAction,
    Value<String?>? eventLabel,
    Value<bool>? wasEnergiskChainFollowUp,
  }) {
    return HistoryEntriesCompanion(
      id: id ?? this.id,
      timestampMs: timestampMs ?? this.timestampMs,
      entryType: entryType ?? this.entryType,
      taskId: taskId ?? this.taskId,
      taskTitleSnapshot: taskTitleSnapshot ?? this.taskTitleSnapshot,
      focusAreaId: focusAreaId ?? this.focusAreaId,
      attemptOutcome: attemptOutcome ?? this.attemptOutcome,
      mood: mood ?? this.mood,
      eventId: eventId ?? this.eventId,
      eventAction: eventAction ?? this.eventAction,
      eventLabel: eventLabel ?? this.eventLabel,
      wasEnergiskChainFollowUp:
          wasEnergiskChainFollowUp ?? this.wasEnergiskChainFollowUp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timestampMs.present) {
      map['timestamp_ms'] = Variable<int>(timestampMs.value);
    }
    if (entryType.present) {
      map['entry_type'] = Variable<String>(entryType.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (taskTitleSnapshot.present) {
      map['task_title_snapshot'] = Variable<String>(taskTitleSnapshot.value);
    }
    if (focusAreaId.present) {
      map['focus_area_id'] = Variable<String>(focusAreaId.value);
    }
    if (attemptOutcome.present) {
      map['attempt_outcome'] = Variable<String>(attemptOutcome.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (eventAction.present) {
      map['event_action'] = Variable<String>(eventAction.value);
    }
    if (eventLabel.present) {
      map['event_label'] = Variable<String>(eventLabel.value);
    }
    if (wasEnergiskChainFollowUp.present) {
      map['was_energisk_chain_follow_up'] = Variable<bool>(
        wasEnergiskChainFollowUp.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('entryType: $entryType, ')
          ..write('taskId: $taskId, ')
          ..write('taskTitleSnapshot: $taskTitleSnapshot, ')
          ..write('focusAreaId: $focusAreaId, ')
          ..write('attemptOutcome: $attemptOutcome, ')
          ..write('mood: $mood, ')
          ..write('eventId: $eventId, ')
          ..write('eventAction: $eventAction, ')
          ..write('eventLabel: $eventLabel, ')
          ..write('wasEnergiskChainFollowUp: $wasEnergiskChainFollowUp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HistoryEntriesTable historyEntries = $HistoryEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [historyEntries];
}

typedef $$HistoryEntriesTableCreateCompanionBuilder =
    HistoryEntriesCompanion Function({
      Value<int> id,
      required int timestampMs,
      required String entryType,
      Value<String?> taskId,
      Value<String?> taskTitleSnapshot,
      Value<String?> focusAreaId,
      Value<String?> attemptOutcome,
      Value<String?> mood,
      Value<String?> eventId,
      Value<String?> eventAction,
      Value<String?> eventLabel,
      Value<bool> wasEnergiskChainFollowUp,
    });
typedef $$HistoryEntriesTableUpdateCompanionBuilder =
    HistoryEntriesCompanion Function({
      Value<int> id,
      Value<int> timestampMs,
      Value<String> entryType,
      Value<String?> taskId,
      Value<String?> taskTitleSnapshot,
      Value<String?> focusAreaId,
      Value<String?> attemptOutcome,
      Value<String?> mood,
      Value<String?> eventId,
      Value<String?> eventAction,
      Value<String?> eventLabel,
      Value<bool> wasEnergiskChainFollowUp,
    });

class $$HistoryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $HistoryEntriesTable> {
  $$HistoryEntriesTableFilterComposer({
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

  ColumnFilters<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryType => $composableBuilder(
    column: $table.entryType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskTitleSnapshot => $composableBuilder(
    column: $table.taskTitleSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get focusAreaId => $composableBuilder(
    column: $table.focusAreaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attemptOutcome => $composableBuilder(
    column: $table.attemptOutcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventAction => $composableBuilder(
    column: $table.eventAction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventLabel => $composableBuilder(
    column: $table.eventLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasEnergiskChainFollowUp => $composableBuilder(
    column: $table.wasEnergiskChainFollowUp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HistoryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoryEntriesTable> {
  $$HistoryEntriesTableOrderingComposer({
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

  ColumnOrderings<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryType => $composableBuilder(
    column: $table.entryType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskTitleSnapshot => $composableBuilder(
    column: $table.taskTitleSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get focusAreaId => $composableBuilder(
    column: $table.focusAreaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attemptOutcome => $composableBuilder(
    column: $table.attemptOutcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventAction => $composableBuilder(
    column: $table.eventAction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventLabel => $composableBuilder(
    column: $table.eventLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasEnergiskChainFollowUp => $composableBuilder(
    column: $table.wasEnergiskChainFollowUp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HistoryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoryEntriesTable> {
  $$HistoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entryType =>
      $composableBuilder(column: $table.entryType, builder: (column) => column);

  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<String> get taskTitleSnapshot => $composableBuilder(
    column: $table.taskTitleSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get focusAreaId => $composableBuilder(
    column: $table.focusAreaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attemptOutcome => $composableBuilder(
    column: $table.attemptOutcome,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get eventAction => $composableBuilder(
    column: $table.eventAction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventLabel => $composableBuilder(
    column: $table.eventLabel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get wasEnergiskChainFollowUp => $composableBuilder(
    column: $table.wasEnergiskChainFollowUp,
    builder: (column) => column,
  );
}

class $$HistoryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistoryEntriesTable,
          HistoryEntryRow,
          $$HistoryEntriesTableFilterComposer,
          $$HistoryEntriesTableOrderingComposer,
          $$HistoryEntriesTableAnnotationComposer,
          $$HistoryEntriesTableCreateCompanionBuilder,
          $$HistoryEntriesTableUpdateCompanionBuilder,
          (
            HistoryEntryRow,
            BaseReferences<
              _$AppDatabase,
              $HistoryEntriesTable,
              HistoryEntryRow
            >,
          ),
          HistoryEntryRow,
          PrefetchHooks Function()
        > {
  $$HistoryEntriesTableTableManager(
    _$AppDatabase db,
    $HistoryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> timestampMs = const Value.absent(),
                Value<String> entryType = const Value.absent(),
                Value<String?> taskId = const Value.absent(),
                Value<String?> taskTitleSnapshot = const Value.absent(),
                Value<String?> focusAreaId = const Value.absent(),
                Value<String?> attemptOutcome = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<String?> eventId = const Value.absent(),
                Value<String?> eventAction = const Value.absent(),
                Value<String?> eventLabel = const Value.absent(),
                Value<bool> wasEnergiskChainFollowUp = const Value.absent(),
              }) => HistoryEntriesCompanion(
                id: id,
                timestampMs: timestampMs,
                entryType: entryType,
                taskId: taskId,
                taskTitleSnapshot: taskTitleSnapshot,
                focusAreaId: focusAreaId,
                attemptOutcome: attemptOutcome,
                mood: mood,
                eventId: eventId,
                eventAction: eventAction,
                eventLabel: eventLabel,
                wasEnergiskChainFollowUp: wasEnergiskChainFollowUp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int timestampMs,
                required String entryType,
                Value<String?> taskId = const Value.absent(),
                Value<String?> taskTitleSnapshot = const Value.absent(),
                Value<String?> focusAreaId = const Value.absent(),
                Value<String?> attemptOutcome = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<String?> eventId = const Value.absent(),
                Value<String?> eventAction = const Value.absent(),
                Value<String?> eventLabel = const Value.absent(),
                Value<bool> wasEnergiskChainFollowUp = const Value.absent(),
              }) => HistoryEntriesCompanion.insert(
                id: id,
                timestampMs: timestampMs,
                entryType: entryType,
                taskId: taskId,
                taskTitleSnapshot: taskTitleSnapshot,
                focusAreaId: focusAreaId,
                attemptOutcome: attemptOutcome,
                mood: mood,
                eventId: eventId,
                eventAction: eventAction,
                eventLabel: eventLabel,
                wasEnergiskChainFollowUp: wasEnergiskChainFollowUp,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HistoryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistoryEntriesTable,
      HistoryEntryRow,
      $$HistoryEntriesTableFilterComposer,
      $$HistoryEntriesTableOrderingComposer,
      $$HistoryEntriesTableAnnotationComposer,
      $$HistoryEntriesTableCreateCompanionBuilder,
      $$HistoryEntriesTableUpdateCompanionBuilder,
      (
        HistoryEntryRow,
        BaseReferences<_$AppDatabase, $HistoryEntriesTable, HistoryEntryRow>,
      ),
      HistoryEntryRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HistoryEntriesTableTableManager get historyEntries =>
      $$HistoryEntriesTableTableManager(_db, _db.historyEntries);
}
