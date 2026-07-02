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
  static const VerificationMeta _sleepSoundMeta = const VerificationMeta(
    'sleepSound',
  );
  @override
  late final GeneratedColumn<String> sleepSound = GeneratedColumn<String>(
    'sleep_sound',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
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
    sleepSound,
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
    if (data.containsKey('sleep_sound')) {
      context.handle(
        _sleepSoundMeta,
        sleepSound.isAcceptableOrUnknown(data['sleep_sound']!, _sleepSoundMeta),
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
      sleepSound: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sleep_sound'],
      )!,
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
  final String sleepSound;
  final String selectedSymbol;
  final String backgroundTone;
  final int updatedAtMs;
  const CompanionIdentityStateRow({
    required this.id,
    this.companionName,
    this.userName,
    required this.sleepSound,
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
    map['sleep_sound'] = Variable<String>(sleepSound);
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
      sleepSound: Value(sleepSound),
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
      sleepSound: serializer.fromJson<String>(json['sleepSound']),
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
      'sleepSound': serializer.toJson<String>(sleepSound),
      'selectedSymbol': serializer.toJson<String>(selectedSymbol),
      'backgroundTone': serializer.toJson<String>(backgroundTone),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  CompanionIdentityStateRow copyWith({
    int? id,
    Value<String?> companionName = const Value.absent(),
    Value<String?> userName = const Value.absent(),
    String? sleepSound,
    String? selectedSymbol,
    String? backgroundTone,
    int? updatedAtMs,
  }) => CompanionIdentityStateRow(
    id: id ?? this.id,
    companionName: companionName.present
        ? companionName.value
        : this.companionName,
    userName: userName.present ? userName.value : this.userName,
    sleepSound: sleepSound ?? this.sleepSound,
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
      sleepSound: data.sleepSound.present
          ? data.sleepSound.value
          : this.sleepSound,
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
          ..write('sleepSound: $sleepSound, ')
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
    sleepSound,
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
          other.sleepSound == this.sleepSound &&
          other.selectedSymbol == this.selectedSymbol &&
          other.backgroundTone == this.backgroundTone &&
          other.updatedAtMs == this.updatedAtMs);
}

class CompanionIdentityStatesCompanion
    extends UpdateCompanion<CompanionIdentityStateRow> {
  final Value<int> id;
  final Value<String?> companionName;
  final Value<String?> userName;
  final Value<String> sleepSound;
  final Value<String> selectedSymbol;
  final Value<String> backgroundTone;
  final Value<int> updatedAtMs;
  const CompanionIdentityStatesCompanion({
    this.id = const Value.absent(),
    this.companionName = const Value.absent(),
    this.userName = const Value.absent(),
    this.sleepSound = const Value.absent(),
    this.selectedSymbol = const Value.absent(),
    this.backgroundTone = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
  });
  CompanionIdentityStatesCompanion.insert({
    this.id = const Value.absent(),
    this.companionName = const Value.absent(),
    this.userName = const Value.absent(),
    this.sleepSound = const Value.absent(),
    this.selectedSymbol = const Value.absent(),
    this.backgroundTone = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
  });
  static Insertable<CompanionIdentityStateRow> custom({
    Expression<int>? id,
    Expression<String>? companionName,
    Expression<String>? userName,
    Expression<String>? sleepSound,
    Expression<String>? selectedSymbol,
    Expression<String>? backgroundTone,
    Expression<int>? updatedAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companionName != null) 'companion_name': companionName,
      if (userName != null) 'user_name': userName,
      if (sleepSound != null) 'sleep_sound': sleepSound,
      if (selectedSymbol != null) 'selected_symbol': selectedSymbol,
      if (backgroundTone != null) 'background_tone': backgroundTone,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
    });
  }

  CompanionIdentityStatesCompanion copyWith({
    Value<int>? id,
    Value<String?>? companionName,
    Value<String?>? userName,
    Value<String>? sleepSound,
    Value<String>? selectedSymbol,
    Value<String>? backgroundTone,
    Value<int>? updatedAtMs,
  }) {
    return CompanionIdentityStatesCompanion(
      id: id ?? this.id,
      companionName: companionName ?? this.companionName,
      userName: userName ?? this.userName,
      sleepSound: sleepSound ?? this.sleepSound,
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
    if (sleepSound.present) {
      map['sleep_sound'] = Variable<String>(sleepSound.value);
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
          ..write('sleepSound: $sleepSound, ')
          ..write('selectedSymbol: $selectedSymbol, ')
          ..write('backgroundTone: $backgroundTone, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }
}

class $FocusAreaSettingsStatesTable extends FocusAreaSettingsStates
    with TableInfo<$FocusAreaSettingsStatesTable, FocusAreaSettingsStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusAreaSettingsStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _startHourMeta = const VerificationMeta(
    'startHour',
  );
  @override
  late final GeneratedColumn<int> startHour = GeneratedColumn<int>(
    'start_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  static const VerificationMeta _endHourMeta = const VerificationMeta(
    'endHour',
  );
  @override
  late final GeneratedColumn<int> endHour = GeneratedColumn<int>(
    'end_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(22),
  );
  static const VerificationMeta _activeWindowsJsonMeta = const VerificationMeta(
    'activeWindowsJson',
  );
  @override
  late final GeneratedColumn<String> activeWindowsJson =
      GeneratedColumn<String>(
        'active_windows_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _modusMeta = const VerificationMeta('modus');
  @override
  late final GeneratedColumn<String> modus = GeneratedColumn<String>(
    'modus',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('avslappet'),
  );
  static const VerificationMeta _isSelectedMeta = const VerificationMeta(
    'isSelected',
  );
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
    'is_selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_selected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    enabled,
    startHour,
    endHour,
    activeWindowsJson,
    modus,
    isSelected,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_area_settings_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<FocusAreaSettingsStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('start_hour')) {
      context.handle(
        _startHourMeta,
        startHour.isAcceptableOrUnknown(data['start_hour']!, _startHourMeta),
      );
    }
    if (data.containsKey('end_hour')) {
      context.handle(
        _endHourMeta,
        endHour.isAcceptableOrUnknown(data['end_hour']!, _endHourMeta),
      );
    }
    if (data.containsKey('active_windows_json')) {
      context.handle(
        _activeWindowsJsonMeta,
        activeWindowsJson.isAcceptableOrUnknown(
          data['active_windows_json']!,
          _activeWindowsJsonMeta,
        ),
      );
    }
    if (data.containsKey('modus')) {
      context.handle(
        _modusMeta,
        modus.isAcceptableOrUnknown(data['modus']!, _modusMeta),
      );
    }
    if (data.containsKey('is_selected')) {
      context.handle(
        _isSelectedMeta,
        isSelected.isAcceptableOrUnknown(data['is_selected']!, _isSelectedMeta),
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
  FocusAreaSettingsStateRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusAreaSettingsStateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      startHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_hour'],
      )!,
      endHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_hour'],
      )!,
      activeWindowsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_windows_json'],
      ),
      modus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modus'],
      )!,
      isSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_selected'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      ),
    );
  }

  @override
  $FocusAreaSettingsStatesTable createAlias(String alias) {
    return $FocusAreaSettingsStatesTable(attachedDatabase, alias);
  }
}

