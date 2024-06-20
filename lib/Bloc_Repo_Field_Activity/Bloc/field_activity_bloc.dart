import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';

import '../../models/addInstituteModel.dart';
import '../../models/allStatesModel.dart';
import '../../models/searchInstituteModel.dart';
import '../../ui/controller/create_new_meeting_controller2.dart';
import '../Repo/get_field_activity_repo.dart';

class FieldActivityBloc {
  FieldActivityRepo _repo;

  FieldActivityBloc(this._repo);

  var controller = Get.put(CreateNewMeetingController2());

  int? stateId;
  String? selectedStateName;
  ValueNotifier<bool> loadingStatesAndCities = ValueNotifier(true);
  ValueNotifier<AllStatesModel> statesData = ValueNotifier(AllStatesModel());
  List<AllStatesModel> allStatesData = [];
  List<String> stateNames = [];

  Future getAllStatesCities() async {
    try {
      if (loadingStatesAndCities.value == true) {
        var res = await _repo.fetchStatesCity();
        if (res != null) {
          allStatesData.clear();
          AllStatesModel model = AllStatesModel.fromJson(res);
          allStatesData.add(model);

          if (allStatesData.isNotEmpty && allStatesData[0].data != null) {
            stateNames.clear();
            for (int i = 0; i < allStatesData[0].data!.length; i++) {
              stateNames.add('${allStatesData[0].data?[i].stateName}');
            }
          }
          // selectedStateName = stateNames[0];
        }
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
    } finally {
      loadingStatesAndCities.value = false;
      // await getAllCities(stateId);
      // await getAllAffiliationName(stateId);
    }
  }

  //this is for fetching cities based on the state-id
  String? selectedCityName;
  int? cityId;
  ValueNotifier<bool> loadingCities = ValueNotifier(true);
  ValueNotifier<CityModel> citiesData = ValueNotifier(CityModel());
  List<CityModel> allCitiesData = [];
  List<String> cityNames = [];

  Future getAllCities(int? id) async {
    loadingCities.value = true;
    try {
      if (loadingCities.value == true) {
        var res = await _repo.fetchCitiesBasedOnId(id);
        if (res != null) {
          allCitiesData.clear();
          CityModel model = CityModel.fromJson(res);
          allCitiesData.add(model);
          cityNames.clear();
          for (int i = 0; i < allCitiesData[0].data1!.length; i++) {
            cityNames.add('${allCitiesData[0].data1?[i].cityName}');
          }
        }
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
    } finally {
      loadingCities.value = false;
    }
  }

  String? selectedAffiliationName;
  int? affiliationId;
  ValueNotifier<bool> loadingAffiliationName = ValueNotifier(true);
  ValueNotifier<AllAffiliationModel> AffiliationNameData =
      ValueNotifier(AllAffiliationModel());
  List<AllAffiliationModel> allAffiliationNameData = [];
  List<String> AffiliationNames = [];

  Future getAllAffiliationName(dynamic id) async {
    loadingAffiliationName.value = true;
    try {
      if (loadingAffiliationName.value == true) {
        var res = await _repo.fetchAffiliationsBasedOnId(id);
        if (res != null) {
          allAffiliationNameData.clear();
          AllAffiliationModel model = AllAffiliationModel.fromJson(res);
          allAffiliationNameData.add(model);
          AffiliationNames.clear();
          for (int i = 0; i < allAffiliationNameData[0].data3!.length; i++) {
            AffiliationNames.add(
                '${allAffiliationNameData[0].data3?[i].affiliationName}');
          }
        }
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
    } finally {
      loadingAffiliationName.value = false;
    }
  }

//fetching institute type
  List<String> instituteTypes = [];
  ValueNotifier<AddInstituteModel> addedInstituteData =
      ValueNotifier(AddInstituteModel());
  List<AddInstituteModel> addedInstituteResponse = [];

  Future postAdd(
      int stateId,
      int cityId,
      int type,
      String category,
      int affiliationId,
      String instituteName,
      String address,
      String landmark,
      String pinCode,
      BuildContext context) async {
    getLoading(context);
    if (
    stateId == null ||
            cityId ==null ||
            type ==null  ||
            category.isEmpty ||
        affiliationId ==null ||
        instituteName.isEmpty && address.isEmpty && pinCode.isEmpty) {
      return false;
    }
    try {
      var res = await _repo.postAddInstitute(stateId, cityId, type, category,
          affiliationId, instituteName, address, landmark, pinCode);
      if (res != null) {
        AddInstituteModel model = AddInstituteModel.fromJson(res);
        addedInstituteResponse.add(model);
        return true;
      }
    } catch (e, s) {
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
      return false;
    } finally {
      loadingAffiliationName.value = false;
      return false;
    }
  }



  List<String> universityNames = [];
  ValueNotifier<SearchInstituteModel> searchedUniversityData = ValueNotifier(SearchInstituteModel());
  List<SearchInstituteModel> searchedUniversityNames = [];
  ValueNotifier<bool> loadingUniversityNames = ValueNotifier(false);
  Future searchUniversityNames (int pinCode) async{
    loadingUniversityNames.value = true;
    try{
      if(loadingUniversityNames.value == true){
        var res = await _repo.searchNames(pinCode);
        if(res != null){
          universityNames.clear();
          searchedUniversityNames.clear();
          SearchInstituteModel model = SearchInstituteModel.fromJson(res);
          searchedUniversityNames.add(model);
          controller.instituteUniversityNames.clear();
          var lengths = searchedUniversityNames[0].data!.length;

          for(int i = 0; i< lengths; i++){
            // universityNames.add("${searchedUniversityNames[0].data?[i].universityName}");
            controller.instituteUniversityNames.add("${searchedUniversityNames[0].data?[i].universityName}");
          }
          controller.update();
        }
      }
    }
    catch(e,s){
      debugPrint('$e');
      debugPrintStack(stackTrace: s);
    }
    finally{
      loadingUniversityNames.value = false;
    }
  }


}
