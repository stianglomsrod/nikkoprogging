import 'package:companion_app/core/models/sinnsstemning.dart';

class CompanionTextLibrary {
  static const greetings = [
    'Hei.',
    'Hei venn.',
    'Fint a se deg.',
    'Hei igjen.',
    'Jeg er her.',
  ];

  static const memoryMessages = [
    'Du har holdt dette litt i gang.',
    'Jeg ser at du kommer tilbake.',
    'Du far til sma ting innimellom, og det teller.',
    'Det virker som du prover, steg for steg.',
    'Du er fortsatt her, og det betyr noe.',
    'Det gar i sma bolger, og det er greit.',
    'Du har gjort mer enn du kanskje tenker over.',
    'Det er en slags rytme i det du gjor.',
  ];

  static const nameUnlockMessage =
      'Hei! Du har vaert veldig flink. Jeg onsker at du skal gi meg et nytt navn om du vil. Gleder meg til a bli bedre kjent med deg.';

  static const moodQuestions = [
    'Hvordan har du det i dag?',
    'Hvordan kjennes dagen ut?',
    'Hva skjer hos deg i dag?',
    'Hvordan er formen din akkurat na?',
    'Hvordan oppleves dagen sa langt?',
    'Hva slags dag er dette for deg?',
    'Hvordan star det til akkurat na?',
    'Hvordan foles ting akkurat na?',
  ];

  static const streakMessages = [
    'Vi kan roe ned litt na.',
    'Det er greit a ikke presse videre.',
    'Du trenger ikke gjore noe akkurat na.',
    'Jeg er her, vi tar det rolig.',
    'Det er lov a bare stoppe litt opp.',
    'Vi senker tempoet litt.',
  ];

  static const taskRequestPhrases = [
    'Kan du prove dette:',
    'La oss teste denne oppgaven:',
    'Dette kan vaere fint a gjore:',
    'Her er en liten oppgave:',
    'Kanskje du kan prove dette:',
    'Et lite forslag:',
    'Hvis det passer:',
  ];

  static const negativeTasks = [
    'sette en kopp i oppvaskmaskinen',
    'kaste en ting i sopla',
    'lukke en skuff',
    'rette opp en pute',
    'legge en ting tilbake pa plass',
    'ta med en kopp til kjokkenet',
    'flytte en ting fra gulvet',
    'torke av en liten flekk',
    'legge en genser i skittentoykurven',
    'sette en flaske i pantposen',
  ];

  static const okTasks = [
    'rydde tre ting fra bordet',
    'samle kopper fra ett rom',
    'legge tre ting tilbake pa plass',
    'rydde litt av kjokkenbenken',
    'sette noen klaer i skittentoykurven',
    'torke av spisebordet',
    'rydde sofaomradet litt',
    'kaste gammel reklame eller papir',
    'samle sammen ting som ligger pa gulvet',
    'brette noen fa plagg med klaer',
  ];

  static const energiskTasks = [
    'rydde hele kjokkenbenken',
    'stovsuge ett rom',
    'tomme oppvaskmaskinen',
    'rydde stuebordet helt',
    'ta ut sopla i huset',
    'samle kopper i hele boligen',
    'torke stov av hyller',
    'rydde gulvet i ett rom',
    'vaske badet',
    'organisere kjoleskapet litt',
  ];

  static const moodFeedback = {
    'negativ': [
      'Takk for at du sier det.',
      'Jeg er her med deg.',
      'Det er helt greit sann.',
      'Vi tar det i ditt tempo.',
      'Du star ikke i det alene.',
      'Det er ok a ha det sann i dag.',
    ],
    'ok': [
      'Greit, vi tar det videre.',
      'Ok, det er fint.',
      'Skjonner, vi fortsetter rolig.',
      'Greit, vi holder det enkelt.',
      'Ok, vi gar videre.',
      'Fint, da vet jeg det.',
    ],
    'energisk': [
      'Fint, da bruker vi det rolig og godt.',
      'Det er godt a kjenne litt energi.',
      'Da finner vi noe som passer.',
      'Greit, da setter vi i gang med noe lite.',
      'Det er fint a vite.',
      'Da gar vi videre med et lite steg.',
    ],
  };

  static const taskDoneYes = {
    'negativ': [
      'Det der var faktisk ganske sterkt gjort.',
      'Du fikk det til, selv om det ikke var lett.',
      'Det teller mer enn det virker.',
      'Bra jobba, spesielt i dag.',
      'Det var et viktig lite steg.',
      'Du gjorde noe som ikke var sa enkelt.',
    ],
    'ok': [
      'Bra jobba.',
      'Fint gjort.',
      'Det der var solid.',
      'Godt levert.',
      'Det var bra a fa gjort.',
      'Fint, vi holder det gaende.',
    ],
    'energisk': [
      'Sterkt levert!',
      'Du far ting gjort.',
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
    'Det er ok a la det ligge.',
    'Vi prover igjen en annen gang.',
    'Det gar fint.',
    'Ikke noe problem.',
  ];

  static const taskDoneEventPositive = [
    'Det er fint a se litt flyt i ting.',
    'Du har fatt gjort noe i dag, det teller.',
    'Det er en god retning dette.',
    'Du er i gang, og det er bra nok.',
    'Det gar jevnt fremover.',
  ];

  static const eventContinueOptions = [
    'fortsette litt til',
    'ta en liten oppgave til',
    'holde det gaende litt',
    'gjore en ting til',
    'fortsette rolig',
  ];

  static const eventPauseOptions = [
    'ta en pause',
    'stoppe litt her',
    'roe ned na',
    'ta en liten pause',
    'avslutte for na',
  ];

  static const eventTransitionText = [
    'vi tar et lite oyeblikk',
    'bare et lite stopp her',
    'la oss pause litt',
    'vi sjekker inn litt her',
    'vi justerer litt na',
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