class FocusAreaSettingsStateRow extends DataClass
    implements Insertable<FocusAreaSettingsStateRow> {
  final String id;
  final bool enabled;
  final int startHour;
  final int endHour;
  final String? activeWindowsJson;
  final String modus;
  final bool isSelected;
  final int? updatedAtMs;
  const FocusAreaSettingsStateRow({
    required this.id,
    required this.enabled,
    required this.startHour,
    required this.endHour,
    this.activeWindowsJson,
    required this.modus,
    required this.isSelected,
    this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['enabled'] = Variable<bool>(enabled);
    map['start_hour'] = Variable<int>(startHour);
    map['end_hour'] = Variable<int>(endHour);
    if (!nullToAbsent || activeWindowsJson != null) {
      map['active_windows_json'] = Variable<String>(activeWindowsJson);
    }
    map['modus'] = Variable<String>(modus);
    map['is_selected'] = Variable<bool>(isSelected);
    if (!nullToAbsent || updatedAtMs != null) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs);
    }
    return map;
  }

  FocusAreaSettingsStatesCompanion toCompanion(bool nullToAbsent) {
    return FocusAreaSettingsStatesCompanion(
      id: Value(id),
      enabled: Value(enabled),
      startHour: Value(startHour),
      endHour: Value(endHour),
      activeWindowsJson: activeWindowsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(activeWindowsJson),
      modus: Value(modus),
      isSelected: Value(isSelected),
      updatedAtMs: updatedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAtMs),
    );
  }

  factory FocusAreaSettingsStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusAreaSettingsStateRow(
      id: serializer.fromJson<String>(json['id']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      startHour: serializer.fromJson<int>(json['startHour']),
      endHour: serializer.fromJson<int>(json['endHour']),
      activeWindowsJson: serializer.fromJson<String?>(
        json['activeWindowsJson'],
      ),
      modus: serializer.fromJson<String>(json['modus']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
      updatedAtMs: serializer.fromJson<int?>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'enabled': serializer.toJson<bool>(enabled),
      'startHour': serializer.toJson<int>(startHour),
      'endHour': serializer.toJson<int>(endHour),
      'activeWindowsJson': serializer.toJson<String?>(activeWindowsJson),
      'modus': serializer.toJson<String>(modus),
      'isSelected': serializer.toJson<bool>(isSelected),
      'updatedAtMs': serializer.toJson<int?>(updatedAtMs),
    };
  }

  FocusAreaSettingsStateRow copyWith({
    String? id,
    bool? enabled,
    int? startHour,
    int? endHour,
    Value<String?> activeWindowsJson = const Value.absent(),
    String? modus,
    bool? isSelected,
    Value<int?> updatedAtMs = const Value.absent(),
  }) => FocusAreaSettingsStateRow(
    id: id ?? this.id,
    enabled: enabled ?? this.enabled,
    startHour: startHour ?? this.startHour,
    endHour: endHour ?? this.endHour,
    activeWindowsJson: activeWindowsJson.present
        ? activeWindowsJson.value
        : this.activeWindowsJson,
    modus: modus ?? this.modus,
    isSelected: isSelected ?? this.isSelected,
    updatedAtMs: updatedAtMs.present ? updatedAtMs.value : this.updatedAtMs,
  );
  FocusAreaSettingsStateRow copyWithCompanion(
    FocusAreaSettingsStatesCompanion data,
  ) {
    return FocusAreaSettingsStateRow(
      id: data.id.present ? data.id.value : this.id,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      startHour: data.startHour.present ? data.startHour.value : this.startHour,
      endHour: data.endHour.present ? data.endHour.value : this.endHour,
      activeWindowsJson: data.activeWindowsJson.present
          ? data.activeWindowsJson.value
          : this.activeWindowsJson,
      modus: data.modus.present ? data.modus.value : this.modus,
      isSelected: data.isSelected.present
          ? data.isSelected.value
          : this.isSelected,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusAreaSettingsStateRow(')
          ..write('id: $id, ')
          ..write('enabled: $enabled, ')
          ..write('startHour: $startHour, ')
          ..write('endHour: $endHour, ')
          ..write('activeWindowsJson: $activeWindowsJson, ')
          ..write('modus: $modus, ')
          ..write('isSelected: $isSelected, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    enabled,
    startHour,
    endHour,
    activeWindowsJson,
    modus,
    isSelected,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusAreaSettingsStateRow &&
          other.id == this.id &&
          other.enabled == this.enabled &&
          other.startHour == this.startHour &&
          other.endHour == this.endHour &&
          other.activeWindowsJson == this.activeWindowsJson &&
          other.modus == this.modus &&
          other.isSelected == this.isSelected &&
          other.updatedAtMs == this.updatedAtMs);
}

class FocusAreaSettingsStatesCompanion
    extends UpdateCompanion<FocusAreaSettingsStateRow> {
  final Value<String> id;
  final Value<bool> enabled;
  final Value<int> startHour;
  final Value<int> endHour;
  final Value<String?> activeWindowsJson;
  final Value<String> modus;
  final Value<bool> isSelected;
  final Value<int?> updatedAtMs;
  final Value<int> rowid;
  const FocusAreaSettingsStatesCompanion({
    this.id = const Value.absent(),
    this.enabled = const Value.absent(),
    this.startHour = const Value.absent(),
    this.endHour = const Value.absent(),
    this.activeWindowsJson = const Value.absent(),
    this.modus = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FocusAreaSettingsStatesCompanion.insert({
    required String id,
    this.enabled = const Value.absent(),
    this.startHour = const Value.absent(),
    this.endHour = const Value.absent(),
    this.activeWindowsJson = const Value.absent(),
    this.modus = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<FocusAreaSettingsStateRow> custom({
    Expression<String>? id,
    Expression<bool>? enabled,
    Expression<int>? startHour,
    Expression<int>? endHour,
    Expression<String>? activeWindowsJson,
    Expression<String>? modus,
    Expression<bool>? isSelected,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enabled != null) 'enabled': enabled,
      if (startHour != null) 'start_hour': startHour,
      if (endHour != null) 'end_hour': endHour,
      if (activeWindowsJson != null) 'active_windows_json': activeWindowsJson,
      if (modus != null) 'modus': modus,
      if (isSelected != null) 'is_selected': isSelected,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FocusAreaSettingsStatesCompanion copyWith({
    Value<String>? id,
    Value<bool>? enabled,
    Value<int>? startHour,
    Value<int>? endHour,
    Value<String?>? activeWindowsJson,
    Value<String>? modus,
    Value<bool>? isSelected,
    Value<int?>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return FocusAreaSettingsStatesCompanion(
      id: id ?? this.id,
      enabled: enabled ?? this.enabled,
      startHour: startHour ?? this.startHour,
      endHour: endHour ?? this.endHour,
      activeWindowsJson: activeWindowsJson ?? this.activeWindowsJson,
      modus: modus ?? this.modus,
      isSelected: isSelected ?? this.isSelected,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (startHour.present) {
      map['start_hour'] = Variable<int>(startHour.value);
    }
    if (endHour.present) {
      map['end_hour'] = Variable<int>(endHour.value);
    }
    if (activeWindowsJson.present) {
      map['active_windows_json'] = Variable<String>(activeWindowsJson.value);
    }
    if (modus.present) {
      map['modus'] = Variable<String>(modus.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusAreaSettingsStatesCompanion(')
          ..write('id: $id, ')
          ..write('enabled: $enabled, ')
          ..write('startHour: $startHour, ')
          ..write('endHour: $endHour, ')
          ..write('activeWindowsJson: $activeWindowsJson, ')
          ..write('modus: $modus, ')
          ..write('isSelected: $isSelected, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeedbackItemsTable extends FeedbackItems
    with TableInfo<$FeedbackItemsTable, FeedbackItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedbackItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feedbackTypeMeta = const VerificationMeta(
    'feedbackType',
  );
  @override
  late final GeneratedColumn<String> feedbackType = GeneratedColumn<String>(
    'feedback_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appVersionMeta = const VerificationMeta(
    'appVersion',
  );
  @override
  late final GeneratedColumn<String> appVersion = GeneratedColumn<String>(
    'app_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _screenContextMeta = const VerificationMeta(
    'screenContext',
  );
  @override
  late final GeneratedColumn<String> screenContext = GeneratedColumn<String>(
    'screen_context',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAtMs,
    feedbackType,
    message,
    appVersion,
    screenContext,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feedback_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedbackItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('feedback_type')) {
      context.handle(
        _feedbackTypeMeta,
        feedbackType.isAcceptableOrUnknown(
          data['feedback_type']!,
          _feedbackTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_feedbackTypeMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('app_version')) {
      context.handle(
        _appVersionMeta,
        appVersion.isAcceptableOrUnknown(data['app_version']!, _appVersionMeta),
      );
    }
    if (data.containsKey('screen_context')) {
      context.handle(
        _screenContextMeta,
        screenContext.isAcceptableOrUnknown(
          data['screen_context']!,
          _screenContextMeta,
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
  FeedbackItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedbackItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      feedbackType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feedback_type'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      appVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_version'],
      ),
      screenContext: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}screen_context'],
      ),
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      ),
    );
  }

  @override
  $FeedbackItemsTable createAlias(String alias) {
    return $FeedbackItemsTable(attachedDatabase, alias);
  }
}

class FeedbackItemRow extends DataClass implements Insertable<FeedbackItemRow> {
  final String id;
  final int createdAtMs;
  final String feedbackType;
  final String message;
  final String? appVersion;
  final String? screenContext;
  final int? updatedAtMs;
  const FeedbackItemRow({
    required this.id,
    required this.createdAtMs,
    required this.feedbackType,
    required this.message,
    this.appVersion,
    this.screenContext,
    this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['feedback_type'] = Variable<String>(feedbackType);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || appVersion != null) {
      map['app_version'] = Variable<String>(appVersion);
    }
    if (!nullToAbsent || screenContext != null) {
      map['screen_context'] = Variable<String>(screenContext);
    }
    if (!nullToAbsent || updatedAtMs != null) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs);
    }
    return map;
  }

  FeedbackItemsCompanion toCompanion(bool nullToAbsent) {
    return FeedbackItemsCompanion(
      id: Value(id),
      createdAtMs: Value(createdAtMs),
      feedbackType: Value(feedbackType),
      message: Value(message),
      appVersion: appVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(appVersion),
      screenContext: screenContext == null && nullToAbsent
          ? const Value.absent()
          : Value(screenContext),
      updatedAtMs: updatedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAtMs),
    );
  }

  factory FeedbackItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedbackItemRow(
      id: serializer.fromJson<String>(json['id']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      feedbackType: serializer.fromJson<String>(json['feedbackType']),
      message: serializer.fromJson<String>(json['message']),
      appVersion: serializer.fromJson<String?>(json['appVersion']),
      screenContext: serializer.fromJson<String?>(json['screenContext']),
      updatedAtMs: serializer.fromJson<int?>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'feedbackType': serializer.toJson<String>(feedbackType),
      'message': serializer.toJson<String>(message),
      'appVersion': serializer.toJson<String?>(appVersion),
      'screenContext': serializer.toJson<String?>(screenContext),
      'updatedAtMs': serializer.toJson<int?>(updatedAtMs),
    };
  }

  FeedbackItemRow copyWith({
    String? id,
    int? createdAtMs,
    String? feedbackType,
    String? message,
    Value<String?> appVersion = const Value.absent(),
    Value<String?> screenContext = const Value.absent(),
    Value<int?> updatedAtMs = const Value.absent(),
  }) => FeedbackItemRow(
    id: id ?? this.id,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    feedbackType: feedbackType ?? this.feedbackType,
    message: message ?? this.message,
    appVersion: appVersion.present ? appVersion.value : this.appVersion,
    screenContext: screenContext.present
        ? screenContext.value
        : this.screenContext,
    updatedAtMs: updatedAtMs.present ? updatedAtMs.value : this.updatedAtMs,
  );
  FeedbackItemRow copyWithCompanion(FeedbackItemsCompanion data) {
    return FeedbackItemRow(
      id: data.id.present ? data.id.value : this.id,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      feedbackType: data.feedbackType.present
          ? data.feedbackType.value
          : this.feedbackType,
      message: data.message.present ? data.message.value : this.message,
      appVersion: data.appVersion.present
          ? data.appVersion.value
          : this.appVersion,
      screenContext: data.screenContext.present
          ? data.screenContext.value
          : this.screenContext,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedbackItemRow(')
          ..write('id: $id, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('feedbackType: $feedbackType, ')
          ..write('message: $message, ')
          ..write('appVersion: $appVersion, ')
          ..write('screenContext: $screenContext, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAtMs,
    feedbackType,
    message,
    appVersion,
    screenContext,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedbackItemRow &&
          other.id == this.id &&
          other.createdAtMs == this.createdAtMs &&
          other.feedbackType == this.feedbackType &&
          other.message == this.message &&
          other.appVersion == this.appVersion &&
          other.screenContext == this.screenContext &&
          other.updatedAtMs == this.updatedAtMs);
}

class FeedbackItemsCompanion extends UpdateCompanion<FeedbackItemRow> {
  final Value<String> id;
  final Value<int> createdAtMs;
  final Value<String> feedbackType;
  final Value<String> message;
  final Value<String?> appVersion;
  final Value<String?> screenContext;
  final Value<int?> updatedAtMs;
  final Value<int> rowid;
  const FeedbackItemsCompanion({
    this.id = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.feedbackType = const Value.absent(),
    this.message = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.screenContext = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedbackItemsCompanion.insert({
    required String id,
    required int createdAtMs,
    required String feedbackType,
    required String message,
    this.appVersion = const Value.absent(),
    this.screenContext = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAtMs = Value(createdAtMs),
       feedbackType = Value(feedbackType),
       message = Value(message);
  static Insertable<FeedbackItemRow> custom({
    Expression<String>? id,
    Expression<int>? createdAtMs,
    Expression<String>? feedbackType,
    Expression<String>? message,
    Expression<String>? appVersion,
    Expression<String>? screenContext,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (feedbackType != null) 'feedback_type': feedbackType,
      if (message != null) 'message': message,
      if (appVersion != null) 'app_version': appVersion,
      if (screenContext != null) 'screen_context': screenContext,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedbackItemsCompanion copyWith({
    Value<String>? id,
    Value<int>? createdAtMs,
    Value<String>? feedbackType,
    Value<String>? message,
    Value<String?>? appVersion,
    Value<String?>? screenContext,
    Value<int?>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return FeedbackItemsCompanion(
      id: id ?? this.id,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      feedbackType: feedbackType ?? this.feedbackType,
      message: message ?? this.message,
      appVersion: appVersion ?? this.appVersion,
      screenContext: screenContext ?? this.screenContext,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (feedbackType.present) {
      map['feedback_type'] = Variable<String>(feedbackType.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String>(appVersion.value);
    }
    if (screenContext.present) {
      map['screen_context'] = Variable<String>(screenContext.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedbackItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('feedbackType: $feedbackType, ')
          ..write('message: $message, ')
          ..write('appVersion: $appVersion, ')
          ..write('screenContext: $screenContext, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
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
  late final $FocusAreaSettingsStatesTable focusAreaSettingsStates =
      $FocusAreaSettingsStatesTable(this);
  late final $FeedbackItemsTable feedbackItems = $FeedbackItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    historyEntries,
    companionEventStates,
    companionIdentityStates,
    focusAreaSettingsStates,
    feedbackItems,
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
      Value<String> sleepSound,
      Value<String> selectedSymbol,
      Value<String> backgroundTone,
      Value<int> updatedAtMs,
    });
typedef $$CompanionIdentityStatesTableUpdateCompanionBuilder =
    CompanionIdentityStatesCompanion Function({
      Value<int> id,
      Value<String?> companionName,
      Value<String?> userName,
      Value<String> sleepSound,
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

  ColumnFilters<String> get sleepSound => $composableBuilder(
    column: $table.sleepSound,
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

  ColumnOrderings<String> get sleepSound => $composableBuilder(
    column: $table.sleepSound,
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

  GeneratedColumn<String> get sleepSound => $composableBuilder(
    column: $table.sleepSound,
    builder: (column) => column,
  );

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
                Value<String> sleepSound = const Value.absent(),
                Value<String> selectedSymbol = const Value.absent(),
                Value<String> backgroundTone = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
              }) => CompanionIdentityStatesCompanion(
                id: id,
                companionName: companionName,
                userName: userName,
                sleepSound: sleepSound,
                selectedSymbol: selectedSymbol,
                backgroundTone: backgroundTone,
                updatedAtMs: updatedAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> companionName = const Value.absent(),
                Value<String?> userName = const Value.absent(),
                Value<String> sleepSound = const Value.absent(),
                Value<String> selectedSymbol = const Value.absent(),
                Value<String> backgroundTone = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
              }) => CompanionIdentityStatesCompanion.insert(
                id: id,
                companionName: companionName,
                userName: userName,
                sleepSound: sleepSound,
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
typedef $$FocusAreaSettingsStatesTableCreateCompanionBuilder =
    FocusAreaSettingsStatesCompanion Function({
      required String id,
      Value<bool> enabled,
      Value<int> startHour,
      Value<int> endHour,
      Value<String?> activeWindowsJson,
      Value<String> modus,
      Value<bool> isSelected,
      Value<int?> updatedAtMs,
      Value<int> rowid,
    });
typedef $$FocusAreaSettingsStatesTableUpdateCompanionBuilder =
    FocusAreaSettingsStatesCompanion Function({
      Value<String> id,
      Value<bool> enabled,
      Value<int> startHour,
      Value<int> endHour,
      Value<String?> activeWindowsJson,
      Value<String> modus,
      Value<bool> isSelected,
      Value<int?> updatedAtMs,
      Value<int> rowid,
    });

class $$FocusAreaSettingsStatesTableFilterComposer
    extends Composer<_$AppDatabase, $FocusAreaSettingsStatesTable> {
  $$FocusAreaSettingsStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startHour => $composableBuilder(
    column: $table.startHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endHour => $composableBuilder(
    column: $table.endHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activeWindowsJson => $composableBuilder(
    column: $table.activeWindowsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modus => $composableBuilder(
    column: $table.modus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FocusAreaSettingsStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $FocusAreaSettingsStatesTable> {
  $$FocusAreaSettingsStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startHour => $composableBuilder(
    column: $table.startHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endHour => $composableBuilder(
    column: $table.endHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activeWindowsJson => $composableBuilder(
    column: $table.activeWindowsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modus => $composableBuilder(
    column: $table.modus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FocusAreaSettingsStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FocusAreaSettingsStatesTable> {
  $$FocusAreaSettingsStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get startHour =>
      $composableBuilder(column: $table.startHour, builder: (column) => column);

  GeneratedColumn<int> get endHour =>
      $composableBuilder(column: $table.endHour, builder: (column) => column);

  GeneratedColumn<String> get activeWindowsJson => $composableBuilder(
    column: $table.activeWindowsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modus =>
      $composableBuilder(column: $table.modus, builder: (column) => column);

  GeneratedColumn<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$FocusAreaSettingsStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FocusAreaSettingsStatesTable,
          FocusAreaSettingsStateRow,
          $$FocusAreaSettingsStatesTableFilterComposer,
          $$FocusAreaSettingsStatesTableOrderingComposer,
          $$FocusAreaSettingsStatesTableAnnotationComposer,
          $$FocusAreaSettingsStatesTableCreateCompanionBuilder,
          $$FocusAreaSettingsStatesTableUpdateCompanionBuilder,
          (
            FocusAreaSettingsStateRow,
            BaseReferences<
              _$AppDatabase,
              $FocusAreaSettingsStatesTable,
              FocusAreaSettingsStateRow
            >,
          ),
          FocusAreaSettingsStateRow,
          PrefetchHooks Function()
        > {
  $$FocusAreaSettingsStatesTableTableManager(
    _$AppDatabase db,
    $FocusAreaSettingsStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FocusAreaSettingsStatesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$FocusAreaSettingsStatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FocusAreaSettingsStatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> startHour = const Value.absent(),
                Value<int> endHour = const Value.absent(),
                Value<String?> activeWindowsJson = const Value.absent(),
                Value<String> modus = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
                Value<int?> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FocusAreaSettingsStatesCompanion(
                id: id,
                enabled: enabled,
                startHour: startHour,
                endHour: endHour,
                activeWindowsJson: activeWindowsJson,
                modus: modus,
                isSelected: isSelected,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<bool> enabled = const Value.absent(),
                Value<int> startHour = const Value.absent(),
                Value<int> endHour = const Value.absent(),
                Value<String?> activeWindowsJson = const Value.absent(),
                Value<String> modus = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
                Value<int?> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FocusAreaSettingsStatesCompanion.insert(
                id: id,
                enabled: enabled,
                startHour: startHour,
                endHour: endHour,
                activeWindowsJson: activeWindowsJson,
                modus: modus,
                isSelected: isSelected,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FocusAreaSettingsStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FocusAreaSettingsStatesTable,
      FocusAreaSettingsStateRow,
      $$FocusAreaSettingsStatesTableFilterComposer,
      $$FocusAreaSettingsStatesTableOrderingComposer,
      $$FocusAreaSettingsStatesTableAnnotationComposer,
      $$FocusAreaSettingsStatesTableCreateCompanionBuilder,
      $$FocusAreaSettingsStatesTableUpdateCompanionBuilder,
      (
        FocusAreaSettingsStateRow,
        BaseReferences<
          _$AppDatabase,
          $FocusAreaSettingsStatesTable,
          FocusAreaSettingsStateRow
        >,
      ),
      FocusAreaSettingsStateRow,
      PrefetchHooks Function()
    >;
typedef $$FeedbackItemsTableCreateCompanionBuilder =
    FeedbackItemsCompanion Function({
      required String id,
      required int createdAtMs,
      required String feedbackType,
      required String message,
      Value<String?> appVersion,
      Value<String?> screenContext,
      Value<int?> updatedAtMs,
      Value<int> rowid,
    });
typedef $$FeedbackItemsTableUpdateCompanionBuilder =
    FeedbackItemsCompanion Function({
      Value<String> id,
      Value<int> createdAtMs,
      Value<String> feedbackType,
      Value<String> message,
      Value<String?> appVersion,
      Value<String?> screenContext,
      Value<int?> updatedAtMs,
      Value<int> rowid,
    });

class $$FeedbackItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedbackItemsTable> {
  $$FeedbackItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedbackType => $composableBuilder(
    column: $table.feedbackType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get screenContext => $composableBuilder(
    column: $table.screenContext,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeedbackItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedbackItemsTable> {
  $$FeedbackItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedbackType => $composableBuilder(
    column: $table.feedbackType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get screenContext => $composableBuilder(
    column: $table.screenContext,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeedbackItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedbackItemsTable> {
  $$FeedbackItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get feedbackType => $composableBuilder(
    column: $table.feedbackType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get screenContext => $composableBuilder(
    column: $table.screenContext,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$FeedbackItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedbackItemsTable,
          FeedbackItemRow,
          $$FeedbackItemsTableFilterComposer,
          $$FeedbackItemsTableOrderingComposer,
          $$FeedbackItemsTableAnnotationComposer,
          $$FeedbackItemsTableCreateCompanionBuilder,
          $$FeedbackItemsTableUpdateCompanionBuilder,
          (
            FeedbackItemRow,
            BaseReferences<_$AppDatabase, $FeedbackItemsTable, FeedbackItemRow>,
          ),
          FeedbackItemRow,
          PrefetchHooks Function()
        > {
  $$FeedbackItemsTableTableManager(_$AppDatabase db, $FeedbackItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedbackItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedbackItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedbackItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<String> feedbackType = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> appVersion = const Value.absent(),
                Value<String?> screenContext = const Value.absent(),
                Value<int?> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedbackItemsCompanion(
                id: id,
                createdAtMs: createdAtMs,
                feedbackType: feedbackType,
                message: message,
                appVersion: appVersion,
                screenContext: screenContext,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int createdAtMs,
                required String feedbackType,
                required String message,
                Value<String?> appVersion = const Value.absent(),
                Value<String?> screenContext = const Value.absent(),
                Value<int?> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedbackItemsCompanion.insert(
                id: id,
                createdAtMs: createdAtMs,
                feedbackType: feedbackType,
                message: message,
                appVersion: appVersion,
                screenContext: screenContext,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeedbackItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedbackItemsTable,
      FeedbackItemRow,
      $$FeedbackItemsTableFilterComposer,
      $$FeedbackItemsTableOrderingComposer,
      $$FeedbackItemsTableAnnotationComposer,
      $$FeedbackItemsTableCreateCompanionBuilder,
      $$FeedbackItemsTableUpdateCompanionBuilder,
      (
        FeedbackItemRow,
        BaseReferences<_$AppDatabase, $FeedbackItemsTable, FeedbackItemRow>,
      ),
      FeedbackItemRow,
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
  $$FocusAreaSettingsStatesTableTableManager get focusAreaSettingsStates =>
      $$FocusAreaSettingsStatesTableTableManager(
        _db,
        _db.focusAreaSettingsStates,
      );
  $$FeedbackItemsTableTableManager get feedbackItems =>
      $$FeedbackItemsTableTableManager(_db, _db.feedbackItems);
}
