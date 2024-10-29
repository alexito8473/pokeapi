import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/data/model/item.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';
import 'package:pokeapi/domain/cubit/connectivity/connectivity_cubit.dart';
import 'package:pokeapi/domain/cubit/expandFilters/expand_filter_cubit.dart';
import 'package:pokeapi/domain/cubit/filterItems/filter_items_cubit.dart';
import 'package:pokeapi/presentation/widgets/item_widget.dart';

class GridItemsScreen extends StatelessWidget {
  const GridItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool openFilter = context.watch<ExpandFilterCubit>().state.isExpandFilter;
    return BlocBuilder<DataItemBloc, DataItemState>(builder: (context, state) {
      List<Item>? listItems = context.read<DataItemBloc>().getItems(
          clave: context.read<FilterItemsCubit>().state.listItemCategory.name);
      return Column(children: [
        AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: openFilter ? size.height * 0.75 : size.height * .1,
            child: SingleChildScrollView(
                scrollDirection: openFilter ? Axis.vertical : Axis.horizontal,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: Wrap(
                        children: List.generate(ListItemCategory.values.length,
                            (index) {
                      return CardItemWidget(
                          itemCategory: ListItemCategory.values[index],
                          isActive: ListItemCategory.values[index] ==
                              context
                                  .watch<FilterItemsCubit>()
                                  .state
                                  .listItemCategory,
                          function: () {
                            context
                                .read<FilterItemsCubit>()
                                .changeItemAttribute(
                                    listItemCategory:
                                        ListItemCategory.values[index]);
                            context.read<DataItemBloc>().add(DataItemEvent(
                                haveWifi: true,
                                itemCategory: context
                                    .read<FilterItemsCubit>()
                                    .state
                                    .listItemCategory));
                          });
                    }))))),
        Expanded(
            child: CustomScrollView(slivers: [
          SliverPadding(
              padding: EdgeInsets.only(
                  bottom: size.height * 0.15,
                  left: size.width * 0.05,
                  right: size.width * 0.05),
              sliver: listItems == null
                  ? const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1),
                      itemCount: listItems.length,
                      itemBuilder: (context, index) =>
                          ItemWidget(item: listItems[index])))
        ]))
      ]);
    });
  }
}
