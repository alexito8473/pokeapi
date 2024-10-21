import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';

class ListItemsScreen extends StatelessWidget {
  const ListItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataItemBloc,DataItemState>(builder: (context, state) {
      return ListView.builder(
        itemCount: state.listItems.length,
        itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              Text(state.listItems[index].name),
              Image.network(state.listItems[index].sprite)
            ],
          ),
        );
      },);
    },);
  }
}
