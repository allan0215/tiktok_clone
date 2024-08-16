void main() {
  print(Solfege.C.gapBetween(Solfege.G));
}

enum Solfege { C, Db, D, Eb, E, F, Gb, G, Ab, A, Bb, B }

enum TypeOfChord { maj, min, dim, aug }

enum TypeOfSeventh { maj, min, dim }

class MusicalVar {
  static const int min2 = 1;
  static const int maj2 = 2;
  static const int min3 = 3;
  static const int maj3 = 4;
  static const int per4 = 5;
  static const int tritone = 6;
  static const int per5 = 7;
  static const int min6 = 8;
  static const int maj6 = 9;
  static const int min7 = 10;
  static const int maj7 = 11;
  static const int octave = 12;

  static const int bassMin = 40;
  static const int bassMax = 60;
  static const int tenorMin = 48;
  static const int tenorMax = 67;
  static const int altoMin = 55;
  static const int altoMax = 74;
  static const int sopranoMin = 60;
  static const int sopranoMax = 81;

  static const List<String> noteNameInFlat = [
    'C',
    'Db',
    'D',
    'Eb',
    'E',
    'F',
    'Gb',
    'G',
    'Ab',
    'A',
    'Bb',
    'B'
  ];

  static const List<String> noteNameInSharp = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B'
  ];
}

class Note {
  final int _midiNumber;

  Note({required int midiNumber}) : _midiNumber = midiNumber;

  Note.fromSolfege({required Solfege solfege, required int octave})
      : _midiNumber = solfege.index + ((octave + 2) * 12);

  int get midiNumber => _midiNumber;
  Solfege get solfege => Solfege.values[midiNumber % 12];
  int get octave => (midiNumber ~/ 12) - 2;

  Note operator +(int degree) => Note(midiNumber: _midiNumber + degree);
  Note operator -(int degree) => Note(midiNumber: _midiNumber - degree);

  String get noteName {
    String solfegeName = solfege.toString().replaceAll("Solfege.", "");
    return "$solfegeName${octave.toString()}";
  }

  List<Note> notesFromRange(Solfege solfege, int under, int over) {
    List<Note> result = [];
    final int downLimit = midiNumber - under;
    final int upLimit = midiNumber + over;
    for (int i = 0; i < 13; i++) {
      if ((i * 12) + solfege.index >= downLimit &&
          (i * 12) + solfege.index <= upLimit) {
        result.add(Note(midiNumber: (i * 12) + solfege.index));
      }
    }
    return result;
  }

  @override
  int get hashCode => Object.hash(_midiNumber, solfege, octave);

  @override
  bool operator ==(Object other) {
    return (other is Note && (midiNumber == other.midiNumber));
  }
}

class Chord {
  final List<Note> _notes;

  Chord({required List<Note> notes}) : _notes = notes.sortByMidi();

  Note get lowestNote => _notes[0];

  Note get highestNote => _notes[_notes.length - 1];
}

// TODO: 너무 난잡함
class SATB extends Chord {
  int _bassMin,
      _bassMax,
      _tenorMin,
      _tenorMax,
      _altoMin,
      _altoMax,
      _sopranoMin,
      _sopranoMax;
  @override
  final List<Note> _notes;

  SATB(
      {required super.notes,
      int bassMin = MusicalVar.bassMin,
      int bassMax = MusicalVar.bassMax,
      int tenorMin = MusicalVar.tenorMin,
      int tenorMax = MusicalVar.tenorMax,
      int altoMin = MusicalVar.altoMin,
      int altoMax = MusicalVar.altoMax,
      int sopranoMin = MusicalVar.sopranoMin,
      int sopranoMax = MusicalVar.sopranoMax})
      : _bassMin = bassMin,
        _bassMax = bassMax,
        _tenorMin = tenorMin,
        _tenorMax = tenorMax,
        _altoMin = altoMin,
        _altoMax = altoMax,
        _sopranoMin = sopranoMin,
        _sopranoMax = sopranoMax,
        _notes = notes.checkSATBValidiy(
            bassMin: bassMin,
            bassMax: bassMax,
            tenorMin: tenorMin,
            tenorMax: tenorMax,
            altoMin: altoMin,
            altoMax: altoMax,
            sopranoMin: sopranoMin,
            sopranoMax: sopranoMax);

  int get bassMin => _bassMin;
  int get bassMax => _bassMax;
  int get tenorMin => _tenorMin;
  int get tenorMax => _tenorMax;
  int get altoMin => _altoMin;
  int get altoMax => _altoMax;
  int get sopranoMin => _sopranoMin;
  int get sopranoMax => _sopranoMax;
  Note get bass => _notes[0];
  Note get tenor => _notes[1];
  Note get alto => _notes[2];
  Note get soprano => _notes[3];
}

