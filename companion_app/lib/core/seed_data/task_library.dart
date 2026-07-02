import 'package:companion_app/core/content/companion_text_library.dart';
import 'package:companion_app/core/models/task_item.dart';

class TaskLibrary {
  static const List<String> _studyLowTasks = <String>[
    'åpne notatene',
    'finne fram riktig fag',
    'lese 1 setning i pensum',
    'markere 1 linje i tekst',
    'skrive ned 1 begrep',
    'se på overskriften i kapittelet',
    'åpne læringsplattformen',
    'starte en video',
    'finne fram 1 oppgave',
    'skrive 1 tanke om faget',
  ];

  static const List<String> _studyOkTasks = <String>[
    'lese 1 side i pensum',
    'ta korte notater fra 1 avsnitt',
    'løse 1 oppgave i øvingssett',
    'repetere stoff i 10 minutter',
    'lage en kort oppsummering av 1 tema',
    'svare på 1 spørsmål fra læreboka',
    'se ferdig en læringsvideo på 10 minutter',
    'forklare 1 begrep med egne ord',
    'lage en enkel huskeliste fra 1 tema',
    'jobbe fokusert i 10 minutter med fag',
  ];

  static const List<String> _studyEnergicTasks = <String>[
    'lese 3 sider i pensum',
    'skrive 3 notater fra teksten',
    'lese 3 sider og skrive 2 notater',
    'jobbe 30 minutter med fag',
    'forberede deg til 1 test eller quiz',
    'lage 5 egne spørsmål og svare på dem',
    'løse 3 eksamensoppgaver',
    'lage oversikt over 1 tema i punktform',
    'lage tankekart for 1 fagområde',
    'lese 5 sider i pensum',
    'repetere 1 helt tema i 30 minutter',
  ];

  static const List<String> _trainingLowTasks = <String>[
    'ta på treningstøy',
    'gå til ytterdøra og tilbake',
    'gjøre 5 knebøy',
    'strekke kroppen i 2 minutter',
    'drikke 1 glass vann',
    'åpne treningsvideo',
    'sette på treningsmusikk',
    'rulle skuldrene i 30 sekunder',
    'reise deg opp og stå i 1 minutt',
    'ta 5 rolige pust mens du står',
  ];

  static const List<String> _trainingOkTasks = <String>[
    'gå en tur i 15 minutter',
    'gjøre 12 knebøy',
    'ta en joggetur i 15 minutter',
    'gjøre 1 styrkeøkt hjemme i 15 minutter',
    'strekkøkt i 10 minutter',
    'gjøre 3 runder med sirkeltrening',
    'sykle i 20 minutter',
    'gjøre 10 pushups',
    'trene i 15 minutter',
    'trene hele kroppen i 20 minutter',
  ];

  static const List<String> _trainingEnergicTasks = <String>[
    'gjennomføre 1 treningsøkt på 45 minutter',
    'løpe i 45 minutter',
    'gjøre 1 styrkeøkt på 45 minutter',
    'kjøre 1 intervalløkt på 30 minutter',
    'gjøre 1 sirkeltrening på 30 minutter',
    'trene bein og overkropp i 45 minutter',
    'gjøre kondisjonsøkt på 45 minutter',
    'sette 1 personlig rekord i en øvelse',
    'kombinere styrke og kondisjon i 45 minutter',
    'trene i 45 minutter sammenhengende',
  ];

  static const List<String> _reminderLowTasks = <String>[
    'åpne kalenderen',
    'sjekke dagens planer',
    'se på to-do listen',
    'notere 1 ting du må huske',
    'åpne påminnelser',
    'legge inn 1 påminnelse',
    'sjekke neste avtale',
    'finne fram 1 oppgave',
    'markere 1 ting som viktig',
    'slette 1 gammel påminnelse',
  ];

