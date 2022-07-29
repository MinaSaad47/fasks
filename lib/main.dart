import 'package:bloc/bloc.dart';
import 'package:cache_sharedpref/cache_sharedpref.dart';
import 'package:fasks/FasksBlocObserver.dart';
import 'package:fasks/common/common.dart';
import 'package:fasks/fasks/fasks.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_db_tasks_api/sqlite_db_tasks_api.dart';

Future main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      var cache = CacheSharedPref();
      final String? themeMode = await cache.load('theme_mode');
      String docDirPath = (await getApplicationDocumentsDirectory()).path;
      String dbPath = '$docDirPath/${Consts.appName}.db';
      var sqliteDbTasksApi = await SqliteDbTasksApi.instance(dbPath);
      runApp(FasksApp(
        cache: cache,
        sqliteDbTasksApi: sqliteDbTasksApi,
        themeMode: themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light,
      ));
    },
    blocObserver: FasksBlocObserver(),
  );
}
