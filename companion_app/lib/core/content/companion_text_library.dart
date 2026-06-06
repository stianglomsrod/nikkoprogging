import 'package:companion_app/core/models/sinnsstemning.dart';

class CompanionTextLibrary {
  static const greetings = [
    'Hei.',
    'Hei venn.',
    'Fint å se deg.',
    'Hei igjen.',
    'Jeg er her.',
  ];

  static const memoryMessages = [
    'Du har holdt dette litt i gang.',
    'Jeg ser at du kommer tilbake.',
    'Du får til små ting innimellom, og det teller.',
    'Det virker som du prøver, steg for steg.',
    'Du er fortsatt her, og det betyr noe.',
    'Det går i små bølger, og det er greit.',
    'Du har gjort mer enn du kanskje tenker over.',
    'Det er en slags rytme i det du gjør.',
  ];

  static const nameUnlockMessage =
      'Hei! Du har vært veldig flink. Jeg ønsker at du skal gi meg et nytt navn om du vil. Gleder meg til å bli bedre kjent med deg.';

  static const moodQuestions = [
    'Hvordan har du det i dag?',
    'Hvordan kjennes dagen ut?',
    'Hva skjer hos deg i dag?',
    'Hvordan er formen din akkurat nå?',
    'Hvordan oppleves dagen så langt?',
    'Hva slags dag er dette for deg?',
    'Hvordan står det til akkurat nå?',
    'Hvordan føles ting akkurat nå?',
  ];

  static const streakMessages = [
    'Vi kan roe ned litt nå.',
    'Det er greit å ikke presse videre.',
    'Du trenger ikke gjøre noe akkurat nå.',
    'Jeg er her, vi tar det rolig.',
    'Det er lov å bare stoppe litt opp.',
    'Vi senker tempoet litt.',
  ];

  static const taskRequestPhrases = [
    'Kan du prøve dette:',
    'La oss teste denne oppgaven:',
    'Dette kan være fint å gjøre:',
    'Her er en liten oppgave:',
    'Kanskje du kan prøve dette:',
    'Et lite forslag:',
    'Hvis det passer:',
  ];

  static const negativeTasks = [
    'sette en kopp i oppvaskmaskinen',
    'kaste en ting i søpla',
    'lukke en skuff',
    'rette opp en pute',
    'legge en ting tilbake på plass',
    'ta med en kopp til kjøkkenet',
    'flytte en ting fra gulvet',
    'tørke av en liten flekk',
    'legge en genser i skittentøykurven',
    'sette en flaske i pantposen',
  ];

  static const okTasks = [
    'rydde tre ting fra bordet',
    'samle kopper fra ett rom',
    'legge tre ting tilbake på plass',
    'rydde litt av kjøkkenbenken',
    'sette noen klær i skittentøykurven',
    'tørke av spisebordet',
    'rydde sofaområdet litt',
    'kaste gammel reklame eller papir',
    'samle sammen ting som ligger på gulvet',
    'brette noen få plagg med klær',
  ];

  static const energiskTasks = [
    'rydde hele kjøkkenbenken',
    'støvsuge ett rom',
    'tomme oppvaskmaskinen',
    'rydde stuebordet helt',
    'ta ut søpla i huset',
    'samle kopper i hele boligen',
    'tørke støv av hyller',
    'rydde gulvet i ett rom',
    'vaske badet',
    'organisere kjøleskapet litt',
  ];

  static const moodFeedback = {
    'negativ': [
      'Takk for at du sier det.',
      'Jeg er her med deg.',
      'Det er helt greit sånn.',
      'Vi tar det i ditt tempo.',
      'Du står ikke i det alene.',
      'Det er ok å ha det sånn i dag.',
    ],
    'ok': [
      'Greit, vi tar det videre.',
      'Ok, det er fint.',
      'Skjønner, vi fortsetter rolig.',
      'Greit, vi holder det enkelt.',
      'Ok, vi går videre.',
      'Fint, da vet jeg det.',
    ],
    'energisk': [
      'Fint, da bruker vi det rolig og godt.',
      'Det er godt å kjenne litt energi.',
      'Da finner vi noe som passer.',
      'Greit, da setter vi i gang med noe lite.',
      'Det er fint å vite.',
      'Da går vi videre med et lite steg.',
    ],
  };

  static const taskDoneYes = {
    'negativ': [
      'Det der var faktisk ganske sterkt gjort.',
      'Du fikk det til, selv om det ikke var lett.',
      'Det teller mer enn det virker.',
      'Bra jobba, spesielt i dag.',
      'Det var et viktig lite steg.',
      'Du gjorde noe som ikke var så enkelt.',
    ],
    'ok': [
      'Bra jobba.',
      'Fint gjort.',
      'Det der var solid.',
      'Godt levert.',
      'Det var bra å få gjort.',
      'Fint, vi holder det gående.',
    ],
    'energisk': [
      'Sterkt levert!',
      'Du får ting gjort.',
      'Skikkelig bra tempo!',
      'Dette flyter bra!',
      'God driv i dag!',
      'Du er i gang!',
    ],
  };

  static const taskDoneNo = [
    'Helt greit.',
    'Ingen stress.',
    'Vi tar det senere.',
    'Det er ok å la det ligge.',
    'Vi prøver igjen en annen gang.',
    'Det går fint.',
    'Ikke noe problem.',
  ];

  static const taskDoneEventPositive = [
    'Det er fint å se litt flyt i ting.',
    'Du har fått gjort noe i dag, det teller.',
    'Det er en god retning dette.',
    'Du er i gang, og det er bra nok.',
    'Det går jevnt fremover.',
  ];

  static const eventContinueOptions = [
    'fortsette litt til',
    'ta en liten oppgave til',
    'holde det gående litt',
    'gjøre en ting til',
    'fortsette rolig',
  ];

  static const eventPauseOptions = [
    'ta en pause',
    'stoppe litt her',
    'roe ned nå',
    'ta en liten pause',
    'avslutte for nå',
  ];

  static const eventTransitionText = [
    'vi tar et lite øyeblikk',
    'bare et lite stopp her',
    'la oss pause litt',
    'vi sjekker inn litt her',
    'vi justerer litt nå',
  ];

  static String moodKey(Sinnsstemning mood) {
    switch (mood) {
      case Sinnsstemning.negativ:
        return 'negativ';
      case Sinnsstemning.ok:
        return 'ok';
      case Sinnsstemning.energisk:
        return 'energisk';
    }
  }
}