  static const List<String> _reminderOkTasks = <String>[
    'legge inn 3 påminnelser',
    'planlegge morgendagen',
    'flytte 1 oppgave til riktig dag',
    'slette 3 gamle påminnelser',
    'legge inn 2 avtaler i kalender',
    'flytte 2 oppgaver i kalenderen',
    'lage enkel plan for uken',
    'sette opp 1 konkret oppgave for senere',
    'sjekke 5 kommende avtaler',
    'justere 1 oppgave i kalenderen',
  ];

  static const List<String> _reminderEnergicTasks = <String>[
    'rydde i påminnelser i 10 minutter',
    'flytte 10 oppgaver i kalenderen på 25 minutter',
    'planlegge morgendagen steg for steg',
    'justere 5 avtaler i kalenderen',
    'sette opp 5 faste daglige rutiner',
    'legge inn 5 viktige deadlines',
    'jobbe i 25 minutter med oppgaver i kalenderen',
    'planlegge neste uke',
    'legge inn 10 oppgaver én og én',
    'sette opp 5 faste påminnelser',
  ];

  static List<TaskItem> householdTasks() {
    return [
      ..._buildTasks(
        titles: CompanionTextLibrary.negativeTasks,
        difficulty: 1,
        focusAreaId: 'household',
        prefix: 'household_easy',
      ),
      ..._buildTasks(
        titles: CompanionTextLibrary.okTasks,
        difficulty: 2,
        focusAreaId: 'household',
        prefix: 'household_ok',
      ),
      ..._buildTasks(
        titles: CompanionTextLibrary.energiskTasks,
        difficulty: 3,
        focusAreaId: 'household',
        prefix: 'household_energisk',
      ),
    ];
  }

  static List<TaskItem> studyTasks() {
    return [
      ..._buildTasks(
        titles: _studyLowTasks,
        difficulty: 1,
        focusAreaId: 'study',
        prefix: 'study_low',
      ),
      ..._buildTasks(
        titles: _studyOkTasks,
        difficulty: 2,
        focusAreaId: 'study',
        prefix: 'study_ok',
      ),
      ..._buildTasks(
        titles: _studyEnergicTasks,
        difficulty: 3,
        focusAreaId: 'study',
        prefix: 'study_energic',
      ),
    ];
  }

  static List<TaskItem> exerciseTasks() {
    return [
      ..._buildTasks(
        titles: _trainingLowTasks,
        difficulty: 1,
        focusAreaId: 'exercise',
        prefix: 'exercise_low',
      ),
      ..._buildTasks(
        titles: _trainingOkTasks,
        difficulty: 2,
        focusAreaId: 'exercise',
        prefix: 'exercise_ok',
      ),
      ..._buildTasks(
        titles: _trainingEnergicTasks,
        difficulty: 3,
        focusAreaId: 'exercise',
        prefix: 'exercise_energic',
      ),
    ];
  }

  static List<TaskItem> reminderTasks() {
    return [
      ..._buildTasks(
        titles: _reminderLowTasks,
        difficulty: 1,
        focusAreaId: 'reminders',
        prefix: 'reminder_low',
      ),
      ..._buildTasks(
        titles: _reminderOkTasks,
        difficulty: 2,
        focusAreaId: 'reminders',
        prefix: 'reminder_ok',
      ),
      ..._buildTasks(
        titles: _reminderEnergicTasks,
        difficulty: 3,
        focusAreaId: 'reminders',
        prefix: 'reminder_energic',
      ),
    ];
  }

  static List<TaskItem> _buildTasks({
    required List<String> titles,
    required int difficulty,
    required String focusAreaId,
    required String prefix,
  }) {
    return [
      for (int index = 0; index < titles.length; index++)
        TaskItem(
          id: '${prefix}_$index',
          focusAreaId: focusAreaId,
          title: _capitalize(titles[index]),
          difficulty: difficulty,
        ),
    ];
  }

  static String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }
    return '${value[0].toUpperCase()}${value.substring(1)}.';
  }
}
