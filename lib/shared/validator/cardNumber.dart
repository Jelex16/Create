import 'package:formz/formz.dart';

// Define input validation errors
enum CardError { empty, length }

// Extend FormzInput and provide the input type and error type.
class CardNumberField extends FormzInput<String, CardError> {
  // Call super.pure to represent an unmodified form input.
  const CardNumberField.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const CardNumberField.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == CardError.empty) return 'El campo es requerido';
    if (displayError == CardError.length) {
      return 'El campo debe tener 16 dígitos';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CardError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return CardError.empty;
    if (value.trim().length != 16) return CardError.length;
    return null;
  }
}