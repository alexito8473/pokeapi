import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/data/model/item.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';
import 'package:pokeapi/domain/cubit/filterItems/filter_items_cubit.dart';
import 'package:pokeapi/presentation/widgets/item_widget.dart';

class GridItemsScreen extends StatelessWidget {
  const GridItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<DataItemBloc, DataItemState>(builder: (context, state) {
      return DefaultTabController(
          length: ItemAttribute.values.length,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .1,
                child: SingleChildScrollView(
                  child: TabBar(
                      onTap: (value) {
                        context.read<FilterItemsCubit>().changeItemAttribute(
                            itemAttribute: ItemAttribute.values[value]);
                      },
                      tabs: List.generate(
                        ItemAttribute.values.length,
                        (index) {
                          return Tab(
                            text: ItemAttribute.values[index].name,
                            icon: Icon(Icons.cloud_outlined),
                          );
                        },
                      )),
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: List.generate(
                  ItemAttribute.values.length,
                  (index) {
                    return CustomScrollView(
                      slivers: [
                        SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: state
                              .getSpecificListItem(ItemAttribute.values[index])
                              .length,
                          itemBuilder: (context, index2) {
                            return ItemWidget(
                                item: state.getSpecificListItem(
                                    ItemAttribute.values[index])[index2]);
                          },
                        )
                      ],
                    );
                  },
                ),
              ))
            ],
          ));
    });
  }
}
//        child: Column(
//           children: [
//           SizedBox(
//           height: 200,
//           child: CustomScrollView(scrollDirection: Axis.horizontal, slivers: [
//             SliverPadding(
//                 padding: EdgeInsets.only(
//                     top: size.height * 0.01,
//                     bottom: size.height * 0.15,
//                     left: size.width * 0.05,
//                     right: size.width * 0.05),
//                 sliver: SliverList.builder(
//                     itemCount: ItemAttribute.values.length,
//                     itemBuilder: (context, index) => CardItemWidget(
//                         itemAttribute: ItemAttribute.values[index],
//                         isActive: ItemAttribute.values[index] ==
//                             state.currentAttribute)))
//           ]),
//         ),
//           Expanded(
//               child:Tap SingleChildScrollView(
//           child: Column(
//           children:  List.generate(
//               context.read<DataItemBloc>().currentListItem().length,
//               (index) {
//             print(state.listItemsCountable);
//             return ItemWidget(
//                 item:
//                 context.read<DataItemBloc>().currentListItem()[index]);
//           }),
//       ),
//       ) ,
//       ),
//       ],
//       ),
