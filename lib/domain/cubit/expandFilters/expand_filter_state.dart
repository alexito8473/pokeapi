part of 'expand_filter_cubit.dart';

class ExpandFilterState {
  final bool isExpandFilter;
  const ExpandFilterState({required this.isExpandFilter});
  factory ExpandFilterState.init() {
    return const ExpandFilterState(isExpandFilter: false);
  }
  ExpandFilterState copyWitch({required bool? isExpandFilter}) {
    return ExpandFilterState(
        isExpandFilter: isExpandFilter ?? this.isExpandFilter);
  }
  IconData getIcon(){
    return isExpandFilter?Icons.compress:Icons.expand;
  }
}
