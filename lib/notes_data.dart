
class Note {
  String title = '';
  String details = '';


  Note({required this.title, required this.details});

}

class Notes {
  List<Note> note = [];

  void updateList(Note note) {
    this.note.add(note);

  }
}