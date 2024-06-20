import 'package:meeting_module2/services/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/Network/api_services.dart';

class FieldActivityRepo {
  final SharedPreferences prefs;
  final ApiService _api;

  FieldActivityRepo(this._api, this.prefs);

  fetchStatesCity() async {
    Map<String, dynamic> data = {};
    var res = await _api.getRequest("${Endpoints.getStateCity}", data: data);
    if (res == null) {
      throw "no data found";
    }
    return res;
  }
  //this is to fetch cities based on state id
  fetchCitiesBasedOnId(int? id) async {
    Map<String, dynamic> data =
    {
      "state_id" : id
    };
    var res = await _api.postRequest("city", data);
    print(res);
    if (res == null) {
      throw "no data found";
    }
    return res;
  }

  fetchAffiliationsBasedOnId(dynamic id) async {
    Map<String, dynamic> data =
    {
      "state_id" : id
    };
    var res = await _api.postRequest("get-affiliations", data);
    print(res);
    if (res == null) {
      throw "no data found";
    }
    return res;
  }
  // fetchInstituteType() async {
  //   Map<String, dynamic> data =
  //   {};
  //   var res = await _api.getRequest("show-offline-institute-type", data: data);
  //   print(res);
  //   if (res == null) {
  //     throw "no data found";
  //   }
  //   return res;
  // }

  postAddInstitute(int stateId, int cityId, int type, String category, int affiliationId, String instituteName, String address, String landmark, String pinCode ) async{
    Map<String, dynamic> data =
    {
      "state_id": stateId,
      "city_id": cityId,
      "institute_type": type,
      "inst_sub_category": category,
      "affiliation_id": affiliationId,
      "university_name": instituteName,
      "univ_address": address,
      "landmark": landmark,
      "pincode": pinCode
    };

    var res = await _api.postRequest("add-institute", data);
    print(res);
    if(res == null){
      throw "Could Not add Institute";
    }
    return res;
  }
  
  
  searchNames(int pinCode) async{
    Map<String, dynamic> data = {
      "pincode": pinCode
    };
    var res = await _api.postRequest("search-institute", data);
    if(res ==null){
      throw "no University Found";
    }
    return res;
  }
}
