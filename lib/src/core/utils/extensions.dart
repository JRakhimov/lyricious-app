import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

T getCubit<T extends Object>(BuildContext context) {
  return context.read<T>();
}
