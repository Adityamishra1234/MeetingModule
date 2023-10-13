import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:meeting_module2/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

setupDI() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<ApiServices>(ApiServices());

  // locator.registerLazySingleton<DashboardBloc>(() => DashboardBloc(
  //     sharedPreferences: locator<SharedPreferences>(),
  //     api: locator<ApiServices>()));

  locator.registerSingleton(() => null);
}
