import 'package:tiktok_clone/practice/music_notation/utils/note.dart';

class TwelveTone {
  final Set<Solfege> _notes;

  TwelveTone({required Set<Solfege> notes}) : _notes = notes.validityCheck();

  List<Solfege> get notes => _notes.toList();

  List<int> get _intervals {
    List<int> result = [];
    for (int i = 0; i < 11; i++) {
      result.add(notes[i].gapBetween(notes[i + 1]));
    }
    return result;
  }

  List<int> get _invertedIntervals {
    List<int> result = [];
    for (var element in _intervals) {
      result.add((element - 12).abs());
    }
    return result;
  }

  List<Solfege> primary(int order) {
    if (order > 11) {
      throw Error();
    }
    Solfege startPoint = notes[order];
    List<Solfege> result = [startPoint];
    for (int i = 0; i < 11; i++) {
      result.add(result[i] - _intervals[i]);
    }
    return result;
  }
}

extension SolfegeSet on Set<Solfege> {
  Set<Solfege> validityCheck() {
    if (length == 12) {
      return this;
    } else {
      throw "length of twelve tone must be twelve";
    }
  }
}
