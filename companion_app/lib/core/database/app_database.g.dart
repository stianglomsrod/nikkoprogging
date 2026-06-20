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

class $CompanionEventStatesTable extends CompanionEventStates
    with TableInfo<$CompanionEventStatesTable, CompanionEventStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanionEventStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _completedTaskCountMeta =
      const VerificationMeta('completedTaskCount');
  @override
  late final GeneratedColumn<int> completedTaskCount = GeneratedColumn<int>(
    'completed_task_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _autoTriggeredEventIdsJsonMeta =
      const VerificationMeta('autoTriggeredEventIdsJson');
  @override
  late final GeneratedColumn<String> autoTriggeredEventIdsJson =
      GeneratedColumn<String>(
        'auto_triggered_event_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _handledEventIdsJsonMeta =
      const VerificationMeta('handledEventIdsJson');
  @override
  late final GeneratedColumn<String> handledEventIdsJson =
      GeneratedColumn<String>(
        'handled_event_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _skippedEventIdsJsonMeta =
      const VerificationMeta('skippedEventIdsJson');
  @override
  late final GeneratedColumn<String> skippedEventIdsJson =
      GeneratedColumn<String>(
        'skipped_event_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _pendingEventIdMeta = const VerificationMeta(
    'pendingEventId',
  );
  @override
  late final GeneratedColumn<String> pendingEventId = GeneratedColumn<String>(
    'pending_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    completedTaskCount,
    autoTriggeredEventIdsJson,
    handledEventIdsJson,
    skippedEventIdsJson,
    pendingEventId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companion_event_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompanionEventStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('completed_task_count')) {
      context.handle(
        _completedTaskCountMeta,
        completedTaskCount.isAcceptableOrUnknown(
          data['completed_task_count']!,
          _completedTaskCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedTaskCountMeta);
    }
    if (data.containsKey('auto_triggered_event_ids_json')) {
      context.handle(
        _autoTriggeredEventIdsJsonMeta,
        autoTriggeredEventIdsJson.isAcceptableOrUnknown(
          data['auto_triggered_event_ids_json']!,
          _autoTriggeredEventIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_autoTriggeredEventIdsJsonMeta);
    }
    if (data.containsKey('handled_event_ids_json')) {
      context.handle(
        _handledEventIdsJsonMeta,
        handledEventIdsJson.isAcceptableOrUnknown(
          data['handled_event_ids_json']!,
          _handledEventIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_handledEventIdsJsonMeta);
    }
    if (data.containsKey('skipped_event_ids_json')) {
      context.handle(
        _skippedEventIdsJsonMeta,
        skippedEventIdsJson.isAcceptableOrUnknown(
          data['skipped_event_ids_json']!,
          _skippedEventIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_skippedEventIdsJsonMeta);
    }
    if (data.containsKey('pending_event_id')) {
      context.handle(
        _pendingEventIdMeta,
        pendingEventId.isAcceptableOrUnknown(
          data['pending_event_id']!,
          _pendingEventIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompanionEventStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanionEventStateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      completedTaskCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_task_count'],
      )!,
      autoTriggeredEventIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auto_triggered_event_ids_json'],
      )!,
      handledEventIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}handled_event_ids_json'],
      )!,
      skippedEventIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skipped_event_ids_json'],
      )!,
      pendingEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pending_event_id'],
      ),
    );
  }

  @override
  $CompanionEventStatesTable createAlias(String alias) {
    return $CompanionEventStatesTable(attachedDatabase, alias);
  }
}

class CompanionEventStateRow extends DataClass
    implements Insertable<CompanionEventStateRow> {
  final int id;
  final int completedTaskCount;
  final String autoTriggeredEventIdsJson;
  final String handledEventIdsJson;
  final String skippedEventIdsJson;
  final String? pendingEventId;
  const CompanionEventStateRow({
    required this.id,
    required this.completedTaskCount,
    required this.autoTriggeredEventIdsJson,
    required this.handledEventIdsJson,
    required this.skippedEventIdsJson,
    this.pendingEventId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['completed_task_count'] = Variable<int>(completedTaskCount);
    map['auto_triggered_event_ids_json'] = Variable<String>(
      autoTriggeredEventIdsJson,
    );
    map['handled_event_ids_json'] = Variable<String>(handledEventIdsJson);
    map['skipped_event_ids_json'] = Variable<String>(skippedEventIdsJson);
    if (!nullToAbsent || pendingEventId != null) {
      map['pending_event_id'] = Variable<String>(pendingEventId);
    }
    return map;
  }

  CompanionEventStatesCompanion toCompanion(bool nullToAbsent) {
    return CompanionEventStatesCompanion(
      id: Value(id),
      completedTaskCount: Value(completedTaskCount),
      autoTriggeredEventIdsJson: Value(autoTriggeredEventIdsJson),
      handledEventIdsJson: Value(handledEventIdsJson),
      skippedEventIdsJson: Value(skippedEventIdsJson),
      pendingEventId: pendingEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(pendingEventId),
    );
  }

  factory CompanionEventStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanionEventStateRow(
      id: serializer.fromJson<int>(json['id']),
      completedTaskCount: serializer.fromJson<int>(json['completedTaskCount']),
      autoTriggeredEventIdsJson: serializer.fromJson<String>(
        json['autoTriggeredEventIdsJson'],
      ),
      handledEventIdsJson: serializer.fromJson<String>(
        json['handledEventIdsJson'],
      ),
      skippedEventIdsJson: serializer.fromJson<String>(
        json['skippedEventIdsJson'],
      ),
      pendingEventId: serializer.fromJson<String?>(json['pendingEventId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'completedTaskCount': serializer.toJson<int>(completedTaskCount),
      'autoTriggeredEventIdsJson': serializer.toJson<String>(
        autoTriggeredEventIdsJson,
      ),
      'handledEventIdsJson': serializer.toJson<String>(handledEventIdsJson),
      'skippedEventIdsJson': serializer.toJson<String>(skippedEventIdsJson),
      'pendingEventId': serializer.toJson<String?>(pendingEventId),
    };
  }

  CompanionEventStateRow copyWith({
    int? id,
    int? completedTaskCount,
    String? autoTriggeredEventIdsJson,
    String? handledEventIdsJson,
    String? skippedEventIdsJson,
    Value<String?> pendingEventId = const Value.absent(),
  }) => CompanionEventStateRow(
    id: id ?? this.id,
    completedTaskCount: completedTaskCount ?? this.completedTaskCount,
    autoTriggeredEventIdsJson:
        autoTriggeredEventIdsJson ?? this.autoTriggeredEventIdsJson,
    handledEventIdsJson: handledEventIdsJson ?? this.handledEventIdsJson,
    skippedEventIdsJson: skippedEventIdsJson ?? this.skippedEventIdsJson,
    pendingEventId: pendingEventId.present
        ? pendingEventId.value
        : this.pendingEventId,
  );
  CompanionEventStateRow copyWithCompanion(CompanionEventStatesCompanion data) {
    return CompanionEventStateRow(
      id: data.id.present ? data.id.value : this.id,
      completedTaskCount: data.completedTaskCount.present
          ? data.completedTaskCount.value
          : this.completedTaskCount,
      autoTriggeredEventIdsJson: data.autoTriggeredEventIdsJson.present
          ? data.autoTriggeredEventIdsJson.value
          : this.autoTriggeredEventIdsJson,
      handledEventIdsJson: data.handledEventIdsJson.present
          ? data.handledEventIdsJson.value
          : this.handledEventIdsJson,
      skippedEventIdsJson: data.skippedEventIdsJson.present
          ? data.skippedEventIdsJson.value
          : this.skippedEventIdsJson,
      pendingEventId: data.pendingEventId.present
          ? data.pendingEventId.value
          : this.pendingEventId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanionEventStateRow(')
          ..write('id: $id, ')
          ..write('completedTaskCount: $completedTaskCount, ')
          ..write('autoTriggeredEventIdsJson: $autoTriggeredEventIdsJson, ')
          ..write('handledEventIdsJson: $handledEventIdsJson, ')
          ..write('skippedEventIdsJson: $skippedEventIdsJson, ')
          ..write('pendingEventId: $pendingEventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    completedTaskCount,
    autoTriggeredEventIdsJson,
    handledEventIdsJson,
    skippedEventIdsJson,
    pendingEventId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanionEventStateRow &&
          other.id == this.id &&
          other.completedTaskCount == this.completedTaskCount &&
          other.autoTriggeredEventIdsJson == this.autoTriggeredEventIdsJson &&
          other.handledEventIdsJson == this.handledEventIdsJson &&
          other.skippedEventIdsJson == this.skippedEventIdsJson &&
          other.pendingEventId == this.pendingEventId);
}

class CompanionEventStatesCompanion
    extends UpdateCompanion<CompanionEventStateRow> {
  final Value<int> id;
  final Value<int> completedTaskCount;
  final Value<String> autoTriggeredEventIdsJson;
  final Value<String> handledEventIdsJson;
  final Value<String> skippedEventIdsJson;
  final Value<String?> pendingEventId;
  const CompanionEventStatesCompanion({
    this.id = const Value.absent(),
    this.completedTaskCount = const Value.absent(),
    this.autoTriggeredEventIdsJson = const Value.absent(),
    this.handledEventIdsJson = const Value.absent(),
    this.skippedEventIdsJson = const Value.absent(),
    this.pendingEventId = const Value.absent(),
  });
  CompanionEventStatesCompanion.insert({
    this.id = const Value.absent(),
    required int completedTaskCount,
    required String autoTriggeredEventIdsJson,
    required String handledEventIdsJson,
    required String skippedEventIdsJson,
    this.pendingEventId = const Value.absent(),
  }) : completedTaskCount = Value(completedTaskCount),
       autoTriggeredEventIdsJson = Value(autoTriggeredEventIdsJson),
       handledEventIdsJson = Value(handledEventIdsJson),
       skippedEventIdsJson = Value(skippedEventIdsJson);
  static Insertable<CompanionEventStateRow> custom({
    Expression<int>? id,
    Expression<int>? completedTaskCount,
    Expression<String>? autoTriggeredEventIdsJson,
    Expression<String>? handledEventIdsJson,
    Expression<String>? skippedEventIdsJson,
    Expression<String>? pendingEventId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (completedTaskCount != null)
        'completed_task_count': completedTaskCount,
      if (autoTriggeredEventIdsJson != null)
        'auto_triggered_event_ids_json': autoTriggeredEventIdsJson,
      if (handledEventIdsJson != null)
        'handled_event_ids_json': handledEventIdsJson,
      if (skippedEventIdsJson != null)
        'skipped_event_ids_json': skippedEventIdsJson,
      if (pendingEventId != null) 'pending_event_id': pendingEventId,
    });
  }

  CompanionEventStatesCompanion copyWith({
    Value<int>? id,
    Value<int>? completedTaskCount,
    Value<String>? autoTriggeredEventIdsJson,
    Value<String>? handledEventIdsJson,
    Value<String>? skippedEventIdsJson,
    Value<String?>? pendingEventId,
  }) {
    return CompanionEventStatesCompanion(
      id: id ?? this.id,
      completedTaskCount: completedTaskCount ?? this.completedTaskCount,
      autoTriggeredEventIdsJson:
          autoTriggeredEventIdsJson ?? this.autoTriggeredEventIdsJson,
      handledEventIdsJson: handledEventIdsJson ?? this.handledEventIdsJson,
      skippedEventIdsJson: skippedEventIdsJson ?? this.skippedEventIdsJson,
      pendingEventId: pendingEventId ?? this.pendingEventId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (completedTaskCount.present) {
      map['completed_task_count'] = Variable<int>(completedTaskCount.value);
    }
    if (autoTriggeredEventIdsJson.present) {
      map['auto_triggered_event_ids_json'] = Variable<String>(
        autoTriggeredEventIdsJson.value,
      );
    }
    if (handledEventIdsJson.present) {
      map['handled_event_ids_json'] = Variable<String>(
        handledEventIdsJson.value,
      );
    }
    if (skippedEventIdsJson.present) {
      map['skipped_event_ids_json'] = Variable<String>(
        skippedEventIdsJson.value,
      );
    }
    if (pendingEventId.present) {
      map['pending_event_id'] = Variable<String>(pendingEventId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanionEventStatesCompanion(')
          ..write('id: $id, ')
          ..write('completedTaskCount: $completedTaskCount, ')
          ..write('autoTriggeredEventIdsJson: $autoTriggeredEventIdsJson, ')
          ..write('handledEventIdsJson: $handledEventIdsJson, ')
          ..write('skippedEventIdsJson: $skippedEventIdsJson, ')
          ..write('pendingEventId: $pendingEventId')
          ..write(')'))
        .toString();
  }
}

class $CompanionIdentityStatesTable extends CompanionIdentityStates
    with TableInfo<$CompanionIdentityStatesTable, CompanionIdentityStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanionIdentityStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _companionNameMeta = const VerificationMeta(
    'companionName',
  );
  @override
  late final GeneratedColumn<String> companionName = GeneratedColumn<String>(
    'companion_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _selectedSymbolMeta = const VerificationMeta(
    'selectedSymbol',
  );
  @override
  late final GeneratedColumn<String> selectedSymbol = GeneratedColumn<String>(
    'selected_symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _backgroundToneMeta = const VerificationMeta(
    'backgroundTone',
  );
  @override
  late final GeneratedColumn<String> backgroundTone = GeneratedColumn<String>(
    'background_tone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('defaultDark'),
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companionName,
    userName,
    selectedSymbol,
    backgroundTone,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companion_identity_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompanionIdentityStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('companion_name')) {
      context.handle(
        _companionNameMeta,
        companionName.isAcceptableOrUnknown(
          data['companion_name']!,
          _companionNameMeta,
        ),
      );
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    }
    if (data.containsKey('selected_symbol')) {
      context.handle(
        _selectedSymbolMeta,
        selectedSymbol.isAcceptableOrUnknown(
          data['selected_symbol']!,
          _selectedSymbolMeta,
        ),
      );
    }
    if (data.containsKey('background_tone')) {
      context.handle(
        _backgroundToneMeta,
        backgroundTone.isAcceptableOrUnknown(
          data['background_tone']!,
          _backgroundToneMeta,
        ),
      );
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompanionIdentityStateRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanionIdentityStateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      companionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}companion_name'],
      ),
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      ),
      selectedSymbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_symbol'],
      )!,
      backgroundTone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_tone'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $CompanionIdentityStatesTable createAlias(String alias) {
    return $CompanionIdentityStatesTable(attachedDatabase, alias);
  }
}

class CompanionIdentityStateRow extends DataClass
    implements Insertable<CompanionIdentityStateRow> {
  final int id;
  final String? companionName;
  final String? userName;
  final String selectedSymbol;
  final String backgroundTone;
  final int updatedAtMs;
  const CompanionIdentityStateRow({
    required this.id,
    this.companionName,
    this.userName,
    required this.selectedSymbol,
    required this.backgroundTone,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || companionName != null) {
      map['companion_name'] = Variable<String>(companionName);
    }
    if (!nullToAbsent || userName != null) {
      map['user_name'] = Variable<String>(userName);
    }
    map['selected_symbol'] = Variable<String>(selectedSymbol);
    map['background_tone'] = Variable<String>(backgroundTone);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  CompanionIdentityStatesCompanion toCompanion(bool nullToAbsent) {
    return CompanionIdentityStatesCompanion(
      id: Value(id),
      companionName: companionName == null && nullToAbsent
          ? const Value.absent()
          : Value(companionName),
      userName: userName == null && nullToAbsent
          ? const Value.absent()
          : Value(userName),
      selectedSymbol: Value(selectedSymbol),
      backgroundTone: Value(backgroundTone),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory CompanionIdentityStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanionIdentityStateRow(
      id: serializer.fromJson<int>(json['id']),
      companionName: serializer.fromJson<String?>(json['companionName']),
      userName: serializer.fromJson<String?>(json['userName']),
      selectedSymbol: serializer.fromJson<String>(json['selectedSymbol']),
      backgroundTone: serializer.fromJson<String>(json['backgroundTone']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'companionName': serializer.toJson<String?>(companionName),
      'userName': serializer.toJson<String?>(userName),
      'selectedSymbol': serializer.toJson<String>(selectedSymbol),
      'backgroundTone': serializer.toJson<String>(backgroundTone),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  CompanionIdentityStateRow copyWith({
    int? id,
    Value<String?> companionName = const Value.absent(),
    Value<String?> userName = const Value.absent(),
    String? selectedSymbol,
    String? backgroundTone,
    int? updatedAtMs,
  }) => CompanionIdentityStateRow(
    id: id ?? this.id,
    companionName: companionName.present
        ? companionName.value
        : this.companionName,
    userName: userName.present ? userName.value : this.userName,
    selectedSymbol: selectedSymbol ?? this.selectedSymbol,
    backgroundTone: backgroundTone ?? this.backgroundTone,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  CompanionIdentityStateRow copyWithCompanion(
    CompanionIdentityStatesCompanion data,
  ) {
    return CompanionIdentityStateRow(
      id: data.id.present ? data.id.value : this.id,
      companionName: data.companionName.present
          ? data.companionName.value
          : this.companionName,
      userName: data.userName.present ? data.userName.value : this.userName,
      selectedSymbol: data.selectedSymbol.present
          ? data.selectedSymbol.value
          : this.selectedSymbol,
      backgroundTone: data.backgroundTone.present
          ? data.backgroundTone.value
          : this.backgroundTone,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanionIdentityStateRow(')
          ..write('id: $id, ')
          ..write('companionName: $companionName, ')
          ..write('userName: $userName, ')
          ..write('selectedSymbol: $selectedSymbol, ')
          ..write('backgroundTone: $backgroundTone, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companionName,
    userName,
    selectedSymbol,
    backgroundTone,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanionIdentityStateRow &&
          other.id == this.id &&
          other.companionName == this.companionName &&
          other.userName == this.userName &&
          other.selectedSymbol == this.selectedSymbol &&
          other.backgroundTone == this.backgroundTone &&
          other.updatedAtMs == this.updatedAtMs);
}

class CompanionIdentityStatesCompanion
    extends UpdateCompanion<CompanionIdentityStateRow> {
  final Value<int> id;
  final Value<String?> companionName;
  final Value<String?> userName;
  final Value<String> selectedSymbol;
  final Value<String> backgroundTone;
  final Value<int> updatedAtMs;
  const CompanionIdentityStatesCompanion({
    this.id = const Value.absent(),
    this.companionName = const Value.absent(),
    this.userName = const Value.absent(),
    this.selectedSymbol = const Value.absent(),
    this.backgroundTone = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
  });
  CompanionIdentityStatesCompanion.insert({
    this.id = const Value.absent(),
    this.companionName = const Value.absent(),
    this.userName = const Value.absent(),
    this.selectedSymbol = const Value.absent(),
    this.backgroundTone = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
  });
  static Insertable<CompanionIdentityStateRow> custom({
    Expression<int>? id,
    Expression<String>? companionName,
    Expression<String>? userName,
    Expression<String>? selectedSymbol,
    Expression<String>? backgroundTone,
    Expression<int>? updatedAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companionName != null) 'companion_name': companionName,
      if (userName != null) 'user_name': userName,
      if (selectedSymbol != null) 'selected_symbol': selectedSymbol,
      if (backgroundTone != null) 'background_tone': backgroundTone,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
    });
  }

  CompanionIdentityStatesCompanion copyWith({
    Value<int>? id,
    Value<String?>? companionName,
    Value<String?>? userName,
    Value<String>? selectedSymbol,
    Value<String>? backgroundTone,
    Value<int>? updatedAtMs,
  }) {
    return CompanionIdentityStatesCompanion(
      id: id ?? this.id,
      companionName: companionName ?? this.companionName,
      userName: userName ?? this.userName,
      selectedSymbol: selectedSymbol ?? this.selectedSymbol,
      backgroundTone: backgroundTone ?? this.backgroundTone,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (companionName.present) {
      map['companion_name'] = Variable<String>(companionName.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (selectedSymbol.present) {
      map['selected_symbol'] = Variable<String>(selectedSymbol.value);
    }
    if (backgroundTone.present) {
      map['background_tone'] = Variable<String>(backgroundTone.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanionIdentityStatesCompanion(')
          ..write('id: $id, ')
          ..write('companionName: $companionName, ')
          ..write('userName: $userName, ')
          ..write('selectedSymbol: $selectedSymbol, ')
          ..write('backgroundTone: $backgroundTone, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HistoryEntriesTable historyEntries = $HistoryEntriesTable(this);
  late final $CompanionEventStatesTable companionEventStates =
      $CompanionEventStatesTable(this);
  late final $CompanionIdentityStatesTable companionIdentityStates =
      $CompanionIdentityStatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    historyEntries,
    companionEventStates,
    companionIdentityStates,
  ];
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
typedef $$CompanionEventStatesTableCreateCompanionBuilder =
    CompanionEventStatesCompanion Function({
      Value<int> id,
      required int completedTaskCount,
      required String autoTriggeredEventIdsJson,
      required String handledEventIdsJson,
      required String skippedEventIdsJson,
      Value<String?> pendingEventId,
    });
typedef $$CompanionEventStatesTableUpdateCompanionBuilder =
    CompanionEventStatesCompanion Function({
      Value<int> id,
      Value<int> completedTaskCount,
      Value<String> autoTriggeredEventIdsJson,
      Value<String> handledEventIdsJson,
      Value<String> skippedEventIdsJson,
      Value<String?> pendingEventId,
    });

class $$CompanionEventStatesTableFilterComposer
    extends Composer<_$AppDatabase, $CompanionEventStatesTable> {
  $$CompanionEventStatesTableFilterComposer({
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

  ColumnFilters<int> get completedTaskCount => $composableBuilder(
    column: $table.completedTaskCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get autoTriggeredEventIdsJson => $composableBuilder(
    column: $table.autoTriggeredEventIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get handledEventIdsJson => $composableBuilder(
    column: $table.handledEventIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skippedEventIdsJson => $composableBuilder(
    column: $table.skippedEventIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pendingEventId => $composableBuilder(
    column: $table.pendingEventId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompanionEventStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanionEventStatesTable> {
  $$CompanionEventStatesTableOrderingComposer({
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

  ColumnOrderings<int> get completedTaskCount => $composableBuilder(
    column: $table.completedTaskCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get autoTriggeredEventIdsJson => $composableBuilder(
    column: $table.autoTriggeredEventIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get handledEventIdsJson => $composableBuilder(
    column: $table.handledEventIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skippedEventIdsJson => $composableBuilder(
    column: $table.skippedEventIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pendingEventId => $composableBuilder(
    column: $table.pendingEventId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompanionEventStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanionEventStatesTable> {
  $$CompanionEventStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get completedTaskCount => $composableBuilder(
    column: $table.completedTaskCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get autoTriggeredEventIdsJson => $composableBuilder(
    column: $table.autoTriggeredEventIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get handledEventIdsJson => $composableBuilder(
    column: $table.handledEventIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get skippedEventIdsJson => $composableBuilder(
    column: $table.skippedEventIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pendingEventId => $composableBuilder(
    column: $table.pendingEventId,
    builder: (column) => column,
  );
}

class $$CompanionEventStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompanionEventStatesTable,
          CompanionEventStateRow,
          $$CompanionEventStatesTableFilterComposer,
          $$CompanionEventStatesTableOrderingComposer,
          $$CompanionEventStatesTableAnnotationComposer,
          $$CompanionEventStatesTableCreateCompanionBuilder,
          $$CompanionEventStatesTableUpdateCompanionBuilder,
          (
            CompanionEventStateRow,
            BaseReferences<
              _$AppDatabase,
              $CompanionEventStatesTable,
              CompanionEventStateRow
            >,
          ),
          CompanionEventStateRow,
          PrefetchHooks Function()
        > {
  $$CompanionEventStatesTableTableManager(
    _$AppDatabase db,
    $CompanionEventStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanionEventStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanionEventStatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CompanionEventStatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> completedTaskCount = const Value.absent(),
                Value<String> autoTriggeredEventIdsJson = const Value.absent(),
                Value<String> handledEventIdsJson = const Value.absent(),
                Value<String> skippedEventIdsJson = const Value.absent(),
                Value<String?> pendingEventId = const Value.absent(),
              }) => CompanionEventStatesCompanion(
                id: id,
                completedTaskCount: completedTaskCount,
                autoTriggeredEventIdsJson: autoTriggeredEventIdsJson,
                handledEventIdsJson: handledEventIdsJson,
                skippedEventIdsJson: skippedEventIdsJson,
                pendingEventId: pendingEventId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int completedTaskCount,
                required String autoTriggeredEventIdsJson,
                required String handledEventIdsJson,
                required String skippedEventIdsJson,
                Value<String?> pendingEventId = const Value.absent(),
              }) => CompanionEventStatesCompanion.insert(
                id: id,
                completedTaskCount: completedTaskCount,
                autoTriggeredEventIdsJson: autoTriggeredEventIdsJson,
                handledEventIdsJson: handledEventIdsJson,
                skippedEventIdsJson: skippedEventIdsJson,
                pendingEventId: pendingEventId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompanionEventStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompanionEventStatesTable,
      CompanionEventStateRow,
      $$CompanionEventStatesTableFilterComposer,
      $$CompanionEventStatesTableOrderingComposer,
      $$CompanionEventStatesTableAnnotationComposer,
      $$CompanionEventStatesTableCreateCompanionBuilder,
      $$CompanionEventStatesTableUpdateCompanionBuilder,
      (
        CompanionEventStateRow,
        BaseReferences<
          _$AppDatabase,
          $CompanionEventStatesTable,
          CompanionEventStateRow
        >,
      ),
      CompanionEventStateRow,
      PrefetchHooks Function()
    >;
typedef $$CompanionIdentityStatesTableCreateCompanionBuilder =
    CompanionIdentityStatesCompanion Function({
      Value<int> id,
      Value<String?> companionName,
      Value<String?> userName,
      Value<String> selectedSymbol,
      Value<String> backgroundTone,
      Value<int> updatedAtMs,
    });
typedef $$CompanionIdentityStatesTableUpdateCompanionBuilder =
    CompanionIdentityStatesCompanion Function({
      Value<int> id,
      Value<String?> companionName,
      Value<String?> userName,
      Value<String> selectedSymbol,
      Value<String> backgroundTone,
      Value<int> updatedAtMs,
    });

class $$CompanionIdentityStatesTableFilterComposer
    extends Composer<_$AppDatabase, $CompanionIdentityStatesTable> {
  $$CompanionIdentityStatesTableFilterComposer({
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

  ColumnFilters<String> get companionName => $composableBuilder(
    column: $table.companionName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedSymbol => $composableBuilder(
    column: $table.selectedSymbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backgroundTone => $composableBuilder(
    column: $table.backgroundTone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompanionIdentityStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanionIdentityStatesTable> {
  $$CompanionIdentityStatesTableOrderingComposer({
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

  ColumnOrderings<String> get companionName => $composableBuilder(
    column: $table.companionName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedSymbol => $composableBuilder(
    column: $table.selectedSymbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backgroundTone => $composableBuilder(
    column: $table.backgroundTone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompanionIdentityStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanionIdentityStatesTable> {
  $$CompanionIdentityStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companionName => $composableBuilder(
    column: $table.companionName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get selectedSymbol => $composableBuilder(
    column: $table.selectedSymbol,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backgroundTone => $composableBuilder(
    column: $table.backgroundTone,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$CompanionIdentityStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompanionIdentityStatesTable,
          CompanionIdentityStateRow,
          $$CompanionIdentityStatesTableFilterComposer,
          $$CompanionIdentityStatesTableOrderingComposer,
          $$CompanionIdentityStatesTableAnnotationComposer,
          $$CompanionIdentityStatesTableCreateCompanionBuilder,
          $$CompanionIdentityStatesTableUpdateCompanionBuilder,
          (
            CompanionIdentityStateRow,
            BaseReferences<
              _$AppDatabase,
              $CompanionIdentityStatesTable,
              CompanionIdentityStateRow
            >,
          ),
          CompanionIdentityStateRow,
          PrefetchHooks Function()
        > {
  $$CompanionIdentityStatesTableTableManager(
    _$AppDatabase db,
    $CompanionIdentityStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanionIdentityStatesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CompanionIdentityStatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CompanionIdentityStatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> companionName = const Value.absent(),
                Value<String?> userName = const Value.absent(),
                Value<String> selectedSymbol = const Value.absent(),
                Value<String> backgroundTone = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
              }) => CompanionIdentityStatesCompanion(
                id: id,
                companionName: companionName,
                userName: userName,
                selectedSymbol: selectedSymbol,
                backgroundTone: backgroundTone,
                updatedAtMs: updatedAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> companionName = const Value.absent(),
                Value<String?> userName = const Value.absent(),
                Value<String> selectedSymbol = const Value.absent(),
                Value<String> backgroundTone = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
              }) => CompanionIdentityStatesCompanion.insert(
                id: id,
                companionName: companionName,
                userName: userName,
                selectedSymbol: selectedSymbol,
                backgroundTone: backgroundTone,
                updatedAtMs: updatedAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompanionIdentityStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompanionIdentityStatesTable,
      CompanionIdentityStateRow,
      $$CompanionIdentityStatesTableFilterComposer,
      $$CompanionIdentityStatesTableOrderingComposer,
      $$CompanionIdentityStatesTableAnnotationComposer,
      $$CompanionIdentityStatesTableCreateCompanionBuilder,
      $$CompanionIdentityStatesTableUpdateCompanionBuilder,
      (
        CompanionIdentityStateRow,
        BaseReferences<
          _$AppDatabase,
          $CompanionIdentityStatesTable,
          CompanionIdentityStateRow
        >,
      ),
      CompanionIdentityStateRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HistoryEntriesTableTableManager get historyEntries =>
      $$HistoryEntriesTableTableManager(_db, _db.historyEntries);
  $$CompanionEventStatesTableTableManager get companionEventStates =>
      $$CompanionEventStatesTableTableManager(_db, _db.companionEventStates);
  $$CompanionIdentityStatesTableTableManager get companionIdentityStates =>
      $$CompanionIdentityStatesTableTableManager(
        _db,
        _db.companionIdentityStates,
      );
}
