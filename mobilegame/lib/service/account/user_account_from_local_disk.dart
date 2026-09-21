import 'package:mobilegame/service/account/user_account.dart';

class UserAccountFromLocalDisk implements UserAccount {
  @override
  Future<String> fetchData() async => "Account API :) ";
}