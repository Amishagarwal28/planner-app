import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double spendAmount;
  final spendingPct;
  ChartBar(this.day, this.spendAmount, this.spendingPct);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(ctx,constraints){
      return Container(
      child: Column(
        children: [
          Container(height:constraints.maxHeight*.15,
          child: FittedBox
          (child: Text('\$${spendAmount.toStringAsFixed(1)}  '))),
          SizedBox(
            height: constraints.maxHeight*.05,
          ),
          Container(
              height: constraints.maxHeight*.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                         color: Color.fromRGBO(220, 220, 220, 1),
                         borderRadius:BorderRadius.circular(4),)),

                         FractionallySizedBox(
                           heightFactor:spendingPct,
                           child: Container (
                           decoration:BoxDecoration(
                             color: Theme.of(context).primaryColor,
                         borderRadius:BorderRadius.circular(4)),),)
                ],
              ),),
              SizedBox(height:constraints.maxHeight*.05),
              Container(height: constraints.maxHeight*.15,
                child: FittedBox(child: Text(day))),
        ],
      ),
    );
    },);
      
  }
}
