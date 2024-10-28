import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'expand_filter_state.dart';

class ExpandFilterCubit extends Cubit<ExpandFilterState> {
  ExpandFilterCubit() : super(ExpandFilterState.init());
  void changeExpandedFilter() {
    emit(state.copyWitch(isExpandFilter: !state.isExpandFilter));
  }
}
