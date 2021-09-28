import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter4_planner/widgets/adaptive_button.dart';

import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController=TextEditingController();

  final amountController=TextEditingController();
  DateTime _selectedDate;

  void submitData()
  {
   final enteredTitle=titleController.text;
   final enteredAmount=double.parse(amountController.text);
   if(enteredTitle.isEmpty||enteredAmount <=0||_selectedDate==null)
   {
     return;
   }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );
    Navigator.of(context).pop();
  }
  void _presentDayPicker(){
    showDatePicker(context: context,
     initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      ).then((pickedData) {
          if(pickedData==null)
          return;
          setState(() {
            _selectedDate=pickedData;
          });
          
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
              elevation: 18,
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.only(
                  top: 10,right: 10, left: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom +10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'title'),
                     // onChanged: (val)=>titleInput=val,
                     controller: titleController,
                     onSubmitted: (_) => submitData(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'amount'),
                      //onChanged: (val)=>amountInput=val,
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => submitData(),
                    ),
                    Container(height:70,
                      child: Row(children: [
                        Expanded(
                                                child: Text(_selectedDate==null ?"no date chosen":
                       'Picked data : ${DateFormat.yMd().format(_selectedDate)}',),
                        ),
                        AdaptiveFlatButton("Choose date", _presentDayPicker)                    
                      ],),
                    ),
                    RaisedButton(
                      child: Text('Add transaction'),
                      textColor: Theme.of(context).textTheme.button.color,
                      color: Theme.of(context).primaryColor,
                      onPressed:submitData,
                    ),
                  ],
                ),
              ),
            ),
    );
      
    
  }
}