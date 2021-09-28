import 'dart:math';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TansactionItem extends StatefulWidget {
  const TansactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TansactionItemState createState() => _TansactionItemState();
}

class _TansactionItemState extends State<TansactionItem> {
  Color _bgColor;
  @override
  void initState() {
    const availableColors=[Colors.red,Colors.blue,Colors.purple,Colors.green];
    _bgColor=availableColors[Random().nextInt(4)];
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card
    (
      margin: EdgeInsets.symmetric(vertical:10,horizontal:5),
      elevation: 5,
        child: ListTile(
          leading:CircleAvatar(
          backgroundColor: _bgColor,
        radius:30,
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(child: Text('\$${widget.transaction.amount}')),
        ),),
        title: Text(widget.transaction.title,
        style:Theme.of(context).textTheme.title ,),
        subtitle: Text(DateFormat.yMMM().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width >300?
        FlatButton.icon(
          textColor: Theme.of(context).errorColor,
          label: Text('Delete'),
          icon: Icon(Icons.delete),
          onPressed: ()=>widget.deleteTx(widget.transaction.id),
          )
        :IconButton(icon: Icon(Icons.delete),
        color: Theme.of(context).errorColor,
         onPressed: ()=>widget.deleteTx(widget.transaction.id)),),
    );
  }
}