import 'package:formz/formz.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/validator/validator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'addCard_provider.g.dart';

@riverpod 
class AddCardProvider extends _$AddCardProvider {
  bool isValid=false;
  @override
  CardPayModel build() {
    return CardPayModel();
  }

  void setCardNumber(String number) {
    state = state.copyWith(cardNumber: CardNumberField.dirty(number));
    isValid = Formz.validate([
      state.cardNumber ?? const CardNumberField.dirty(''),
      state.cardName ?? const GeneralField.pure(),
      state.cardDate ?? const DateField.pure(),
      state.cardCvc ?? const NumberInput.pure(),
    ]);
  }

  void setCardName(String name) {
    state = state.copyWith(cardName: GeneralField.dirty(name));
    isValid = Formz.validate([
      state.cardNumber ?? const CardNumberField.pure(),
      state.cardName ?? const GeneralField.dirty(''),
      state.cardDate ?? const DateField.pure(),
      state.cardCvc ?? const NumberInput.pure(),
    ]);
  }

  void setCardDate(String date) {
    state = state.copyWith(cardDate: DateField.dirty(date));
    isValid = Formz.validate([
      state.cardNumber ?? const CardNumberField.pure(),
      state.cardName ?? const GeneralField.pure(),
      state.cardDate ?? const DateField.dirty(''),
      state.cardCvc ?? const NumberInput.pure(),
    ]);
  }

  void setCardCvv(String cvv) {
    state = state.copyWith(cardCvc: NumberInput.dirty(cvv));
    isValid = Formz.validate([
      state.cardNumber ?? const CardNumberField.pure(),
      state.cardName ?? const GeneralField.pure(),
      state.cardDate ?? const DateField.pure(),
      state.cardCvc ?? const NumberInput.dirty(''),
    ]);
  }

  void reset() {
    state = CardPayModel();
  }

} 