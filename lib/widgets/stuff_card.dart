import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:memstuff_final/helpers/date_helper.dart';
import 'package:memstuff_final/models/stuff_model.dart';

class StuffCard extends StatelessWidget {
  final StuffModel stuff;
  final Function onUpdate;
  final Function onDelete;
  final Function onCall;

  const StuffCard({
    Key key,
    this.stuff,
    this.onUpdate,
    this.onDelete,
    this.onCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _buildCard(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Excluir',
          color: Theme.of(context).accentColor,
          icon: Icons.delete,
          onTap: onDelete,
        ),
        IconSlideAction(
          caption: 'Chamada telefônica',
          color: Theme.of(context).accentColor,
          icon: Icons.call,
          onTap: onCall,
        )
      ],
    );
  }

  _buildCard() {
    return InkWell(
      onTap: onUpdate,
      child: ListTile(
        title: Text(stuff.description ?? ''),
        subtitle: Text(stuff.contactName ?? ''),
        trailing: Container(
            padding: const EdgeInsets.only(top: 8),
            height: double.infinity,
            child: Text(DateHelper.relative(stuff.date))),
        leading: CircleAvatar(
          child: Text(stuff.description[0]),
        ),
      ),
    );
  }
}
