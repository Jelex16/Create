
import 'package:formz/formz.dart';

enum DateError { empty, format, month, year }

class DateField extends FormzInput<String, DateError> {
  const DateField.pure() : super.pure('');
  const DateField.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == DateError.empty) return 'El campo es requerido';
    if (displayError == DateError.format) return 'El formato debe ser MM/YY';
    if (displayError == DateError.month) return 'El mes debe estar entre 1 y 12';
    if (displayError == DateError.year) return 'El año debe ser mayor o igual al año actual';
    return null;
  }

  @override
  DateError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DateError.empty;
    final partes = value.split('/');
    if (partes.length != 2) return DateError.format;
    final mes = int.tryParse(partes[0]);
    final anio = int.tryParse(partes[1]);
    if (mes == null || anio == null) return DateError.format;
    if (mes < 1 || mes > 12) return DateError.month;
    final anioActual = DateTime.now().year % 100;
    if (anio < anioActual) return DateError.year;
    return null;
  }
}