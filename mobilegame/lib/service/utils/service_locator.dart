import 'package:get_it/get_it.dart';
import 'package:mobilegame/service/account/user_account.dart';
import 'package:mobilegame/service/account/user_account_from_local_disk.dart';

final GetIt locator = GetIt.instance;


void setupLocator() {
  
  locator.registerLazySingleton<UserAccount>(() => UserAccountFromLocalDisk());
}