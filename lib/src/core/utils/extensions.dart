import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

T inject<T extends Object>() {
  return GetIt.I.get<T>();
}

T getCubit<T extends Object>(BuildContext context) {
  return context.read<T>();
}
