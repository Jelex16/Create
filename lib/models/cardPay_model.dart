import 'package:match_home_client/shared/validator/validator.dart';

class CardPayModel {
  CardNumberField? cardNumber;
  GeneralField? cardName;
  DateField? cardDate;
  NumberInput? cardCvc;

  CardPayModel({
    this.cardNumber,
    this.cardName,
    this.cardDate,
    this.cardCvc,
  });

  CardPayModel.fromJson(Map<String, dynamic> json){
     cardNumber = json['cardNumber'] != null ? CardNumberField.dirty(json['cardNumber']) : const CardNumberField.dirty('');
      cardName = json['cardName'] != null ? GeneralField.dirty(json['cardName']) : const GeneralField.dirty('');
      cardDate = json['cardDate'] != null ? DateField.dirty(json['cardDate']) : const DateField.dirty('');
      cardCvc = json['cardCvc'] != null ? NumberInput.dirty(json['cardCvc']) : const NumberInput.dirty('');
  }
  Map<String, dynamic> toJson() => {  
    'cardNumber': cardNumber?.value, 
    'cardName': cardName?.value, 
    'cardDate': cardDate?.value, 
    'cardCvc': cardCvc?.value,
  };

  CardPayModel copyWith({
    CardNumberField? cardNumber,
    GeneralField? cardName,
    DateField? cardDate,
    NumberInput? cardCvc,
  }) {
    return CardPayModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardName: cardName ?? this.cardName,
      cardDate: cardDate ?? this.cardDate,
      cardCvc: cardCvc ?? this.cardCvc,
    );
  }

}