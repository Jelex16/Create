import 'package:formz/formz.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/validator/validator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'offer_provider.g.dart';

@riverpod
class OfferCreate extends _$OfferCreate {
  bool isValid = false;
  @override
  OfferCreateModel build() {
    return OfferCreateModel();
  }

  void setIsSale(bool isSale) {
    state = state.copyWith(isSale: isSale);
  }

  void setEstado(String estado) {
    state = state.copyWith(estado: GeneralField.dirty(estado));
    isValid = Formz.validate([
      state.estado ?? const GeneralField.pure(),
      state.municipio ?? const GeneralField.pure(),
      state.colonia ?? const GeneralField.pure(),
      state.precio ?? const NumberInput.pure(),
      state.attributo1 ?? const GeneralField.pure(),
      state.attributo2 ?? const GeneralField.pure(),
    ]);
  }

  void setMunicipio(String municipio) {
    state = state.copyWith(municipio: GeneralField.dirty(municipio));
    isValid = Formz.validate([
      state.estado ?? const GeneralField.pure(),
      state.municipio ?? const GeneralField.pure(),
      state.colonia ?? const GeneralField.pure(),
      state.precio ?? const NumberInput.pure(),
      state.attributo1 ?? const GeneralField.pure(),
      state.attributo2 ?? const GeneralField.pure(),
    ]);
  }

  void setColonia(String colonia) {
    state = state.copyWith(colonia: GeneralField.dirty(colonia));
    isValid = Formz.validate([
      state.estado ?? const GeneralField.pure(),
      state.municipio ?? const GeneralField.pure(),
      state.colonia ?? const GeneralField.pure(),
      state.precio ?? const NumberInput.pure(),
      state.attributo1 ?? const GeneralField.pure(),
      state.attributo2 ?? const GeneralField.pure(),
    ]);
  }

  void setPrecio(String precio) {
    state = state.copyWith(precio: NumberInput.dirty(precio));
    isValid = Formz.validate([
      state.estado ?? const GeneralField.pure(),
      state.municipio ?? const GeneralField.pure(),
      state.colonia ?? const GeneralField.pure(),
      state.precio ?? const NumberInput.pure(),
      state.attributo1 ?? const GeneralField.pure(),
      state.attributo2 ?? const GeneralField.pure(),
    ]);
  }

  void setAttributo1(String attributo1) {
    state = state.copyWith(attributo1: GeneralField.dirty(attributo1));
    isValid = Formz.validate([
      state.estado ?? const GeneralField.pure(),
      state.municipio ?? const GeneralField.pure(),
      state.colonia ?? const GeneralField.pure(),
      state.precio ?? const NumberInput.pure(),
      state.attributo1 ?? const GeneralField.pure(),
      state.attributo2 ?? const GeneralField.pure(),
    ]);
  }

  void setAttributo2(String attributo2) {
    state = state.copyWith(attributo2: GeneralField.dirty(attributo2));
    isValid = Formz.validate([
      state.estado ?? const GeneralField.pure(),
      state.municipio ?? const GeneralField.pure(),
      state.colonia ?? const GeneralField.pure(),
      state.precio ?? const NumberInput.pure(),
      state.attributo1 ?? const GeneralField.pure(),
      state.attributo2 ?? const GeneralField.pure(),
    ]);
  }

  void setIsOffer(bool isOffer) {
    state = state.copyWith(isOffer: isOffer);
  }

  void setCategory(String category) {
    state = state.copyWith(category: category);
  }

  void setMetrosCuadrados(String metrosCuadrados) {
    state = state.copyWith(metrosCuadrados: metrosCuadrados);
  }

 /* void setMensual(int mensual) {
    state = state.copyWith(mensual: mensual);
  }*/

  Future<void> createOffert(
      List<String> images, List<RequestModel> requests) async {
    final api = ApiOffering();
    state = state.copyWith(images: images);
    await api.addOffering(state, requests);
  }
  ////
  OfferCreateModel getState() {
    return state;
  }
  ///
}

@riverpod
class IsOfferting extends _$IsOfferting {
  @override
  bool build() {
    return true;
  }

  void setIsOfferting(bool isOfferting) {
    state = isOfferting;
  }
}

@riverpod
Future<List<OfferCreateModel>> getOffering(GetOfferingRef ref,
    {bool isUpdate = false}) {
  final api = ApiOffering();
  return api.getOffering();
}

@riverpod
class IsUpdateOffering extends _$IsUpdateOffering {
  @override
  bool build() {
    return true;
  }

  void setIsUpdateOffering() {
    state = !state;
  }
}
