class TaskObject {
  final int id;
  final String titolo;
  final int materia;
  final String argomento;
  final int _date;

  DateTime get date {
    return DateTime.now();
  }



  TaskObject(this.id, this.titolo, this.materia, this.argomento, this._date);
}