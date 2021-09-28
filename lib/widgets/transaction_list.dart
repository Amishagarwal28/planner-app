import 'package:flutter/material.dart';
import 'package:flutter4_planner/models/transaction.dart';

import './tansaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction>transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);
 
 
  @override
  Widget build(BuildContext context) {
        final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    return transactions.isEmpty?
    LayoutBuilder(builder: (ctx,constraints){
      return Column(children: [
        Text('transactoions are empty',
        style: Theme.of(context).textTheme.title,),
        SizedBox(height:20,),
        isLandscape ? Container(height:constraints.maxHeight*.7,
        child: Image.asset('assets/images/Screenshot(13).png',fit: BoxFit.cover,),)
        :Container(height:constraints.maxHeight*.3 ,
        child:
        Image.asset('assets/images/Screenshot(13).png',fit: BoxFit.cover),),],
        );
      
    })
     :ListView(children: [
           ...transactions.map((tx) => 
           TansactionItem(transaction: tx,
            deleteTx: deleteTx)).toList() ,
          // Card(
          //           child: Row(
          //         children: [
          //           Container(
          //             margin: EdgeInsets.symmetric(
          //               horizontal: 10,
          //               vertical: 15,
          //             ),
          //             decoration: BoxDecoration(
          //                 border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
          //             padding: EdgeInsets.all(10),
          //             child: Text(
          //               "\$" + transactions[index].amount.toStringAsFixed(2),
          //               style: TextStyle(
          //                   color: Theme.of(context).primaryColor,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 20),
          //             ),
          //           ),
          //           Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   transactions[index].title,
          //                   style: Theme.of(context).textTheme.title,
          //                 ),
          //                 Text(
          //                   DateFormat.yMd().format(transactions[index].date),
          //                   style: TextStyle(color: Colors.purple),
          //                 ),
          //               ])
          //         ],
          //       ));
          
        ],
        // itemCount: transactions.length,
             
            );
    
      
    
  }
}