class Harmony {
  final Solfege _root, _third, _fifth;
  final Solfege? _seventh;
  final TypeOfChord _type;
  final TypeOfSeventh? _seventhType;

  Harmony(
      {required Solfege root,
      required TypeOfChord type,
      TypeOfSeventh? seventhType})
      : _root = root,
        _third = type == TypeOfChord.min
            ? root + MusicalVar.min3
            : root + MusicalVar.maj3,
        _fifth = root.fifthCal(type),
        _seventh = seventhType == null ? null : root.seventhCal(seventhType),
        _seventhType = seventhType,
        _type = type;

  Solfege get root => _root;

  Solfege get third => _third;

  Solfege get fifth => _fifth;

  Solfege? get seventh => _seventh;

  TypeOfChord get type => _type;

  TypeOfSeventh? get seventhType => _seventhType;

  @override
  String toString() {
    String rootString = _root.toString().replaceAll("Solfege.", "");
    String typeString = _type.toString().replaceAll("TypeOfChord.", "");
    if (seventhType == null) {
      return "$rootString$typeString";
    } else {
      String seventhString =
          _seventhType.toString().replaceAll("TypeOfSeventh.", "");
      String chordString = "$typeString${seventhString}7";

      switch (chordString) {
        case "majmaj7":
          return "${rootString}maj7";
        case "majmin7":
          return "${rootString}7";
        case "minmin7":
          return "${rootString}min7";
        case "dimdim7":
          return "${rootString}dim7";
        case "dimmin7":
          return "${rootString}halfdim";
      }
      return "$rootString$chordString";
    }
  }
}

/// extension

extension noteListExtension on List<Note> {
  List<Note> sortByMidi() {
    List<Note> result = this;
    result.sort((a, b) => a.midiNumber.compareTo(b.midiNumber));
    return result;
  }

  List<Note> operator -(Object other) {
    if (other is Solfege) {
      int index = other.index;
      removeWhere((element) => element.midiNumber % 12 == index);
      return this;
    } else if (other is List<Note>) {
      removeWhere((element) => other.contains(element));
      return this;
    }
    throw Error();
  }

  List<Note> checkSATBValidiy(
      {required int bassMin,
      required int bassMax,
      required int tenorMin,
      required int tenorMax,
      required int altoMin,
      required int altoMax,
      required int sopranoMin,
      required int sopranoMax}) {
    var result = sortByMidi();
    if (result.length != 4) {
      throw "SATB chord must have 4 notes";
    }
    String errorString = "";
    var [
      bassCheck,
      tenorCheck,
      altoCheck,
      sopranoCheck
    ] = [false, false, false, false];
    result[0].midiNumber < bassMin || result[0].midiNumber > bassMax
        ? errorString += "bass"
        : bassCheck = true;
    result[1].midiNumber < tenorMin || result[1].midiNumber > tenorMax
        ? errorString += ",tenor"
        : tenorCheck = true;
    result[2].midiNumber < altoMin || result[2].midiNumber > altoMax
        ? errorString += ",alto"
        : altoCheck = true;
    result[3].midiNumber < sopranoMin || result[3].midiNumber > sopranoMax
        ? errorString += ",soprano"
        : sopranoCheck = true;

    if (bassCheck && tenorCheck && altoCheck && sopranoCheck) {
      return result;
    } else {
      throw errorString;
    }
  }
}

extension SolfegeExtension on Solfege {
  Solfege fifthCal(TypeOfChord type) {
    switch (type) {
      case TypeOfChord.maj || TypeOfChord.min:
        return this + MusicalVar.per5;
      case TypeOfChord.dim:
        return this + MusicalVar.tritone;
      case TypeOfChord.aug:
        return this + MusicalVar.min6;
    }
  }

  Solfege seventhCal(TypeOfSeventh seventhType) {
    switch (seventhType) {
      case TypeOfSeventh.maj:
        return this + MusicalVar.maj7;
      case TypeOfSeventh.min:
        return this + MusicalVar.min7;
      case TypeOfSeventh.dim:
        return this + MusicalVar.maj6;
    }
  }

  Solfege operator +(int other) {
    final int degree = other % 12;
    int index = this.index + degree;
    index = index >= 0 ? index % 12 : index + 12;
    return Solfege.values[index];
  }

  Solfege operator -(int other) {
    final int degree = other % 12;
    int index = this.index - degree;
    index = index < 0 ? index + 12 : index % 12;
    return Solfege.values[index];
  }

  int gapBetween(Solfege other) => (index - other.index);
}
