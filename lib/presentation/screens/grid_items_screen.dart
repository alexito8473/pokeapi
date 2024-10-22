import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';
import 'package:pokeapi/presentation/widgets/item_widget.dart';

class GridItemsScreen extends StatelessWidget {
  const GridItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<DataItemBloc, DataItemState>(
      builder: (context, state) {
        return CustomScrollView(slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
                top: size.height * 0.01,
                bottom: size.height * 0.15,
                left: size.width * 0.05,
                right: size.width * 0.05),
            sliver: SliverGrid.builder(
              itemCount: state.listItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return ItemWidget(item: state.listItems[index]);
              },
            ),
          ),
        ]);
      },
    );
  }
}
