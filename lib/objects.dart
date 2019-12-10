import 'package:intl/intl.dart';

class TaskObject {
  final int id;
  final String titolo;
  final int materia;
  final String argomento;
  final int _date;

  DateTime get date {
    return DateTime.fromMillisecondsSinceEpoch(_date * 1000);
  }

  String get dateStringValue {
    final String day = DateFormat('EEEE').format(date);
    return "$day - ${date.day}/${date.month}/${date.year}";
  }

  String get materiaString {
    return Materia().getMateriaString(materia);
  }

  TaskObject(this.id, this.titolo, this.materia, this.argomento, this._date);
}

class Materia {
  String getMateriaString(int integer) {
    var materia;

    switch (integer) {
      case 1:
        {
          materia = "Italiano";
        }
        break;
      case 2:
        {
          materia = "Storia";
        }
        break;
        case 3:
        {
          materia = "Inglese";
        }
        break;
        case 4:
        {
          materia = "Tec. Mecc.";
        }
        break;
        case 5:
        {
          materia = "TIM";
        }
        break;
        case 6:
        {
          materia = "Elettronica";
        }
        break;
        case 7:
        {
          materia = "Matematica";
        }
        break;
        case 8:
        {
          materia = "Motoria";
        }
        break;
        case 9:
        {
          materia = "Laboratorio";
        }
        break;
        default: 
          {
            materia = "NULL";
          }
          break;
    }

    return materia;
  }
}