class VelaInterface {
  String? id = '';
  DateTime? data = DateTime.now();
  String? intencao = '';
  int? minutosrestantes = 0;
  String? destinatario = '';
  String? solicitanteemail = '';
  String? solicitantenome = '';
  String? texto = '';
  DateTime? dataInclusao = DateTime.now();

  String tempoRestante() {
    String horas = (minutosrestantes! ~/ 60).toInt().toString().padLeft(2, '0');
    String minutos = (minutosrestantes! % 60).toString().padLeft(2, '0');
    return '$horas:$minutos';
  }
}

class ConfigVela {
  int duracaoMinutos = 240;

  int minutosRestantes(int minutos) {
    return duracaoMinutos - minutos;
  }
}
