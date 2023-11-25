import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:meeting_module2/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:meeting_module2/presentation/meeting_notes_task/bloc/notes_task_bloc.dart';
import 'package:meeting_module2/presentation/meeting_notes_task/view/meeting_notes_taskk_view.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

setupDI() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<ApiServices>(ApiServices());
  locator.registerFactory<NotesTaskBloc>(
      () => NotesTaskBloc(api: locator.get<ApiServices>()));

  // locator.registerLazySingleton<DashboardBloc>(() => DashboardBloc(
  //     sharedPreferences: locator<SharedPreferences>(),
  //     api: locator<ApiServices>()));

  locator.registerSingleton(() => null);
}
