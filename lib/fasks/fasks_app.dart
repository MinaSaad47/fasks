import 'package:cache/cache.dart';
import 'package:fasks/fasks/fasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_db_tasks_api/sqlite_db_tasks_api.dart';
import 'package:tasks_repository/tasks_repository.dart';

class FasksApp extends StatelessWidget {
  final Cache _cache;
  final ThemeMode _themeMode;
  final SqliteDbTasksApi _sqliteDbTasksApi;

  const FasksApp({
    Key? key,
    required Cache cache,
    required ThemeMode themeMode,
    required SqliteDbTasksApi sqliteDbTasksApi,
  })  : _cache = cache,
        _sqliteDbTasksApi = sqliteDbTasksApi,
        _themeMode = themeMode,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TasksRepository(_sqliteDbTasksApi),
      child: BlocProvider(
        create: (context) => FasksBloc(cache: _cache, themeData: _themeMode),
        child: const FasksView(),
      ),
    );
  }
}
