import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/zipcode_searcher/controllers/zipcode_searcher/zipcode_searcher_data.dart';
import 'package:leechineo_panel/core/presenter/components/zipcode_searcher/controllers/zipcode_searcher/zipcode_searcher_form.dart';
import 'package:leechineo_panel/core/presenter/components/zipcode_searcher/controllers/zipcode_searcher/zipcode_searcher_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/address/domain/usecases/get_address_by_zipcode_usecase.dart';

class ZipcodeSearcherController<V>
    extends AppController<ZipcodeSearcherData, ZipcodeSearcherMethods> {
  late final GetAddressByZipcodeUseCase _addressByZipcodeUseCase;
  final ZipcodeSearcherForm form;

  ZipcodeSearcherController(
      {required GetAddressByZipcodeUseCase getAddressByZipcodeUseCase})
      : form = ZipcodeSearcherForm() {
    _addressByZipcodeUseCase = getAddressByZipcodeUseCase;
  }

  @override
  ZipcodeSearcherMethods defineMethods() {
    return ZipcodeSearcherMethods(
      searchZipcode: (zipcode) async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          final address = await _addressByZipcodeUseCase(zipcode);
          updateData(
            data.copyWith(
              loading: false,
            ),
          );
          return AddressEntityImpl.fromEntity(address);
        } catch (e) {
          if (e is DioException) {
            dispatchEvent(
              AppControllerEvent<String>(
                id: 'invalidAddress',
                data: e.response?.data['message'] ?? 'CEP inválido',
              ),
            );
          }
        }
        updateData(
          data.copyWith(
            loading: false,
          ),
        );
        return null;
      },
      submitForm: (onFound) async {
        final GlobalKey<FormState> key = form.formKey;
        if (key.currentState != null) {
          if (key.currentState!.validate()) {
            final AddressEntityImpl? address = await methods.searchZipcode(
              form.zipcodeController.text,
            );
            if (address != null) {
              onFound(address);
            }
          }
        }
      },
    );
  }

  @override
  ZipcodeSearcherData defineData() {
    return ZipcodeSearcherData(
      loading: false,
    );
  }
}
